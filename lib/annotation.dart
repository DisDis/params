library params.annotation;

abstract class Accessor<V1,V2> {
  V1 get(V2 value);
  V2 set(V1 value);
}

abstract class JSONEncoder<V1, V2>{
  V1 encode(V2 value);
}

abstract class Serialize{
  dynamic get $container$;
  dynamic operator[](property)  => $container$[property];
  operator[]=(property, dynamic value) => $container$[property] = value;
  Map<String, dynamic> toJson([Map<String, dynamic> _$$result_$$_]){
    if (_$$result_$$_ == null) {
      throw new UnimplementedError('Use a transformer');
    }
    return _$$result_$$_;
  }
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
