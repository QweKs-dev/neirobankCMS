import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neirobankadmin/Additionaly/GetRouter.dart';
import 'package:neirobankadmin/Additionaly/ScreenAdaptation.dart';
import 'package:neirobankadmin/Additionaly/embed_statefull_screen.dart';
import 'package:neirobankadmin/Screens/Generator/generator_screen.dart';
import 'package:neirobankadmin/Screens/NeiroCouponRequest/neiro_coupon_screen.dart';
import 'package:neirobankadmin/Screens/View/pref_app_bar.dart';
import 'package:neirobankadmin/models/excel_user.dart';
import 'package:neirobankadmin/utils/create_excel.dart';
import 'package:neirobankadmin/utils/user_generator.dart';

import '../redact_screen.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState
    extends EmbedStatefullScreenState<RegistrationScreen> {
  TextEditingController startId = TextEditingController();
  TextEditingController couponRefId = TextEditingController();
  TextEditingController count = TextEditingController();

  final userCode = [];


  @override
  PreferredSizeWidget generateAppBar(BuildContext context) {
    return PrefAppBar(
      AspectRatio(
        aspectRatio: 3,
        child: FractionallySizedBox(
          widthFactor: 0.95,
          heightFactor: 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () async {
                    GetRouter.off(RedactScreen());
                  },
                  child: AutoSizeText(
                    'Главное меню',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenAdaptation.sp(70),
                    ),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () async {
                    Get.snackbar("Извините", "Страница пока не доступна");
                  },
                  child: AutoSizeText(
                    'Меню слотов',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenAdaptation.sp(70.0),
                    ),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () async {
                    GetRouter.off(GeneratorScreen());
                  },
                  child: AutoSizeText(
                    'Меню подарков',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenAdaptation.sp(70),
                    ),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () async {
                    GetRouter.off(NeiroCouponScreen());
                  },
                  child: AutoSizeText(
                    'Меню магазина',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenAdaptation.sp(70),
                    ),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () async {
                    GetRouter.off(RegistrationScreen());
                  },
                  child: AutoSizeText(
                    'Регистрация пользователей',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenAdaptation.sp(70),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget generateBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      child: AspectRatio(
        aspectRatio: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: AspectRatio(
                  aspectRatio: 13,
                  child: TextField(
                    controller: startId,
                    decoration: InputDecoration(
                      hintText: 'Start ID',
                      border: OutlineInputBorder(),
                    ),
                  )),
            ),
            Flexible(
              child: AspectRatio(
                  aspectRatio: 13,
                  child: TextField(
                    controller: couponRefId,
                    decoration: InputDecoration(
                      hintText: 'Coupon ref ID',
                      border: OutlineInputBorder(),
                    ),
                  )),
            ),
            Flexible(
              child: AspectRatio(
                  aspectRatio: 13,
                  child: TextField(
                    controller: count,
                    decoration: InputDecoration(
                      hintText: 'Count',
                      border: OutlineInputBorder(),
                    ),
                  )),
            ),
            AspectRatio(aspectRatio: 50),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                onPressed: () async {
                  int start = int.tryParse(startId.text);
                  int cnt = int.tryParse(count.text);
                  // TODO проверка правильности значений
                  String ref = couponRefId.text;
                  ref = ref?.isEmpty == true ? null : ref;
                  final res = generateUserList(start, cnt);
                  List<ExcelUser> excelUser = List.generate(cnt, (index) => ExcelUser(
                    res[index].eMail,
                      res[index].userCode,
                      res[index].userLink,
                      res[index].qrCode
                  ));
                  // List<ExcelUser> excelUser = [
                  //   ExcelUser('12334', '111111', '222222', '333333'),
                  //   ExcelUser('12734', '222222', '222222', '333333'),
                  //   ExcelUser('15334', '333333', '222222', '222222'),
                  //   ExcelUser('12634', '444444', '666666', '333333'),
                  // ];
                  createExcel(excelUser);
                  await registrateUser(res, couponRefId: ref);


                },
                child: AutoSizeText(
                  'Создать',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenAdaptation.sp(70),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
