import 'package:get_it/get_it.dart';
import 'package:product_showcase/services/storage/secure_storage.dart';

final getIt = GetIt.instance;
void locator() {
  // secure storage
  getIt.registerLazySingleton(() => SecureStorage());
}
