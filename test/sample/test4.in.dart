library params.test;

import 'package:params/annotation.dart';

class SimpleTest4 extends Object with Serialize {
  @ModelParameter(name:"other_field1_name",json:'json_field1_name')
  String field1;

  @ModelParameter(name:"other_field2_name")
  int field2;

  @ModelParameter(json:'json_field3_name')
  bool field3;
}