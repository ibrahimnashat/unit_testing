import 'dart:convert';
import 'dart:io';

abstract class Fixture {
  Future<Map<String, dynamic>> data({required String name});
}

class FixtrueReader extends Fixture {
  @override
  Future<Map<String, dynamic>> data({required String name}) async {
    final res =
        json.decode(File('lib/core/fixtures/$name.json').readAsStringSync());
    return res;
  }
}
