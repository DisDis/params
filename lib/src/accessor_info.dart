part of params.transformer;

class AccessorInfo{
  static int count = 0;
  final String className;
  final int index = count++;

  String get field => "_\$accessor_$index\$_";

  String generateStaticFinalField(){
    return "static final $className $field = new $className();";
  }

  AccessorInfo(this.className);
  toString()=>"$className[$field]";
}