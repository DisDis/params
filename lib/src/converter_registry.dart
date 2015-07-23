part of params.transformer;

class ConverterRegistry{
  final Map<String, ConverterInfo> _converters = {};
  ConverterInfo get(String converterName){
    return _converters.putIfAbsent(converterName,()=>new ConverterInfo(converterName));
  }
}