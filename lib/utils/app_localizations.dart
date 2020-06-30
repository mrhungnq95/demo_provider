import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const Iterable<Locale> localeSupport = [
    Locale('en', 'US'),
    Locale('vi', 'VN')
  ];

  AppLocalizations(this.locale);

  Map<String, Map<String, String>>
      _localizedData; //LanguageCode ->CountryCode ->Key

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedData = jsonMap.map((keyCountryCode, valueLocalize) {
      return MapEntry<String, Map<String, String>>(
          keyCountryCode, Map<String, String>.from(valueLocalize));
    });

    return true;
  }

  String localize(String key, {String countryCode, List<Object> params}) {
    String value;
    String _countryCode = countryCode ?? locale.countryCode;

    if (_countryCode == null ||
        _countryCode.isEmpty ||
        !_localizedData.keys.contains(_countryCode)) {
      _countryCode = _localizedData[_countryCode].keys.toList()[0];
    }
    value = _localizedData[_countryCode][key];

    if (params != null && params.isNotEmpty) {
      for (int i = 0, length = params.length; i < length; i++) {
        value = value?.replaceAll('%$i%', '${params[i]}');
      }
    }
    return value;
  }
}

//Class uỷ quyền để lấy data localize theo Locale của app đang chọn
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.localeSupport.firstWhere(
            (element) => element.languageCode == locale.languageCode) !=
        null;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    //Load theo json
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
