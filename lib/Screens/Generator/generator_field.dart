import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:neirobankadmin/Additionaly/ScreenAdaptation.dart';

class GeneratorField extends StatelessWidget {
  TextEditingController name;
  TextEditingController link;
  Function pluss;
  Function(GeneratorField) minus;

  GeneratorField(this.name, this.link, this.pluss, this.minus);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
          ),
          child: AspectRatio(
            aspectRatio: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: AspectRatio(
                          aspectRatio: 13,
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                          )),
                    ),
                    Flexible(
                      child: AspectRatio(
                          aspectRatio: 13,
                          child: TextField(
                            controller: link,
                            decoration: InputDecoration(
                              hintText: 'Link',
                              border: OutlineInputBorder(),
                            ),
                          )),
                    ),
                  ],
                ),
                Flexible(
                  child: FractionallySizedBox(
                    heightFactor: 0.5,
                    widthFactor: 0.5,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green)),
                          onPressed: pluss,
                          child: AutoSizeText(
                            '+',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: ScreenAdaptation.sp(70),
                            ),
                          )),
                    ),
                  ),
                ),
                Flexible(
                  child: FractionallySizedBox(
                    heightFactor: 0.6,
                    widthFactor: 0.6,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: () {
                            minus?.call(this);
                          },
                          child: AutoSizeText(
                            '-',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenAdaptation.sp(70),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AspectRatio(aspectRatio: 60)
      ],
    );
  }
}
