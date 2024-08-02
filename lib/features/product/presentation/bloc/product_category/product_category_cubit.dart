import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_showcase/features/product/model/product/product_model.dart';

import '../../../data/product_services.dart';

part 'product_category_state.dart';

enum DataState {
  loading,
  success,
  fail,
}

class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  final ProductServices productService;
  ProductCategoryCubit(this.productService) : super(ProductCategoryInitial());

  List<ProductCategoryModel> categoryList = [];
  List<Product> productList = [];
  Future getProductCategory() async {
    try {
      emit(ProductCategoryLoading());
      var result = await productService.getProductCategory();

      if (result.statusCode == 200) {
        categoryList =
            ProductCategoryModel.fromJsonList(json.decode(result.body));
        if (categoryList.isNotEmpty) {
          await getProductCategoryItems(categoryList[0].slug);
        } else {
          emit(ProductCategoryFail(message: 'Category empty'));
        }
      } else {
        emit(ProductCategoryFail(message: 'Some error message'));
      }
    } catch (e) {
      emit(ProductCategoryFail(message: e.toString()));
    }
  }

  Future getProductCategoryItems(String category) async {
    try {
      emit(ProductCategorySuccess(
          categoryList: categoryList,
          productList: productList,
          productState: DataState.loading));
      var result = await productService.getProductCategoryItems(category);

      if (result.statusCode == 200) {
        productList =
            Product.fromJsonList(json.decode(result.body)['products']);
        emit(ProductCategorySuccess(
            categoryList: categoryList,
            productList: productList,
            productState: DataState.success));
      } else {
        emit(ProductCategorySuccess(
            categoryList: categoryList,
            productList: productList,
            productState: DataState.fail,
            message: 'Fetching product item error'));
      }
    } catch (e) {
      emit(ProductCategorySuccess(
          categoryList: categoryList,
          productList: productList,
          productState: DataState.fail,
          message: e.toString()));
    }
  }
}
