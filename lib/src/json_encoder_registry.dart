part of params.transformer;

class JSONEncoderRegistry{
  final Map<String, JSONEncoderInfo> _items = {};
  JSONEncoderInfo get(String converterName){
    return _items.putIfAbsent(converterName,()=>new JSONEncoderInfo(converterName));
  }
}