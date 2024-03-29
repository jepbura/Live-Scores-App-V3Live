// Mocks generated by Mockito 5.3.0 from annotations
// in v3l/test/helpers/mock/test_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:v3l/core/core.dart' as _i6;
import 'package:v3l/feature/data/data_sources/datasources.dart' as _i7;
import 'package:v3l/feature/data/models/model.dart' as _i3;
import 'package:v3l/feature/domain/domain.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeLiveScoreModel_1 extends _i1.SmartFake
    implements _i3.LiveScoreModel {
  _FakeLiveScoreModel_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [DioRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioRepository extends _i1.Mock implements _i4.DioRepository {
  MockDioRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, _i4.LiveScoreEntity>> liveScore() =>
      (super.noSuchMethod(Invocation.method(#liveScore, []),
          returnValue:
              _i5.Future<_i2.Either<_i6.Failure, _i4.LiveScoreEntity>>.value(
                  _FakeEither_0<_i6.Failure, _i4.LiveScoreEntity>(
                      this, Invocation.method(#liveScore, [])))) as _i5
          .Future<_i2.Either<_i6.Failure, _i4.LiveScoreEntity>>);
}

/// A class which mocks [DioDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioDatasource extends _i1.Mock implements _i7.DioDatasource {
  MockDioDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.LiveScoreModel> liveScore() => (super.noSuchMethod(
          Invocation.method(#liveScore, []),
          returnValue: _i5.Future<_i3.LiveScoreModel>.value(
              _FakeLiveScoreModel_1(this, Invocation.method(#liveScore, []))))
      as _i5.Future<_i3.LiveScoreModel>);
}
