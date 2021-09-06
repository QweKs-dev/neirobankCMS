import 'dart:async';
import 'dart:convert' show json, jsonEncode;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:neirobank_server_api/neirobank_server_api.dart';
import 'package:neirobankadmin/Additionaly/ScreenAdaptation.dart';
import 'package:http/http.dart' as http;
import 'package:neirobankadmin/Screens/View/html_editor_panel.dart';

class RedactVersions extends StatefulWidget {
  String url;
  RedactVersions({Key key, this.url}) : super(key: key);

  @override
  _RedactVersionsState createState() => _RedactVersionsState();
}

class _RedactVersionsState extends State<RedactVersions> {

  bool criticalUpdate = false;
  TextEditingController iosVersion = TextEditingController();
  TextEditingController androidVersion = TextEditingController();
  TextEditingController linkPM = TextEditingController();
  String description = '';
  final HtmlEditorController controller = HtmlEditorController();
  ScrollController scrollController = ScrollController();
  ServerApi serverApi = ServerApi();
  //Completer<NeiroResponse> completer;


  @override
  void initState() {
    // completer = Completer();
    // completer.complete();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NeiroResponse>(
      future: serverApi.request(NeiroRequest(
          widget.url, serverApi, {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      })),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.data.containsKey('realese_0_1_4')) {
          criticalUpdate = snapshot.data.data.values.first['critical'];
          iosVersion.text = snapshot.data.data.values.first['ios']['version'];
          androidVersion.text = snapshot.data.data.values.first['android']['version'];
          linkPM.text = snapshot.data.data.values.first['android']['url'];
          description = snapshot.data.data.values.first['description']['default']['text'];
        }
        description = description.replaceAll('\\\'', '\'');
        description = description.replaceAll('\\\"', '\"');
        if(!snapshot.hasData && !snapshot.hasError) return CircularProgressIndicator();
        if(snapshot.hasError) print(snapshot.error);
        return FractionallySizedBox(
          widthFactor: 0.98,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(
                title: Text('Критическое обновление'),
                leading: Checkbox(
                  value: criticalUpdate,
                  onChanged: (value){
                    setState(() {
                      criticalUpdate = value;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: TextField(controller: androidVersion,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),),
                  ),
                  AutoSizeText(
                    'Версия Android',
                    style: TextStyle(fontSize: ScreenAdaptation.sp(80)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      child: TextField(controller: linkPM,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),)),
                  AutoSizeText(
                    'Ссылка Play Market',
                    style: TextStyle(fontSize: ScreenAdaptation.sp(80)),
                  ),
                ],
              ),
              Expanded(child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0),
                  child: HtmlEditorPanel(controller))),
              AspectRatio(aspectRatio: 30),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: ()async {
                    String text = jsonEncode({
                      "realese_0_1_4":{
                        "critical":criticalUpdate,
                        "can_ignore":false,
                        "can_later":false,
                        "date":"18:21 21.12.2020",
                        "description":{
                          "default":{
                            "title":"Новое обновление",
                            "text": await controller.getText()
                          }
                        },
                        "android":{
                          "url":linkPM.text,
                          "version":androidVersion.text
                        },
                        "ios":{
                          "version":androidVersion.text
                        }
                      }
                    }
                    );
                    text = text.replaceAll('\\\\\'', '');
                    var uri = Uri.parse('https://nirobankd.com/uploadApp.php');
                    var request = http.MultipartRequest('POST', uri)
                      ..files.add(http.MultipartFile.fromString('inputfile', text, filename: widget.url.split('/').last) );
                    var response = await request.send();
                    if (response.statusCode == 200) Get.snackbar("Сохранено", "Успешно");
                    else Get.snackbar("Ошибка", "Сохранить не удалось");
                  },
                  child: AutoSizeText('Сохранить',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenAdaptation.sp(70),
                    ),)),
              AspectRatio(aspectRatio: 30)
            ],
          ),
        );
      }
    );
  }
}