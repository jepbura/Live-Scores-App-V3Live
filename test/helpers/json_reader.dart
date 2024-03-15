import 'dart:io';

String jsonReader(String name) => File('test/fixtures/$name').readAsStringSync();
