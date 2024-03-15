import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:v3l/feature/data/models/model.dart';

import '../../../../helpers/default_params/default_params.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';

void main() {
  test('from json, should return a valid model from json', () {
    /// arrange
    final jsonMap = json.decode(jsonReader(dioLiveScoreDataModel));

    /// act
    final result = LiveScoreModel.fromJson(jsonMap);

    /// assert
    expect(result, equals(liveScoreResponse));
  });

  test('to json, should return a json map containing proper data', () {
    /// act
    final result = liveScoreResponse.toJson();

    /// arrange
    // exceptedJson

    /// assert
    expect(result, equals(exceptedJson));
  });
}
