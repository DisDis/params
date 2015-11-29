library params.annotation;

abstract class Accessor {
  dynamic get(dynamic value);
  dynamic set(dynamic value);
}

abstract class JSONEncoder{
  dynamic encode(value);
}

abstract class Serialize{
  dynamic get $container$;
  dynamic operator[](property)  => $container$[property];
  operator[]=(property, dynamic value) => $container$[property] = value;
  Map<String, dynamic> toJson() => throw new UnimplementedError('Use a transformer');
}


class ModelParameter {
  final Type accessor;
  final String name;
  final String json;
  final bool jsonSkipEmpty;
  final Type jsonEncoder;
  final bool isSubModel;
  const ModelParameter({this.name, this.accessor, this.json, this.isSubModel:false, this.jsonSkipEmpty: true, this.jsonEncoder});
}