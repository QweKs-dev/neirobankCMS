import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:neirobankadmin/Additionaly/ScreenAdaptation.dart';

class DropDown extends StatefulWidget {
  Function(String, String) onSelected;
  DropDown({Key key, this.onSelected}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final mapOfSelect = {
    'Neirobank public': 'https://nirobankd.com/neirobank_update.json',
    'Neirobank dev': 'https://nirobankd.com/neirobank_update_dev.json',
    'Кассир public': 'https://nirobankd.com/kassier_update.json',
    'Кассир dev': 'https://nirobankd.com/kassier_update_dev.json',
  };
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = mapOfSelect.keys.elementAt(0);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.onSelected?.call(dropdownValue, mapOfSelect[dropdownValue]);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0)),
          child: DropdownButton(
            value: dropdownValue,
            items: List.generate(
              mapOfSelect.keys.length,
              (index) => DropdownMenuItem(
                value: mapOfSelect.keys.elementAt(index),
                child: AutoSizeText(mapOfSelect.keys.elementAt(index), style: 
                  TextStyle(color: Colors.black,
                  fontSize: ScreenAdaptation.sp(70)),),
              ),
            ),
            onChanged: (String newValue) {
              widget.onSelected?.call(newValue, mapOfSelect[newValue]);
              setState(() {
                dropdownValue = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
