library params.test;

import 'package:params/annotation.dart';
import 'package:params/accessors/accessors.dart';
import 'package:params/json_encoders/json_encoders.dart';

class Task extends Object with Serialize {
  set title(String value)=>this[r'title']=(value);
String get title=>(this[r'title']);

  set create(DateTime value)=>this[r'create']=_$accessor_1$_.set(value);
DateTime get create=>_$accessor_1$_.get(this[r'create']);

  set creator(User value)=>this[r'creator']=_$accessor_2$_.set(value);
User get creator=>_$accessor_2$_.get(this[r'creator']);

  @override
  final $container$ = {};
static final DateTimeMillisecondsAccessor _$accessor_1$_ = new DateTimeMillisecondsAccessor();static final UserParamsModelAccessor _$accessor_2$_ = new UserParamsModelAccessor();static final ToStringJSONEncoder _$json_encoder_0$_ = new ToStringJSONEncoder();Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){var _$$tmp_$$_;if (_$$result_$$_ == null){ _$$result_$$_ = new Map<String, dynamic>();}_$$tmp_$$_ = (title);if (_$$tmp_$$_!=null){_$$result_$$_[r'title']=_$$tmp_$$_;}_$$tmp_$$_ = _$json_encoder_0$_.encode(create);if (_$$tmp_$$_!=null){_$$result_$$_[r'create']=_$$tmp_$$_;}_$$tmp_$$_ = (creator!=null?creator.toJson():null);if (_$$tmp_$$_!=null){_$$result_$$_[r'creator']=_$$tmp_$$_;}return super.toJson(_$$result_$$_);}}

class UserParamsModelAccessor extends ParamsModelAccessor<User>{
  @override
  User create(value)=>new User.fromMap(value);
}

class User extends Object with Serialize {
  set firstName(String value)=>this[r'firstName']=(value);
String get firstName=>(this[r'firstName']);
  set lastName(String value)=>this[r'lastName']=(value);
String get lastName=>(this[r'lastName']);

  set sName(String value)=>this[r'sName']=(value);
String get sName=>(this[r'sName']);

  @override
  final $container$;
  User():this.$container$ = {};
  User.fromMap(this.$container$);
Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){var _$$tmp_$$_;if (_$$result_$$_ == null){ _$$result_$$_ = new Map<String, dynamic>();}_$$result_$$_[r'sName'] = (sName);_$$tmp_$$_ = (firstName);if (_$$tmp_$$_!=null){_$$result_$$_[r'firstName']=_$$tmp_$$_;}_$$tmp_$$_ = (lastName);if (_$$tmp_$$_!=null){_$$result_$$_[r'lastName']=_$$tmp_$$_;}return super.toJson(_$$result_$$_);}}