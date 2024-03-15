import 'package:mockito/annotations.dart';
import 'package:v3l/feature/data/data_sources/datasources.dart';
import 'package:v3l/feature/domain/domain.dart';

@GenerateMocks([
  DioRepository,
  DioDatasource,
])
void main() {}
