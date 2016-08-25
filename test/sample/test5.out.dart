library params.test;

import 'package:params/annotation.dart';
import 'package:params/accessors/accessors.dart';

class SimpleTest5 extends Object with Serialize {
  set field1(String value)=>this[r'other_field1_name']=(value);
String get field1=>(this[r'other_field1_name']);

  set field_date2(DateTime value)=>this[r'field_date2']=_$accessor_2$_.set(value);
DateTime get field_date2=>_$accessor_2$_.get(this[r'field_date2']);
static final DateTimeMillisecondsAccessor _$accessor_2$_ = new DateTimeMillisecondsAccessor();Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){var _$$tmp_$$_;if (_$$result_$$_ == null){ _$$result_$$_ = new Map<String, dynamic>();}_$$tmp_$$_ = (field1);if (_$$tmp_$$_!=null){_$$result_$$_[r'json_field1_name']=_$$tmp_$$_;}_$$tmp_$$_ = (field_date2);if (_$$tmp_$$_!=null){_$$result_$$_[r'field_date2']=_$$tmp_$$_;}return super.toJson(_$$result_$$_);}}