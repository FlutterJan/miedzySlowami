import 'package:flutter/material.dart';
import 'package:human_maturalny/epoki.dart';
import 'package:path_drawing/path_drawing.dart';

class MenuEpoki extends StatelessWidget {
  const MenuEpoki({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Center(child: const Text("Epoki", style: TextStyle(fontFamily: "Inter"))),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: DrogaPainter())),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: box("Starożytność", "X w. p.n.e. - V w. n.e.",1,context),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: box("Średniowiecze", "V - XV",2,context),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: box("Renesans", "XIV - XVII",3,context),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: box("Barok", "XVI - XVIII",4,context),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: box("Oświecenie", "1685 – 1815",5,context),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: box("Romantyzm", "XVIII - XIX",6,context),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: box("Pozytywizm", "1864 - 1890",7,context),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: box("Młoda Polska", "1890 - 1918",8,context),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: box("Dwudziestolecie międzywojenne", "1918 - 1939",9,context),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: box("Wojna i okupacja", "1939 - 1945",10,context),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: box("Współczesność", "1945+",11,context),
                ),
                SizedBox(height: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget box(String nazwaEpoki, String ramyCzasowe, int nrEpoki,  context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      height: 80,
      width: 180,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
        Navigator.of(context).push(_createRoute(OpisEpoki(nrEpoki: nrEpoki)));
      },
        child: Card(
          color: Colors.white,
          elevation: 4,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nazwaEpoki,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: Color(0xFF141414),
                  ),
                ),
                Text(
                  ramyCzasowe,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    color: Color(0xFF141414),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrogaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(120, 117, 117, 117)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    double xLeft = 50;
    double xRight = size.width - 50;
    double y = 60;

    path.moveTo(xLeft, y);

    y += 110;
    path.quadraticBezierTo(xLeft, y - 55, xRight, y);

    y += 110;
    path.quadraticBezierTo(xRight, y - 55, xLeft, y);

    y += 110;
    path.quadraticBezierTo(xLeft, y - 55, xRight, y);

    y += 110;
    path.quadraticBezierTo(xRight, y - 55, xLeft, y);

    y += 110;
    path.quadraticBezierTo(xLeft, y - 55, xRight, y);
    y += 110;
    path.quadraticBezierTo(xRight, y - 55, xLeft, y);

    y += 110;
    path.quadraticBezierTo(xLeft, y - 55, xRight, y);

    y += 110;
    path.quadraticBezierTo(xRight, y - 55, xLeft, y);

    y += 110;
    path.quadraticBezierTo(xLeft, y - 55, xRight, y);
    y += 110;
    path.quadraticBezierTo(xRight, y - 55, xLeft, y);

    final dashedPath = dashPath(
      path,
      dashArray: CircularIntervalList<double>(<double>[8, 6]),
    );

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 600),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const beginOffset = Offset(0.0, 1.0);
      const endOffset = Offset.zero;
      const curve = Curves.easeInOut;

      final tween = Tween(
        begin: beginOffset,
        end: endOffset,
      ).chain(CurveTween(curve: curve));
      final fadeTween = Tween<double>(begin: 0.0, end: 1.0);

      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(
          opacity: animation.drive(fadeTween),
          child: child,
        ),
      );
    },
  );
}