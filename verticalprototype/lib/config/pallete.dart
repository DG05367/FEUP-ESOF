// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffce5641), //10%
      100: const Color(0xffb74c3a), //20%
      200: const Color(0xffa04332), //30%
      300: const Color(0xff89392b), //40%
      400: const Color(0xff733024), //50%
      500: const Color(0xff5c261d), //60%
      600: const Color(0xff451c16), //70%
      700: const Color(0xff2e130e), //80%
      800: const Color(0xff170907), //90%
      900: const Color(0xff000000), //100%
    },
  );
  static const MaterialColor PANTONE484 = const MaterialColor(
    0xff8c2d19, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff7e2917), //10%
      100: const Color(0xff702414), //20%
      200: const Color(0xff621f12), //30%
      300: const Color(0xff541b0f), //40%
      400: const Color(0xff46170d), //50%
      500: const Color(0xff38120a), //60%
      600: const Color(0xff2a0d07), //70%
      700: const Color(0xff1c0905), //80%
      800: const Color(0xff0e0402), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
