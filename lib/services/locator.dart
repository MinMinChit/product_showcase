import 'package:get_it/get_it.dart';
import 'package:product_showcase/features/product/data/product_services.dart';
import 'package:product_showcase/features/product/presentation/bloc/product_category/product_category_cubit.dart';
import 'package:product_showcase/services/storage/secure_storage.dart';

final getIt = GetIt.instance;
void locator() {
  // secure storage
  getIt.registerLazySingleton(() => SecureStorage());

  // product
  getIt.registerLazySingleton(() => ProductServices());
  getIt.registerLazySingleton(() => ProductCategoryCubit(getIt.call()));
}
