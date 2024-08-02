import 'package:get_it/get_it.dart';
import 'package:product_showcase/features/authenthication/presentation/bloc/language/language_cubit.dart';
import 'package:product_showcase/features/product/data/product_services.dart';
import 'package:product_showcase/features/product/presentation/bloc/product_category/product_category_cubit.dart';
import 'package:product_showcase/services/storage/secure_storage.dart';
import 'package:product_showcase/services/utility/utility.dart';

final getIt = GetIt.instance;
void locator() {
  // secure storage
  getIt.registerLazySingleton(() => SecureStorage());

  // utility
  getIt.registerLazySingleton(() => Utility());

  // language
  getIt.registerLazySingleton(() => LanguageCubit(getIt.call()));

  // product
  getIt.registerLazySingleton(() => ProductServices());
  getIt.registerLazySingleton(() => ProductCategoryCubit(getIt.call()));
}
