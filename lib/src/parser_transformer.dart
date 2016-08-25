library params.transformer;

import 'dart:async';

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/src/generated/ast.dart';
import 'package:barback/barback.dart';
import 'package:code_transformers/messages/build_logger.dart';
import 'package:source_maps/refactor.dart';
import 'package:source_span/source_span.dart';

part 'collect_fields_visitor.dart';
part 'accessor_info.dart';
part 'field_info.dart';
part 'class_info.dart';
part 'accessor_registry.dart';
part 'json_encoder_registry.dart';
part 'json_encoder_info.dart';

class ParamsParserTransformer extends Transformer {
  final bool releaseMode;
  final List<String> _files;
  static const String FIELD_ANNOTATION = "ModelParameter";
  ParamsParserTransformer(
      {List<String> files, bool releaseMode, bool injectBuildLogsInOutput})
      : _files = files,
        releaseMode = releaseMode == true;
  ParamsParserTransformer.asPlugin(BarbackSettings settings)
      : _files = _readFiles(settings.configuration['files']),
        releaseMode = settings.mode ==
            BarbackMode.RELEASE;

  static List<String> _readFiles(value) {
    if (value == null) return null;
    var files = [];
    bool error;
    if (value is List) {
      files = value;
      error = value.any((e) => e is! String);
    } else if (value is String) {
      files = [value];
      error = false;
    } else {
      error = true;
    }
    if (error) print('Invalid value for "files" in the observe transformer.');
    return files;
  }

  // TODO(nweiz): This should just take an AssetId when barback <0.13.0 support
  // is dropped.
  Future<bool> isPrimary(idOrAsset) {
    var id = idOrAsset is AssetId ? idOrAsset : (idOrAsset as Asset).id;
    return new Future.value(id.extension == '.dart' &&
        (_files == null || _files.contains(id.path)));
  }

  Future apply(Transform transform) {
    return transform.primaryInput.readAsString().then((content) {
      // Do a quick string check to determine if this is this file even
      // plausibly might need to be transformed. If not, we can avoid an
      // expensive parse.
      if (!annotationMatcher.hasMatch(content)) return null;

      var id = transform.primaryInput.id;
      // TODO(sigmund): improve how we compute this url
      var url = id.path.startsWith('lib/')
          ? 'package:${id.package}/${id.path.substring(4)}'
          : id.path;
      var sourceFile = new SourceFile(content, url: url);
      var logger =
          new BuildLogger(transform, convertErrorsToWarnings: !releaseMode);
      var transaction = _transformCompilationUnit(content, sourceFile, logger);
      if (!transaction.hasEdits) {
        transform.addOutput(transform.primaryInput);
      } else {
        var printer = transaction.commit();
        printer.build(url);
//        print(printer.text);
        transform.addOutput(new Asset.fromString(id, printer.text));
      }

    });
  }

  TextEditTransaction _transformCompilationUnit(
      String inputCode, SourceFile sourceFile, BuildLogger logger) {
    var unit = parseCompilationUnit(inputCode, suppressErrors: true);
    var code = new TextEditTransaction(inputCode, sourceFile);
    AccessorRegistry aRegistry = new AccessorRegistry();
    JSONEncoderRegistry jsonRegistry = new JSONEncoderRegistry();
    for (var declaration in unit.declarations) {
      if (declaration is ClassDeclaration ) {
        ClassInfo ci = new ClassInfo(aRegistry, jsonRegistry, declaration);
        ci.transform(code);
      }
    }
    return code;
  }

}

bool _hasModelParameter(AnnotatedNode node) =>
    node.metadata.any(_isModelParameterAnnotation);

Annotation _getModelParameterAnnotation(AnnotatedNode node) =>
  node.metadata.firstWhere(_isModelParameterAnnotation, orElse:()=>null);


bool _isModelParameterAnnotation(Annotation node) =>
    _isAnnotationType(node, ParamsParserTransformer.FIELD_ANNOTATION);

bool _isAnnotationType(Annotation m, String name) => m.name.name == name;




SimpleIdentifier _getSimpleIdentifier(Identifier id) =>
    id is PrefixedIdentifier ? id.identifier : id;

final annotationMatcher = new RegExp("@(${ParamsParserTransformer.FIELD_ANNOTATION})");
