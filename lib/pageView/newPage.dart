import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: width * .1),
        child: SizedBox(
          height: height / 1.5,
          width: width,
          child: CustomPaint(
            painter: CustomCurveDesign(height: height, width: width),
          ),
        ),
      ),
    );
  }
}

class CustomCurveDesign extends CustomPainter {
  var height;
  var width;
  CustomCurveDesign({required this.height, required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..strokeWidth = 10;
    paint.color = Colors.black;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(width * .2, height * .05);
    path.quadraticBezierTo(
        (width * .1) - 50, (height * .15), width * .2, height * .25);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
