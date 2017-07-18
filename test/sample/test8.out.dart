library params.test;

import 'package:params/annotation.dart';
import 'package:params/accessors/accessors.dart';

class Entity extends Object with Serialize {
  set id(int value)=>this[r'id']=(value);
int get id=>(this[r'id']);

  set address(Address value)=>this[r'address']=_$accessor_1$_.set(value);
Address get address=>_$accessor_1$_.get(this[r'address']);

  @override
  final Map $container$ = {};
static final AddressParamsModelAccessor _$accessor_1$_ = new AddressParamsModelAccessor();Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){var _$$tmp_$$_;if (_$$result_$$_ == null){ _$$result_$$_ = new Map<String, dynamic>();}_$$tmp_$$_ = (id);if (_$$tmp_$$_!=null){_$$result_$$_[r'id']=_$$tmp_$$_;}_$$tmp_$$_ = (address!=null?address.toJson():null);if (_$$tmp_$$_!=null){_$$result_$$_[r'address']=_$$tmp_$$_;}return super.toJson(_$$result_$$_);}}

class AddressParamsModelAccessor extends ParamsModelAccessor<Address>{
  @override
  Address create(value)=>new Address.fromMap(value);
}

class Person extends Entity {
  set name(String value)=>this[r'name']=(value);
String get name=>(this[r'name']);
Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){var _$$tmp_$$_;if (_$$result_$$_ == null){ _$$result_$$_ = new Map<String, dynamic>();}_$$tmp_$$_ = (name);if (_$$tmp_$$_!=null){_$$result_$$_[r'name']=_$$tmp_$$_;}return super.toJson(_$$result_$$_);}}

class Address extends Object with Serialize{
  set street(String value)=>this[r'street']=(value);
String get street=>(this[r'street']);

  @override
  final Map $container$;
  Address():this.$container$ = {};
  Address.fromMap(this.$container$);
Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){var _$$tmp_$$_;if (_$$result_$$_ == null){ _$$result_$$_ = new Map<String, dynamic>();}_$$tmp_$$_ = (street);if (_$$tmp_$$_!=null){_$$result_$$_[r'street']=_$$tmp_$$_;}return super.toJson(_$$result_$$_);}}