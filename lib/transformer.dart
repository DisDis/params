library params;

import 'package:barback/barback.dart';
import 'package:params/src/parser_transformer.dart';


class ParamsTransformerGroup implements TransformerGroup {
  final Iterable<Iterable> phases;

  ParamsTransformerGroup(BarbackSettings settings)
  : phases = createDeployPhases(settings);

  ParamsTransformerGroup.asPlugin(BarbackSettings settings)
  : this(settings);
}

List<List<Transformer>> createDeployPhases(BarbackSettings settings) {
  List<List<Transformer>> phases = [];

  phases.addAll([
    [new ParamsParserTransformer.asPlugin(settings)]
  ]);
  return phases;
}




