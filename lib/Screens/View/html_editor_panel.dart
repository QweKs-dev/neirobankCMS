import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class HtmlEditorPanel extends StatelessWidget {
  HtmlEditorController controller;

  HtmlEditorPanel(this.controller);

  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
      controller: controller,
      options: HtmlEditorOptions(
          shouldEnsureVisible: false, autoAdjustHeight: false),
      toolbar: [],

    );
  }
}
