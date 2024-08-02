import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authenthication/presentation/bloc/language/language_cubit.dart';

class Utility {
  static String getText(BuildContext context, String key,
      {bool willListen = true}) {
    return BlocProvider.of<LanguageCubit>(context, listen: willListen)
        .translate(key);
  }
}
