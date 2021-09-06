import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neirobankadmin/Additionaly/EmbedScreen.dart';
import 'package:neirobankadmin/Additionaly/GetRouter.dart';
import 'package:neirobankadmin/Additionaly/ScreenAdaptation.dart';
import 'package:neirobankadmin/Screens/redact_screen.dart';

class FirstScreen extends EmbedScreen {

  TextEditingController controller = TextEditingController();

  @override
  Widget generateBody(BuildContext context) {
    ScreenAdaptation.setup(1920, 1080);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: TextField(controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green)),
              onPressed: () {

                if(controller.text == 'neirobankiscool'){
                  GetRouter.off(RedactScreen());
                } else Get.snackbar("Ошибка", "Неверный пароль");
              },
              child: AutoSizeText('Войти',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenAdaptation.sp(70),
                ),)),
        ],
      ),
    );
  }
}
