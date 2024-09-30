

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

class ThemeProvider with ChangeNotifier{
  bool isDark = false;

  ThemeData get currentTheme => isDark ? darkTheme : lightTheme ;

  void toggleTheme(){
    isDark=!isDark;
    notifyListeners();
  }
}