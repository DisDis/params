part of params.transformer;

class FieldInfo{
  String _modelParameterName;
  String _jsonParameterName;
  String _fieldName;
  AccessorInfo _accessor;
  JSONEncoderInfo _jsonEncoder;
  bool _jsonSkipEmpty = true;
  bool get jsonSkipEmpty => _jsonSkipEmpty;
  bool _isSubModel = false;
  bool get isSubModel => _isSubModel;
  String get name => _fieldName;
  String get parameterName => _modelParameterName;
  String get jsonName => _jsonParameterName;
  AccessorInfo get accessor => _accessor;
  JSONEncoderInfo get jsonEncoder =>_jsonEncoder;
  final VariableDeclaration node;
  final TypeName type;
  final Annotation annotation;
  static const NAME_PARAM = 'name';
  static const ACCESSOR_PARAM = 'accessor';
  static const JSON_PARAM = 'json';
  static const JSON_SKIP_EMPTY_PARAM = 'jsonSkipEmpty';
  static const JSON_ENCODER_PARAM = 'jsonEncoder';
  static const IS_SUB_MODEL_PARAM = 'isSubModel';

  void generateValueGetter(StringBuffer sb) {
    if (isSubModel) {
      sb.write("$name!=null?$name.toJson():null");
    } else {
      sb.write(name);
    }
  }
  void generateJSONEncodeValueGetter(StringBuffer sb) {
    if (jsonEncoder != null) {
      sb.write("${jsonEncoder.field}.encode");
    }
    sb.write("("); generateValueGetter(sb); sb.write(")");
  }

  FieldInfo(AccessorRegistry accessorRegistry, JSONEncoderRegistry jsonEncoderRegistry, this.node, this.type, this.annotation){
//    print("Variable: '$node' typeof '$type' $annotation [${annotation.runtimeType}]");
    _fieldName = node.name.name;
    _modelParameterName = _fieldName;

    var tmpV = _getAnnotationParam(NAME_PARAM);
    if (tmpV != null){
      _modelParameterName = tmpV.toString().substring(1);
      _modelParameterName = _modelParameterName.substring(0,_modelParameterName.length-1);
    }
    tmpV = _getAnnotationParam(JSON_PARAM);
    if (tmpV != null){
      _jsonParameterName = tmpV.toString().substring(1);
      _jsonParameterName = _jsonParameterName.substring(0,_jsonParameterName.length-1);
    }
    if (_jsonParameterName == null){
      _jsonParameterName = _fieldName;
    }
    tmpV = _getAnnotationParam(JSON_SKIP_EMPTY_PARAM);
    if (tmpV != null){
      _jsonSkipEmpty = (tmpV as BooleanLiteral).value;
    }
    tmpV = _getAnnotationParam(JSON_ENCODER_PARAM);
    if (tmpV!=null){
      _jsonEncoder = jsonEncoderRegistry.get(tmpV.name);
    }

    tmpV = _getAnnotationParam(IS_SUB_MODEL_PARAM);
    if (tmpV != null){
      _isSubModel = (tmpV as BooleanLiteral).value;
    }


    SimpleIdentifier accessorV = _getAnnotationParam(ACCESSOR_PARAM);
    if (accessorV!=null){
      _accessor = accessorRegistry.get(accessorV.name);
    }
  }
  dynamic _getAnnotationParam(String paramName){
    NodeList<Expression> args = annotation.arguments.arguments;
    NamedExpression v = args.where((item)=>item is NamedExpression).firstWhere((item)=>(item as NamedExpression).name.label.name == paramName,orElse:()=>null);
    if (v == null){
      return null;
    }
    return v.expression;
  }

  String generateSetterGetter() {
    return generateSetter()+"\n"+generateGetter();
  }

  String generateSetter() {
    return "set $_fieldName($type value)=>this[r'$parameterName']=${accessor!=null?'${accessor.field}.set':''}(value);";
  }

  String generateGetter() {
    return "$type get $_fieldName=>${accessor!=null?'${accessor.field}.get':''}(this[r'$parameterName']);";
  }
}