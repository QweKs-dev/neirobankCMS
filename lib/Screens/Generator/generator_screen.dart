import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neirobank_server_api/neirobank_server_api.dart';
import 'package:neirobankadmin/Additionaly/GetRouter.dart';
import 'package:neirobankadmin/Additionaly/ScreenAdaptation.dart';
import 'package:neirobankadmin/Additionaly/embed_statefull_screen.dart';
import 'package:neirobankadmin/Screens/Generator/generator_field.dart';
import 'package:http/http.dart' as http;
import 'package:neirobankadmin/Screens/NeiroCouponRequest/neiro_coupon_screen.dart';
import 'package:neirobankadmin/Screens/Registration/registration_screen.dart';
import 'package:neirobankadmin/Screens/View/pref_app_bar.dart';

import '../redact_screen.dart';

class GeneratorScreen extends StatefulWidget {
  GeneratorScreen({Key key}) : super(key: key);

  @override
  _GeneratorScreenState createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends EmbedStatefullScreenState<GeneratorScreen> {
  ServerApi serverApi = ServerApi();

  ScrollController scrollController = ScrollController();

  List<GeneratorField> fieldGenerator = [];
  List<TextEditingController> textEditingControllerName = [];
  List<TextEditingController> textEditingControllerLink = [];

  void buildField() {
    textEditingControllerName.add(TextEditingController());
    textEditingControllerLink.add(TextEditingController());
    fieldGenerator.add(GeneratorField(textEditingControllerName.last,
        textEditingControllerLink.last, buildField, removeField));
    setState(() {});
  }

  void removeField(GeneratorField generatorField) {
    if (fieldGenerator.length == 1) return;
    var i = fieldGenerator.indexOf(generatorField);
    textEditingControllerName.removeAt(i);
    textEditingControllerLink.removeAt(i);
    fieldGenerator.removeAt(i);
    setState(() {});
  }

  @override
  void initState() {
    serverApi
        .request(NeiroRequest('https://nirobankd.com/linkCacha.json', serverApi,
            {'Content-Type': 'application/json', 'accept': 'application/json'}))
        .then((value) {
      List uuid;
      if (value.data.containsKey('data')) {
        uuid = (value.data['data']);
      } else
        uuid = [];
      for (var i in uuid) {
        textEditingControllerName.add(TextEditingController()..text = i.keys.first);
        textEditingControllerLink.add(TextEditingController()..text = i.values.first);
        fieldGenerator.add(GeneratorField(textEditingControllerName.last,
            textEditingControllerLink.last, buildField, removeField));
      }
      setState(() {});
    });
    super.initState();
  }

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
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index == fieldGenerator.length)
          return FractionallySizedBox(
            widthFactor: 0.2,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                onPressed: () async {
                  String text = jsonEncode({
                    'data': List.generate(
                        textEditingControllerLink.length,
                        (index) => {
                              textEditingControllerName.elementAt(index).text:
                                  textEditingControllerLink
                                      .elementAt(index)
                                      .text
                            }).toList()
                  });
                  print('TEST1 $text');
                  var uri = Uri.parse('https://nirobankd.com/uploadApp.php');
                  var request = http.MultipartRequest('POST', uri)
                    ..files.add(http.MultipartFile.fromString('inputfile', text,
                        filename: 'linkCacha.json'));
                  print('TEST1 $request');
                  var response = await request.send();
                  print('TEST2 $response');
                  if (response.statusCode == 200)
                    Get.snackbar("Сохранено", "Успешно");
                  else {
                    Get.snackbar("Ошибка", "Сохранить не удалось");
                  }
                },
                child: AutoSizeText(
                  'Сохранить',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenAdaptation.sp(70),
                  ),
                )),
          );
        return fieldGenerator[index];
      },
      itemCount: fieldGenerator.length + 1,
    );
  }
}
