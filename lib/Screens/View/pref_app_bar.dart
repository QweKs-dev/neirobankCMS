import 'package:flutter/material.dart';

class PrefAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget child;

  PrefAppBar(this.child);
  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}

