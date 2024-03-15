import 'package:flutter_test/flutter_test.dart';
import 'package:v3l/core/core.dart';

void main() {
  group('LoginStatusX', () {
    test('returns correct values for ConnectionStatus.loading', () {
      const status = ConnectionStatus.loading;
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for ConnectionStatus.success', () {
      const status = ConnectionStatus.success;
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for ConnectionStatus.failure', () {
      const status = ConnectionStatus.failure;
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isTrue);
    });
  });
}
