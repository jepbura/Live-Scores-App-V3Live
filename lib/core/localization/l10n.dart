import 'package:flutter/material.dart';

class L10n {
  L10n._();

  static final all = [
    const Locale('en'),
    const Locale('fa'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'fa':
        return 'Farsi';
      case 'en':
      default:
        return 'English';
    }
  }
}
