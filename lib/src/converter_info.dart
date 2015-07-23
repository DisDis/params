part of params.transformer;

class ConverterInfo{
  static int count = 0;
  final String className;
  final int index = count++;

  String get field => "_\$converter_$index\$_";

  String generateStaticFinalField(){
    return "static final $className $field = new $className();";
  }

  ConverterInfo(this.className);
  toString()=>"$className[$field]";
}