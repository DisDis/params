library params.test;

import 'package:params/annotation.dart';

class SimpleTest3 extends Object with Serialize {
  set field1(String value)=>this[r'other_field1_name']=(value);
String get field1=>(this[r'other_field1_name']);
dynamic toJson(){var _$$tmp_$$_;var _$$result_$$_ = {};_$$tmp_$$_ = (field1);if (_$$tmp_$$_!=null){_$$result_$$_[r'json_field1_name']=_$$tmp_$$_;}return _$$result_$$_;}}