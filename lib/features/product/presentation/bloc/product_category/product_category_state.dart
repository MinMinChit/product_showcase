part of 'product_category_cubit.dart';

@immutable
sealed class ProductCategoryState {}

final class ProductCategoryInitial extends ProductCategoryState {}

final class ProductCategoryLoading extends ProductCategoryState {}

final class ProductCategorySuccess extends ProductCategoryState {
  final List<ProductCategoryModel> categoryList;
  final List<Product> productList;
  final DataState productState;
  final String? message;

  ProductCategorySuccess({
    required this.categoryList,
    required this.productList,
    required this.productState,
    this.message,
  });
}

final class ProductCategoryFail extends ProductCategoryState {
  final String message;
  ProductCategoryFail({required this.message});
}
