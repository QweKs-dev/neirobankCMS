import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neirobank_server_api/neirobank_server_api.dart';
import 'package:neirobankadmin/Additionaly/ScreenAdaptation.dart';
import 'package:neirobankadmin/Screens/View/coupon_redact_field.dart';
import 'package:http/http.dart' as http;

class ListViewRedact extends StatefulWidget {
  ListViewRedact({Key key}) : super(key: key);

  @override
  _ListViewRedactState createState() => _ListViewRedactState();
}

class _ListViewRedactState extends State<ListViewRedact> {
  ServerApi serverApi = ServerApi();

  @override
  void initState() {
    serverApi
        .request(NeiroRequest('https://nirobankd.com/prize.json', serverApi,
            {'Content-Type': 'application/json', 'accept': 'application/json'}))
        .then((value) {
      List<String> uuid;
      if (value.data.containsKey('data')) {
        uuid = (value.data['data'] as List<dynamic>).cast();
      } else
        uuid = [''];
      for (var i in uuid) {
        textEditingController.add(TextEditingController()..text = i);
        fieldRedactCoupon.add(CouponRedactField(
            textEditingController.last, buildField, removeField));
      }
      setState(() {});
    });
    super.initState();
  }

  ScrollController scrollController = ScrollController();

  List<CouponRedactField> fieldRedactCoupon = [];
  List<TextEditingController> textEditingController = [];

  void buildField() {
    textEditingController.add(TextEditingController());
    fieldRedactCoupon.add(
        CouponRedactField(textEditingController.last, buildField, removeField));
    setState(() {});
  }

  void removeField(CouponRedactField couponRedactField) {
    if (fieldRedactCoupon.length == 1) return;
    var i = fieldRedactCoupon.indexOf(couponRedactField);
    textEditingController.removeAt(i);
    fieldRedactCoupon.removeAt(i);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index == fieldRedactCoupon.length)
          return ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green)),
              onPressed: () async {
                String text = jsonEncode({
                  'data': List.generate(textEditingController.length,
                          (index) => textEditingController[index].text)
                });
                var uri =
                Uri.parse('https://nirobankd.com/uploadApp.php');
                var request = http.MultipartRequest('POST', uri)
                  ..files.add(http.MultipartFile.fromString(
                      'inputfile', text,
                      filename: 'prize.json'));
                var response = await request.send();
                if (response.statusCode == 200)
                  Get.snackbar("Сохранено", "Успешно");
                else {
                  Get.snackbar("Ошибка", "Сохранить не удалось");
                }
              },
              //a8b2ecd3-82aa-439d-b9ca-be97e832ab54
              child: AutoSizeText(
                'Сохранить',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenAdaptation.sp(70),
                ),
              ));
        return fieldRedactCoupon[index];
      },
      itemCount: fieldRedactCoupon.length + 1,
    );
  }
}
