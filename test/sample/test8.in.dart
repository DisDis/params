library params.test;

import 'package:params/annotation.dart';
import 'package:params/accessors/accessors.dart';

class Entity extends Object with Serialize {
  @ModelParameter()
  int id;

  @ModelParameter(accessor: AddressParamsModelAccessor, isSubModel: true)
  Address address;

  @override
  final Map $container$ = {};
}

class AddressParamsModelAccessor extends ParamsModelAccessor<Address>{
  @override
  Address create(value)=>new Address.fromMap(value);
}

class Person extends Entity {
  @ModelParameter()
  String name;
}

class Address extends Object with Serialize{
  @ModelParameter()
  String street;

  @override
  final Map $container$;
  Address():this.$container$ = {};
  Address.fromMap(this.$container$);
}