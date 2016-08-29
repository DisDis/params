library params.test;

import 'package:params/annotation.dart';

class SimpleTest1 extends Object with Serialize {
  @ModelParameter()
  String field1;

  @override
  final Map $container$ = {};
}