import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:neirobankadmin/Additionaly/ScreenAdaptation.dart';

class CouponRedactField extends StatelessWidget {
  TextEditingController text;
  Function pluss;
  Function(CouponRedactField) minus;
  CouponRedactField(this.text, this.pluss, this.minus);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AspectRatio(
                  aspectRatio: 12,
                  child: TextField(controller: text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),)),
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.7,
                  widthFactor: 0.7,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
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
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
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
        AspectRatio(aspectRatio: 60)
      ],
    );
  }
}
