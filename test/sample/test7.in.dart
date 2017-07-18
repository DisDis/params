library params.test;

import 'package:params/annotation.dart';

class Entity extends Object with Serialize {
  @ModelParameter()
  int id;

  @override
  final Map $container$ = {};
}

class Person extends Entity {
  @ModelParameter()
  String name;
}