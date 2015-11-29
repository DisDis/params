library params.test;

import 'package:params/annotation.dart';

class SimpleTest3 extends Object with Serialize {
  @ModelParameter(name:"other_field1_name",json:'json_field1_name')
  String field1;
}