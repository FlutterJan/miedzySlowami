import 'package:flutter/material.dart';
import 'package:human_maturalny/laptop%20/fiszkiLaptop.dart';
import 'package:human_maturalny/zapisaneFiszki.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuFiszkiLaptop extends StatefulWidget {
  const MenuFiszkiLaptop({super.key});

  @override
  State<MenuFiszkiLaptop> createState() => _MenuFiszkiLaptopState();
}

class _MenuFiszkiLaptopState extends State<MenuFiszkiLaptop> {
  late Future<List<int>> tablica;

  @override
  void initState() {
    super.initState();
    tablica = loadIntValue();
  }

  Future<List<int>> loadIntValue() async {
    final prefs = await SharedPreferences.getInstance();
    return [
      prefs.getInt('fiszki_index_0') ?? 0,
      prefs.getInt('fiszki_index_1') ?? 0,
      prefs.getInt('fiszki_index_2') ?? 0,
      prefs.getInt('fiszki_index_3') ?? 0,
      prefs.getInt('fiszki_index_4') ?? 0,
      prefs.getInt('fiszki_index_5') ?? 0,
    ];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Widget box(nr1, nr2, nazwa, index) {
      return InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          await Navigator.of(
            context,
          ).push(_createRoute(FiszkiLaptop(nr: index)));
          setState(() {
            tablica = loadIntValue();
          });
        },
        child: Container(
          width: height * 0.3,
          height: height * 0.3,
          //padding: EdgeInsets.all(width * 0.05),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                spreadRadius: 1,
                offset: Offset(0, 10),
              ),
            ],
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "$nr1/$nr2",
                    style:  TextStyle(
                      fontFamily: "Inter",
                      fontSize: 12+width*0.005,
                      letterSpacing: 0.5,
                    ),
                  ),
                  CircularProgressIndicator(
                    backgroundColor: Color.fromARGB(20, 70, 70, 70),
                    color: const Color.fromARGB(160, 70, 70, 70),
                    strokeAlign: 10+width*0.008,
                    strokeWidth: 1.5,
                    value: nr2 > 0 ? nr1 / nr2 : 0,
                  ),
                ],
              ),
              SizedBox(height: height*0.025,),
              Text(
                nazwa,
                textAlign: TextAlign.center,
                style:  TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14+width*0.006,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder(
      future: tablica,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Błąd: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final dane = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text("Fiszki", style: TextStyle(fontFamily: "Inter")),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  box(dane[0], 107, "Środki stylistyczne", 0),
                  box(dane[1], 204, "Lektury", 1),
                  box(dane[2], 144, "Filozofie", 2),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  box(dane[3], 159, "Epoki", 3),
                  box(dane[4], 166, "Motywy", 4),
                  box(dane[5], 169, "Konteksty", 5),
                ],
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.of(context).push(_createRoute(ZapisaneFiszki()));
                },
                child: Container(
                  width: 175 + width * 0.1,
                  height: 60 + width * 0.01,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        spreadRadius: 1,
                        offset: Offset(0, 10),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "Zapisane fiszki",
                      style:  TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14+width*0.006,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0),
            ],
          ),
        );
      },
    );
  }
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
