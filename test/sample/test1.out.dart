library params.test;

import 'package:params/annotation.dart';

class SimpleTest1 extends Object with Serialize {
  set field1(String value)=>this[r'field1']=(value);
String get field1=>(this[r'field1']);
dynamic toJson(){var _$$tmp_$$_;var _$$result_$$_ = {};_$$tmp_$$_ = (field1);if (_$$tmp_$$_!=null){_$$result_$$_[r'field1']=_$$tmp_$$_;}return _$$result_$$_;}}