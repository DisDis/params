library params.test;

import 'package:params/annotation.dart';

class SimpleTest4 extends Object with Serialize {
  set field1(String value)=>this[r'other_field1_name']=(value);
String get field1=>(this[r'other_field1_name']);

  set field2(int value)=>this[r'other_field2_name']=(value);
int get field2=>(this[r'other_field2_name']);

  set field3(bool value)=>this[r'field3']=(value);
bool get field3=>(this[r'field3']);
Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){var _$$tmp_$$_;if (_$$result_$$_ == null){ _$$result_$$_ = new Map<String, dynamic>();}_$$tmp_$$_ = (field1);if (_$$tmp_$$_!=null){_$$result_$$_[r'json_field1_name']=_$$tmp_$$_;}_$$tmp_$$_ = (field2);if (_$$tmp_$$_!=null){_$$result_$$_[r'field2']=_$$tmp_$$_;}_$$tmp_$$_ = (field3);if (_$$tmp_$$_!=null){_$$result_$$_[r'json_field3_name']=_$$tmp_$$_;}return super.toJson(_$$result_$$_);}}