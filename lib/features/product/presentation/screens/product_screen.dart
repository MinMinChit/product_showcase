import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_showcase/constants/style.dart';
import 'package:product_showcase/features/product/presentation/bloc/product_category/product_category_cubit.dart';
import 'package:product_showcase/services/utility/utility.dart';

import '../../../../widgets/custom_filter_chip.dart';
import '../../../authenthication/presentation/bloc/language/language_cubit.dart';
import '../../model/product/product_model.dart';
import 'drawer_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductCategoryModel? selectedModel;
  @override
  void initState() {
    BlocProvider.of<LanguageCubit>(context).initializedLanguage();
    BlocProvider.of<ProductCategoryCubit>(context).getProductCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ProductCategoryCubit>(context).getProductCategory();
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Utility.getText(context, 'product_showcase'),
          style: KStyle.tTitleLTextStyle.copyWith(
            color: KStyle.cAccent,
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      body: BlocBuilder<ProductCategoryCubit, ProductCategoryState>(
        builder: (BuildContext context, state) {
          if (state is ProductCategoryLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is ProductCategorySuccess) {
            List<ProductCategoryModel> categoryList = state.categoryList;
            List<Product> productList = state.productList;
            DataState dataState = state.productState;
            return Column(
              children: [
                SizedBox(
                  height: 55,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (child, index) {
                        ProductCategoryModel model = categoryList[index];
                        selectedModel ??= model;
                        return Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: CustomFilterChip(
                            selected: selectedModel == model,
                            label: model.name,
                            onSelected: (bool value) {
                              setState(() {
                                selectedModel = model;
                              });
                              BlocProvider.of<ProductCategoryCubit>(context)
                                  .getProductCategoryItems(model.slug);
                            },
                          ),
                        );
                      }),
                ),
                Expanded(
                  child: dataState == DataState.loading
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : dataState == DataState.success
                          ? ListView(
                              children:
                                  List.generate(productList.length, (index) {
                                Product product = productList[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: KStyle.cAccent,
                                      )),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: product.thumbnail,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                        placeholder: (context, str) {
                                          return const CupertinoActivityIndicator();
                                        },
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.title,
                                                style: KStyle.tTitleMTextStyle,
                                              ),
                                              Text(
                                                product.description,
                                                maxLines: 1,
                                                style: KStyle.tLabelTextStyle,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '\$${product.price}',
                                                    style:
                                                        KStyle.tTitleSTextStyle,
                                                  ),
                                                  const Spacer(),
                                                  Icon(
                                                    Icons.star,
                                                    color: KStyle.cAccent,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    '${product.rating}',
                                                    style:
                                                        KStyle.tLabelTextStyle,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            )
                          : Center(
                              child: Text(state.message ?? 'Unknown error'),
                            ),
                ),
              ],
            );
          }
          if (state is ProductCategoryFail) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}
