import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//class Language:

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, '🇬🇧', "EN", "en"),
      Language(2, '🇩🇪', "DE", "de"),
      Language(3, '🇷🇺', "RU", "ru"),
    ];
  }
}

// for Locale:

String language_code = 'languageCode';

//languages code
const String en = 'en';
const String de = 'de';
const String ru = 'ru';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(language_code, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(language_code) ?? en;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case en:
      return const Locale(en, '');
    case de:
      return const Locale(de, '');
    case ru:
      return const Locale(ru, "");
    default:
      return const Locale(en, '');
  }
}

//AppLocalizations translation(BuildContext context) {
//  return AppLocalizations.of(context)!;
//}