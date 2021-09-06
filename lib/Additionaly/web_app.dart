

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:neirobankadmin/Screens/first_screen.dart';
import 'package:neirobankadmin/Screens/redact_screen.dart';



class WebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //loadLanguage();
    return GetMaterialApp(
      title: 'NeiroBankAdmin',
      defaultTransition: Transition.native,
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}