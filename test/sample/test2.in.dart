library params.test;

import 'package:params/annotation.dart';

class SimpleTest2 extends Object with Serialize {
  @ModelParameter(name:"other_field1_name")
  String field1;
}