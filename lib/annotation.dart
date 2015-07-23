library params.annotation;

import 'dart:js';
export 'dart:js';

abstract class Converter {

}

abstract class Serialize{
  dynamic get $container$;
  dynamic operator[](property)  => $container$[property];
  operator[]=(property, dynamic value) => $container$[property] = value;
  Map<String, dynamic> asMap() => throw new UnimplementedError('Use a transformer');
  JsObject asJsObject() => throw new UnimplementedError('Use a transformer');
}


class ModelParameter {
  final Type converter;
  final String name;
  const ModelParameter({this.name, this.converter});
}