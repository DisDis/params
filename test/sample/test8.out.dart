library params.test;

import 'package:params/annotation.dart';
import 'package:params/accessors/accessors.dart';
import 'package:params/json_encoders/json_encoders.dart';

class Entity extends Object with Serialize {
  set id(int value)=>this[r'id']=(value);
int get id=>(this[r'id']);

  set address(Address value)=>this[r'address']=(value);
Address get address=>(this[r'address']);

  @override
  final Map $container$ = {};
Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){var _$$tmp_$$_;if (_$$result_$$_ == null){ _$$result_$$_ = new Map<String, dynamic>();}_$$tmp_$$_ = (id);if (_$$tmp_$$_!=null){_$$result_$$_[r'id']=_$$tmp_$$_;}_$$tmp_$$_ = (address!=null?address.toJson():null);if (_$$tmp_$$_!=null){_$$result_$$_[r'address']=_$$tmp_$$_;}return super.toJson(_$$result_$$_);}}

class Person extends Entity {
  set name(String value)=>this[r'name']=(value);
String get name=>(this[r'name']);
Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){var _$$tmp_$$_;if (_$$result_$$_ == null){ _$$result_$$_ = new Map<String, dynamic>();}_$$tmp_$$_ = (name);if (_$$tmp_$$_!=null){_$$result_$$_[r'name']=_$$tmp_$$_;}return super.toJson(_$$result_$$_);}}

class Address extends Object with Serialize{

  final String street;

  Address(this.street);

  @override
  get $container$ => {};
}