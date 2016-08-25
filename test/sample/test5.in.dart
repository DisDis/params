library params.test;

import 'package:params/annotation.dart';
import 'package:params/accessors/accessors.dart';

class SimpleTest5 extends Object with Serialize {
  @ModelParameter(name:"other_field1_name",json:'json_field1_name')
  String field1;

  @ModelParameter(accessor: DateTimeMillisecondsAccessor)
  DateTime field_date2;

  // TODO: implement $container$
  @override
  Map $container$;
}