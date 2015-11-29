part of params.transformer;

class ClassInfo {
  final AccessorRegistry aRegistry;
  final JSONEncoderRegistry jsonRegistry;
  final ClassDeclaration declaration;
  CollectFieldsAstVisitor _cfields;
  static const String CONTAINER_NAME=r"$container$";

  ClassInfo(this.aRegistry, this.jsonRegistry, this.declaration) {
    _cfields = new CollectFieldsAstVisitor(aRegistry, jsonRegistry);
    declaration.accept(_cfields);
  }

  void transform(TextEditTransaction code) {
    if (_cfields.fields.isEmpty) {
      return;
    }
    Set<AccessorInfo> accessors = _cfields.fields.fold(new Set(),
        (Set<AccessorInfo> v, item) {
      if (item.accessor != null) {
        v.add(item.accessor);
      }
      return v;
    });
    Set<JSONEncoderInfo> jsonencoders = _cfields.fields.fold(new Set(),
        (Set<JSONEncoderInfo> v, item) {
      if (item.jsonEncoder != null) {
        v.add(item.jsonEncoder);
      }
      return v;
    });
    StringBuffer sbStaticConverterFields = new StringBuffer();
    accessors.forEach((item) =>    sbStaticConverterFields.write(item.generateStaticFinalField()));
    jsonencoders.forEach((item) => sbStaticConverterFields.write(item.generateStaticFinalField()));
    code.edit(declaration.endToken.offset, declaration.endToken.offset,
        sbStaticConverterFields.toString());

    _cfields.fields.forEach((FieldInfo field) {
      code.edit(field.node.parent.parent.offset, field.node.parent.parent.end,
          field.generateSetterGetter());
    });

    code.edit(declaration.endToken.offset, declaration.endToken.offset,
        generateMethods());
  }

  String generateMethods() {
    return generateAsMapMethod();
  }

  String generateAsMapMethod() {
    StringBuffer sb = new StringBuffer();
    sb.write("dynamic toJson(){");
    var tempVar ="_\$\$tmp_\$\$_";
    var resultVar ="_\$\$result_\$\$_";
    sb.write("var $tempVar;");
    //sb.write("if ($CONTAINER_NAME is Map) { return $CONTAINER_NAME;} ");
    sb.write('var $resultVar = {');
      _cfields.fields.where((FieldInfo field)=>!field.jsonSkipEmpty).forEach((FieldInfo field) {
          sb.write("r'${field.jsonName}': ");
          field.generateJSONEncodeValueGetter(sb);
      });
      sb.write("};");
    _cfields.fields.where((FieldInfo field)=>field.jsonSkipEmpty).forEach((FieldInfo field) {
      sb.write("$tempVar = "); field.generateJSONEncodeValueGetter(sb); sb.write(";");
      sb.write("if ($tempVar!=null){$resultVar[r'${field.jsonName}']=$tempVar;}");
    });
    sb.write("return $resultVar;");
    sb.write("}");
    return sb.toString();
  }
}
