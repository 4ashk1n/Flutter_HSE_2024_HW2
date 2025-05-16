import 'package:get_it/get_it.dart';
import '../data/services/cat_api_service.dart';
import '../domain/repositories/cat_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<CatRepository>(() => CatApiService());
}
