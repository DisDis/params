part of params.transformer;

class CollectFieldsAstVisitor extends GeneralizingAstVisitor{
  final List<FieldInfo> fields = [];
  final ConverterRegistry cregistry;

  CollectFieldsAstVisitor(this.cregistry);
  @override
  visitFieldDeclaration(FieldDeclaration node){
    if (!node.isStatic && !node.fields.isFinal && !node.fields.isConst){
      Annotation annotation = _getModelParameterAnnotation(node);
      if (annotation == null){
        return super.visitFieldDeclaration(node);
      }
      node.fields.variables.forEach((VariableDeclaration nodeV){
        if (!Identifier.isPrivateName(nodeV.name.name)) {
          fields.add(new FieldInfo(cregistry,nodeV, node.fields.type, annotation));
        }
      });
    }
    return super.visitFieldDeclaration(node);
  }
}