library params.test;

import 'package:params/annotation.dart';
import 'package:params/accessors/accessors.dart';
import 'package:params/json_encoders/json_encoders.dart';

class Entity extends Object with Serialize {
  @ModelParameter()
  int id;

  @ModelParameter(isSubModel: true)
  Address address;

  @override
  final Map $container$ = {};
}

class Person extends Entity {
  @ModelParameter()
  String name;
}

class Address extends Object with Serialize{

  String street;

  @override
  get $container$ => {};
}