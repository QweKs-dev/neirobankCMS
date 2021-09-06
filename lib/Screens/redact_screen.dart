import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:neirobankadmin/Additionaly/EmbedScreen.dart';
import 'package:neirobankadmin/Additionaly/GetRouter.dart';

import 'package:html_editor_enhanced/html_editor.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:neirobankadmin/Additionaly/ScreenAdaptation.dart';
import 'package:neirobankadmin/Additionaly/embed_statefull_screen.dart';
import 'package:neirobankadmin/Screens/Generator/generator_screen.dart';
import 'package:neirobankadmin/Screens/View/drop_down.dart';
import 'package:neirobankadmin/Screens/View/list_view_redact.dart';
import 'package:neirobankadmin/Screens/View/pref_app_bar.dart';
import 'package:neirobankadmin/Screens/View/redact_versions.dart';
import 'package:neirobankadmin/Screens/example_test.dart';

import 'NeiroCouponRequest/neiro_coupon_screen.dart';
import 'Registration/registration_screen.dart';

class RedactScreen extends StatefulWidget {
  @override
  _RedactScreenState createState() => _RedactScreenState();
}

class _RedactScreenState extends EmbedStatefullScreenState<RedactScreen> {
  HtmlEditorController controller = HtmlEditorController();

  ScrollController scrollController = ScrollController();

  String editorName;

  String editorPath;

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.98,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(aspectRatio: 100),
                AutoSizeText(
                  'Редактировать текст игр',
                  style: TextStyle(fontSize: ScreenAdaptation.sp(80)),
                ),
                AspectRatio(
                  aspectRatio: 3,
                  child: ExampleTest(),
                ),
                AutoSizeText(
                  'Редактировать ежедневные купоны',
                  style: TextStyle(fontSize: ScreenAdaptation.sp(80)),
                ),
                Expanded(
                    child: FractionallySizedBox(widthFactor: 0.98, child: ListViewRedact())),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropDown(onSelected: (key, value){
                editorName = key;
                editorPath = value;
                setState(() {
                });
              },),
              if(editorPath!=null)
                Expanded(child: RedactVersions(url: editorPath))
            ],
          ),
        )

        //

          // AspectRatio(
          //   aspectRatio: 1,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       AutoSizeText(
          //         'Neirobank public',
          //         style: TextStyle(fontSize: ScreenAdaptation.sp(80)),
          //       ),
          //       FractionallySizedBox(
          //           widthFactor: 0.6, child: RedactVersions(url: 'https://nirobankd.com/neirobank_update.json')),
          //       AutoSizeText(
          //         'Neirobank dev',
          //         style: TextStyle(fontSize: ScreenAdaptation.sp(80)),
          //       ),
          //       FractionallySizedBox(
          //           widthFactor: 0.6, child: RedactVersions(url: 'https://nirobankd.com/neirobank_update_dev.json')),
          //       AutoSizeText(
          //         'Кассир public',
          //         style: TextStyle(fontSize: ScreenAdaptation.sp(80)),
          //       ),
          //       FractionallySizedBox(
          //           widthFactor: 0.6,
          //           child: RedactVersions(
          //               url: 'https://nirobankd.com/kassier_update.json')),
          //       AutoSizeText(
          //         'Кассир dev',
          //         style: TextStyle(fontSize: ScreenAdaptation.sp(80)),
          //       ),
          //       FractionallySizedBox(
          //           widthFactor: 0.6,
          //           child: RedactVersions(
          //               url: 'https://nirobankd.com/kassier_update_dev.json')),
          //     ],
          //   ),
          // )
      ],
    );
  }
}
