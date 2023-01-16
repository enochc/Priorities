import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const MyApp());

const double radius = 300;
int lines = 5;
const double lineWidth = 2;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Priorities',
      home: Scaffold(
        body: HomeWidget(),
      ),
    );
  }
}

double angle(double angle) {
  return math.pi / (180 / angle);
}

void myPrint(String thing) {
  if (kDebugMode) {
    print(thing);
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MainCircle(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => lines++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MainCircle extends StatelessWidget{
  const MainCircle({super.key});

  @override
  Widget build(BuildContext context) {
    double inc = 360 / lines;
    myPrint("inc $inc");

    for (var x = 1; x <= lines; x++) {
      myPrint("${inc * x}");
    }
    Stack mystack = Stack(children: <Widget>[
      const Circle(),
      for (var x = 1; x <= lines; x++) Line(angle(inc * x))
    ]);

    return mystack;
  }


  // @override
  // Element createElement() {
  //     double inc = 360 / lines;
  //     myPrint("inc $inc");
  //
  //     for (var x = 1; x <= lines; x++) {
  //       myPrint("${inc * x}");
  //     }
  //     Stack mystack = Stack(children: <Widget>[
  //       const Circle(),
  //       for (var x = 1; x <= lines; x++) Line(angle(inc * x))
  //     ]);
  //
  //     return mystack;
  // }
}

class Line extends StatelessWidget {
  final double angle;

  const Line(this.angle, {super.key});

  @override
  Widget build(BuildContext context) {
    if (angle != 0) {
      return Center(
          child: Transform.rotate(
        angle: angle,
        child: CustomPaint(
            size: const ui.Size(radius, radius), painter: LinePainter()),
      ));
    } else {
      return Center(
          child: Center(
        child: CustomPaint(
            size: const ui.Size(radius, radius), painter: LinePainter()),
      ));
    }
  }
}

class Circle extends StatelessWidget {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
          size: const ui.Size(radius, radius), painter: CirclePainter()),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, ui.Size size) {
    canvas.drawCircle(
        const Offset(radius / 2, radius / 2),
        radius / 2,
        Paint()
          ..color = Colors.red
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LinePainter extends CustomPainter {
  //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, ui.Size size) {
    final cPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = lineWidth;

    canvas.drawLine(const Offset(radius / 2, 0),
        const Offset(radius / 2, radius / 2), cPaint); // vertical
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
