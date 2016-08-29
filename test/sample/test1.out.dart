library params.test;

import 'package:params/annotation.dart';

class SimpleTest1 extends Object with Serialize {
  set field1(String value)=>this[r'field1']=(value);
String get field1=>(this[r'field1']);

  @override
  final Map $container$ = {};
Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){var _$$tmp_$$_;if (_$$result_$$_ == null){ _$$result_$$_ = new Map<String, dynamic>();}_$$tmp_$$_ = (field1);if (_$$tmp_$$_!=null){_$$result_$$_[r'field1']=_$$tmp_$$_;}return super.toJson(_$$result_$$_);}}