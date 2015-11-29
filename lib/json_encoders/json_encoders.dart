library params.json_encoders;

import 'package:params/annotation.dart';
import 'dart:convert';

class DefaultJSONEncoder extends JSONEncoder{
  @override
  encode(value) => value!=null?JSON.encode(value.toString()):null;
}

class ToStringJSONEncoder extends JSONEncoder{
  @override
  encode(value) => value!=null?value.toString():null;
}