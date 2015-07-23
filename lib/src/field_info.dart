part of params.transformer;

class FieldInfo{
  String _modelParameterName;
  String _fieldName;
  ConverterInfo _converter;
  String get parameterName => _modelParameterName;
  ConverterInfo get converter => _converter;
  final VariableDeclaration node;
  final TypeName type;
  final Annotation annotation;
  static const NAME_PARAM = 'name';
  static const CONVERTER_PARAM = 'converter';
  FieldInfo(ConverterRegistry converterRegistry, this.node, this.type, this.annotation){
//    print("Variable: '$node' typeof '$type' $annotation [${annotation.runtimeType}]");
    _fieldName = node.name.name;
    _modelParameterName = _fieldName;

    var nameV = _getAnnotationParam(NAME_PARAM);
    if (nameV!=null){
      _modelParameterName = nameV.toString().substring(1);
      _modelParameterName = _modelParameterName.substring(0,_modelParameterName.length-1);
    }
    SimpleIdentifier converterV = _getAnnotationParam(CONVERTER_PARAM);
    if (converterV!=null){
      _converter = converterRegistry.get(converterV.name);
    }
    print("p field: $_fieldName");
    print("p name: $_modelParameterName");
    print("p converter: $_converter");

//    args.arguments.firstWhere((arg){
//      arg.name
//    },orElse:()=>null);
  }
  dynamic _getAnnotationParam(String paramName){
    NodeList<Expression> args = annotation.arguments.arguments;
    NamedExpression v = args.where((item)=>item is NamedExpression).firstWhere((NamedExpression item)=>item.name.label.name == paramName,orElse:()=>null);
    if (v == null){
      return null;
    }
    return v.expression;
  }

  String generateSetterGetter() {
    return generateSetter()+generateGetter();
  }

  String generateSetter() {
    return "set $_fieldName($type value)=>this[r'$parameterName']=${converter!=null?'':''}(value);";
  }

  String generateGetter() {
    return "$type get $_fieldName=>${converter!=null?'':''}(this[r'$parameterName']);";
  }
}