part of params.transformer;

class AccessorRegistry{
  final Map<String, AccessorInfo> _accessors = {};
  AccessorInfo get(String converterName){
    return _accessors.putIfAbsent(converterName,()=>new AccessorInfo(converterName));
  }
}