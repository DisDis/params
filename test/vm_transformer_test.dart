@TestOn("vm")
library params.transformer.test;

import 'vm_common.dart';
//import 'helper.dart';
import 'package:transformer_test/utils.dart';
import 'package:params/src/parser_transformer.dart';
import 'dart:convert';
//import 'sample/test6.out.dart';
import 'package:params/accessors/accessors.dart';
import 'package:params/annotation.dart';
import 'sample/test6.out.dart';

main() {
  initTestCommonSetting();
  initTest();
}

initTest() {
  setUp(() {});
  group('transformer', () {
    const TEST_COUNT = 6;
    for (var i = 1; i <= TEST_COUNT; i++) {
      var name = "test$i";
      testPhases(name, [
        [new ParamsParserTransformer()]
      ], {
        'wrike_ws|lib/test/$name.dart': readSampleFile('sample/$name.in.dart')
      }, {
        'wrike_ws|lib/test/$name.dart': readSampleFile('sample/$name.out.dart')
      });
    }
  });
  group('json', () {
    test("json1", () {
      var t1 = new Task();
      User u1 = t1.creator = new User();
      u1.firstName = "fName";
      t1.create = new DateTime(2015);
      expect(JSON.encode(t1),
          equals(
              '{"create":"2015-01-01 00:00:00.000","creator":{"sName":null,"firstName":"fName"}}'));
    });
  });
}