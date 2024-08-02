import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_showcase/features/authenthication/presentation/bloc/language/language_cubit.dart';
import 'package:product_showcase/features/product/presentation/bloc/product_category/product_category_cubit.dart';
import 'package:product_showcase/features/product/presentation/screens/product_screen.dart';
import 'package:product_showcase/services/locator.dart';

void main() {
  locator();
  runApp(const ProductShowcaseApp());
}

class ProductShowcaseApp extends StatelessWidget {
  const ProductShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCategoryCubit>(create: (context) => getIt.call()),
        BlocProvider<LanguageCubit>(create: (context) => getIt.call()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductScreen(),
      ),
    );
  }
}
