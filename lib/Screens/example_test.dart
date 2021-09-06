import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:neirobank_server_api/neirobank_server_api.dart';
import 'package:neirobankadmin/Additionaly/ScreenAdaptation.dart';
import 'package:http/http.dart' as http;
import 'package:neirobankadmin/Screens/View/html_editor_panel.dart';

class ExampleTest extends StatefulWidget {
  ExampleTest({Key key}) : super(key: key);

  @override
  _ExampleTestState createState() => _ExampleTestState();
}

class _ExampleTestState extends State<ExampleTest> {
  String result = "";
  final HtmlEditorController controller = HtmlEditorController();
  ScrollController scrollController = ScrollController();
  ServerApi serverApi = ServerApi();
  Completer<NeiroResponse> completer;

  @override
  void initState() {
    completer = Completer();
    completer.complete(serverApi.request(NeiroRequest(
        'https://nirobankd.com/prizeInfo.json', serverApi, {
      'Content-Type': 'application/json',
      'accept': 'application/json'
    })));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: FutureBuilder<NeiroResponse>(
              future: completer.future,
              builder: (context, snapshot) {
                String html;
                if (snapshot.hasError)
                  html = '';
                else if (snapshot.hasData &&
                    snapshot.data.data.containsKey('data')) {
                  html = snapshot.data.data['data'];
                } else
                  html = '';
                html = html.replaceAll('\\\'', '');
                html = html.replaceAll('\\\"', '\"');
                if(!snapshot.hasData && !snapshot.hasError) return CircularProgressIndicator();
                controller.insertText(html);
                return HtmlEditorPanel(controller);
              }),
        ),
        AspectRatio(aspectRatio: 90),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            onPressed: () async {

              String text = jsonEncode({'data': (await controller.getText())});
              text = text.replaceAll('\\\\\'', '');
              print(text);
              var uri = Uri.parse('https://nirobankd.com/uploadApp.php');
              var request = http.MultipartRequest('POST', uri)
              ..files.add(http.MultipartFile.fromString('inputfile', text, filename: 'prizeInfo.json') );
              var response = await request.send();
              if (response.statusCode == 200) {
                Get.snackbar("Сохранено", "Успешно");

              }
              else Get.snackbar("Ошибка", "Сохранить не удалось");
            },
            child: AutoSizeText(
              'Сохранить',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenAdaptation.sp(70),
              ),
            ))
      ],
    );
  }
}
