
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'GetRouter.dart';
import 'embed_screen_core.dart';


class EmbedStatefullScreenState<T extends StatefulWidget> extends State<T> {
  Widget generateBody(BuildContext context) => null;

  PreferredSizeWidget generateAppBar(BuildContext context) => null;

  Widget generateBottomBar(BuildContext context) => null;

  Widget generateNavBar(BuildContext context) => null;

  Widget _generateAdaptiveBody(BuildContext context) {
    if (GetPlatform.isAndroid || GetPlatform.isAndroid)
      return generateBody(context);
    else
      return LayoutBuilder(builder: (context, constrains) {
        return generateBody(context)??Container();
      });
  }

  Future<bool> onWillPop() async {
    await GetRouter.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isAndroid)
      return WillPopScope(
          child: EmbedScreenBulder.buildScreen(
            body: _generateAdaptiveBody(context)??Container(),
            drawer: generateNavBar(context),
            appBar: generateAppBar(context),
            bottomBar: generateBottomBar(context),
          ),
          onWillPop: onWillPop);
    else
      return EmbedScreenBulder.buildScreen(
        body: _generateAdaptiveBody(context)??Container(),
        drawer: generateNavBar(context),
        appBar: generateAppBar(context),
        bottomBar: generateBottomBar(context),
      );
  }
}
