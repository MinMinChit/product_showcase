import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_showcase/services/storage/secure_storage.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final SecureStorage storage;
  LanguageCubit(this.storage) : super(LanguageInitial());
  Map<String, String> _localizedStrings = {};

  void initializedLanguage() async {
    String lang = await storage.readData('language') ?? 'en';
    await load(lang);
  }

  void changeLanguage(String changeLang) async {
    String? storeLang = await storage.readData('language');
    if (storeLang == null) {
      emit(LanguageLoadingState());
      await changeLanguageFunction(changeLang);
    } else {
      if (storeLang != changeLang) {
        emit(LanguageLoadingState());
        await changeLanguageFunction(changeLang);
      }
    }
  }

  Future<void> changeLanguageFunction(String changeLang) async {
    _localizedStrings = {};
    await storage.saveData('language', changeLang);
    load(changeLang);
  }

  Future load(String lang) async {
    String jsonString = await rootBundle.loadString('lib/lang/$lang.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    emit(LanguageChangeSuccessState(lang));
  }

  String translate(String key) {
    return _localizedStrings[key] ?? "";
  }
}
