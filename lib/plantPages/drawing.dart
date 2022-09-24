import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  var height;
  var width;
  CurvePainter({required this.height, required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..strokeWidth = 10;
    paint.color = Color.fromARGB(255, 100, 161, 73);
    paint.style = PaintingStyle.fill;
    var path = Path();

    path.moveTo(0, height * .35);
    path.lineTo(0, height * .9);
    path.lineTo(width, height * .9);
    path.lineTo(width, height * .65);
    path.lineTo(width * .4, height * .65);
    path.quadraticBezierTo(width * 0.005, (height * .55) + 50, 0, height * .35);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
