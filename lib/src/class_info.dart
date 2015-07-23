part of params.transformer;

class ClassInfo {
  final ConverterRegistry cregistry;
  final ClassDeclaration declaration;
  CollectFieldsAstVisitor _cfields;
  static const String CONTAINER_NAME=r"$container$";

  ClassInfo(this.cregistry, this.declaration) {
    _cfields = new CollectFieldsAstVisitor(cregistry);
    declaration.accept(_cfields);
  }

  void transform(TextEditTransaction code) {
    if (_cfields.fields.isEmpty) {
      return;
    }
    Set<ConverterInfo> converters = _cfields.fields.fold(new Set(),
        (Set<ConverterInfo> v, item) {
      if (item.converter != null) {
        v.add(item.converter);
      }
      return v;
    });
    StringBuffer sbStaticConverterFields = new StringBuffer();
    converters.forEach((item) =>
        sbStaticConverterFields.write(item.generateStaticFinalField()));
    code.edit(declaration.endToken.offset, declaration.endToken.offset,
        sbStaticConverterFields.toString());

    _cfields.fields.forEach((FieldInfo field) {
      code.edit(field.node.parent.parent.offset, field.node.parent.parent.end,
          field.generateSetterGetter());
    });

    //asMap() {
    code.edit(declaration.endToken.offset, declaration.endToken.offset,
        generateMethods());
  }

  String generateMethods() {
    return generateAsMapMethod()+generateAsJsObjectMethod();
  }

  String generateAsMapMethod() {
    StringBuffer sb = new StringBuffer();
    sb.write("Map<String,dynamic> asMap(){");
    sb.write("if ($CONTAINER_NAME is Map) { return $CONTAINER_NAME;} ");
    sb.write('return {');
      sb.write(_cfields.fields.map((field) {
        return "r'${field._modelParameterName}': ${field._fieldName}";
      }).join(','));
      sb.write("};");
    sb.write("}");
    return sb.toString();
  }

  String generateAsJsObjectMethod() {
    StringBuffer sb = new StringBuffer();
    sb.write("JsObject asJsObject(){");
      sb.write("if ($CONTAINER_NAME is JsObject) { return $CONTAINER_NAME;} ");
      sb.write('return new JsObject.jsify(asMap());');
    sb.write("}");
    return sb.toString();
  }
}
