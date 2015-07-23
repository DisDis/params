library params.test;

import 'package:params/annotation.dart';

class DateTimeConv extends Converter {}

class FolderCloneParameters extends Object with Serialize {
  @ModelParameter(name: "otherName", converter: DateTimeConv)
  String sourceFolderId;

  @ModelParameter()
  String noModelParameterName;

  final $container$;
  FolderCloneParameters(this.$container$);
}
