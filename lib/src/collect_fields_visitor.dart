part of params.transformer;

class CollectFieldsAstVisitor extends GeneralizingAstVisitor{
  final List<FieldInfo> fields = [];
  final AccessorRegistry aRegistry;
  final JSONEncoderRegistry jsonRegistry;

  CollectFieldsAstVisitor(this.aRegistry, this.jsonRegistry);
  @override
  visitFieldDeclaration(FieldDeclaration node){
    if (!node.isStatic && !node.fields.isFinal && !node.fields.isConst){
      Annotation annotation = _getModelParameterAnnotation(node);
      if (annotation == null){
        return super.visitFieldDeclaration(node);
      }
      node.fields.variables.forEach((VariableDeclaration nodeV){
        if (!Identifier.isPrivateName(nodeV.name.name)) {
          fields.add(new FieldInfo(aRegistry, jsonRegistry,nodeV, node.fields.type, annotation));
        }
      });
    }
    return super.visitFieldDeclaration(node);
  }
}