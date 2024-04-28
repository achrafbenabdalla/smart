import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_app/src/pages/sign-in.dart';

import 'config/app_them.dart';
import 'pages/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: SignIn(),
    );
  }
}
