part of params.transformer;

class JSONEncoderInfo{
  static int count = 0;
  final String className;
  final int index = count++;

  String get field => "_\$json_encoder_$index\$_";

  String generateStaticFinalField(){
    return "static final $className $field = new $className();";
  }

  JSONEncoderInfo(this.className);
  toString()=>"$className[$field]";
}