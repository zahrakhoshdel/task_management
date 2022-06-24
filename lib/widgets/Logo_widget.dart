// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LogoWidget extends StatelessWidget {
  final kBackgroundColor = const Color(0xFFf6f9fe);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        depth: 8,
        lightSource: LightSource.topLeft,
        color: kBackgroundColor,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(
              Icons.calendar_month,
              color: Colors.deepPurpleAccent,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
