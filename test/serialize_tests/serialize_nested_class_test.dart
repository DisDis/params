import 'package:collection/collection.dart';
import 'package:params/annotation.dart';

import '../vm_common.dart';
import '../sample/test7.out.dart';


main() {
  initTestCommonSetting();
  initTest();
}

initTest() {
  final Function deepEq = const DeepCollectionEquality.unordered().equals;

  setUp(() {});

  group('convert to json', () {
    test("Class should be serialized with superclasses' properties", () {
      var id = 1;
      var name = 'ivan';
      var person = new Person()
        ..id = id
        ..name = name;
      var result = person.toJson();
      var expected = {'id': id, 'name': name};
      expect(deepEq(expected, result), true);
    });
  });
}
