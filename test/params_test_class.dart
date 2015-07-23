library params.test;

import 'package:params/annotation.dart';

class DateTimeConv extends Converter {}

class FolderCloneParameters extends Object with Serialize {
  @ModelParameter(name: "sourceFolderId", converter: DateTimeConv)
  String sourceFolderId;

  set sourceFolderId1(String value) => this["sourceFolderId"] = (value);
  String get sourceFolderId1 => (this["sourceFolderId"]);
//final DateTimeConv _dtc = new DateTimeConv();
//
//  String get sourceFolderId=>_getProperty();
//  set sourceFolderId(v)=>_setProperty(vvv,v);

  final $container$;
  FolderCloneParameters(this.$container$);
}
class ddd {
  static final DateTimeConv _$converter_0$_ = new DateTimeConv();
  Map<String, dynamic> asMap() {
    if ($container$ is Map) {
      return $container$;
    }
    return {r'sourceFolderId': sourceFolderId};
  }
  JsObject asJsObject() {
    if ($container$ is JsObject) {
      return $container$;
    }
    return new JsObject.jsify(asMap());
  }
}
