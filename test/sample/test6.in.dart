library params.test;

import 'package:params/annotation.dart';
import 'package:params/accessors/accessors.dart';
import 'package:params/json_encoders/json_encoders.dart';

class Task extends Object with Serialize {
  @ModelParameter()
  String title;

  @ModelParameter(accessor: DateTimeMillisecondsAccessor, jsonEncoder: ToStringJSONEncoder)
  DateTime create;

  @ModelParameter(accessor: UserParamsModelAccessor, isSubModel: true)
  User creator;

  @override
  final $container$ = {};
}

class UserParamsModelAccessor extends ParamsModelAccessor<User>{
  @override
  User create(value)=>new User.fromMap(value);
}

class User extends Object with Serialize {
  @ModelParameter()
  String firstName;
  @ModelParameter()
  String lastName;

  @ModelParameter(jsonSkipEmpty:false)
  String sName;

  @override
  final $container$;
  User():this.$container$ = {};
  User.fromMap(this.$container$);
}