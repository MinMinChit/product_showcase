import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_showcase/constants/style.dart';
import 'package:product_showcase/features/authenthication/presentation/bloc/language/language_cubit.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language',
                style: KStyle.tTitleMTextStyle,
              ),
              const Divider(),
              InkWell(
                onTap: () {
                  BlocProvider.of<LanguageCubit>(context).changeLanguage('th');
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      Image.asset('assets/icons/th.png', width: 24),
                      const SizedBox(width: 12),
                      Text(
                        'Thai',
                        style: KStyle.tBodyTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  BlocProvider.of<LanguageCubit>(context).changeLanguage('en');
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 45,
                  child: Row(
                    children: [
                      Image.asset('assets/icons/en.png', width: 24),
                      const SizedBox(width: 12),
                      Text(
                        'English',
                        style: KStyle.tBodyTextStyle,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
