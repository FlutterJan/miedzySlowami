import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:human_maturalny/laptop%20/opracowanieLekturyLaptop.dart';


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

class LekturyLaptop extends StatefulWidget {
  const LekturyLaptop({super.key});

  @override
  State<LekturyLaptop> createState() => _LekturyLaptopState();
}

class _LekturyLaptopState extends State<LekturyLaptop> {
  late Future<List<List<dynamic>>> daneFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Widget naglowek(text,double width) {
      return Text(
        text,

        // style: GoogleFonts.playfairDisplay(
        //   letterSpacing: -0.5,
        //   fontSize: 24,
        //   fontWeight: FontWeight.w500,
        //   color: const Color.fromARGB(255, 115, 115, 115),
        // ),
        style:  TextStyle(
          letterSpacing: -0,
          fontFamily: "Inter",
          fontWeight: FontWeight.w100,
          //fontStyle: FontStyle.italic,
          fontSize: 24+ width*0.015,
          color: const Color.fromARGB(255, 80, 80, 80),
        ),
      );
    }

    Widget karta(nazwa, int numerLekturyLaptop) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(25, 0, 0, 0),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(8, 8),
            ),
          ],
        ),
        margin: EdgeInsets.only(right: width * 0.025),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 2),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.of(context).push(
                    _createRoute(Opracowanielekturylaptop(nrLektury: numerLekturyLaptop)),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.asset(
                    height: height * 0.16+width*0.05,
                    "assets/images/$nazwa.png",
                  ),
                ),
              ),
              SizedBox(height: 3),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   surfaceTintColor: Colors.white,
      //   title: Text("LekturyLaptop ", style: TextStyle(fontFamily: "Inter")),
      // ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(width * 0.05),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    naglowek("Starożytność",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        
                        child: Row(
                          children: [
                            SizedBox(child: karta("biblia", 1)),
                            SizedBox(child: karta("mitologia", 2)),
                            SizedBox(child: karta("antygona", 3)),
                            SizedBox(child: karta("iliada", 4)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    naglowek("Średniowiecze",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(child: karta("piesnORolandzie", 7)),
                          SizedBox(child: karta("rozmowaPolikarpa", 6)),
                          SizedBox(child: karta("lamentSwietokrzyski", 5)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    naglowek("Renesans",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [SizedBox(child: karta("treny", 8))]),
                    ),
                    SizedBox(height: 20),
                    naglowek("Barok",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(child: karta("makbet", 9)),
                          SizedBox(child: karta("skapiec", 10)),
                        ],
                      ),
                    ),
                
                    SizedBox(height: 20),
                    naglowek("Oświecenie",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(child: karta("zonaModna", 11)),
                          SizedBox(child: karta("pijanstwo", 12)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    naglowek("Romantyzm",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(child: karta("dziady", 14)),
                          SizedBox(child: karta("kordian", 16)),
                          SizedBox(child: karta("panTadeusz", 35)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    naglowek("Pozytywizm",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        child: Row(
                          children: [
                            SizedBox(child: karta("lalka", 17)),
                            SizedBox(child: karta("potop", 18)),
                            SizedBox(child: karta("zbrodniaIKara", 19)),
                            SizedBox(child: karta("gloriaVictis", 20)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    naglowek("Młoda Polska",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(child: karta("chlopi", 22)),
                          SizedBox(child: karta("wesele", 21)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    naglowek("Dwudziestolecie międzywojenne",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(child: karta("przedwiosnie", 23)),
                          SizedBox(child: karta("ferdydurke", 24)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    naglowek("Wojna i okupacja",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(child: karta("innySwiat", 26)),
                          SizedBox(child: karta("proszePanstwaDoGazu", 25)),
                          SizedBox(child: karta("zdazycPrzedPanemBogiem", 27)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    naglowek("Współczesnosć",width),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        child: Row(
                          children: [
                            SizedBox(child: karta("rok1984", 29)),
                            SizedBox(child: karta("dzuma", 28)),
                            SizedBox(child: karta("miejsce", 32)),
                            SizedBox(child: karta("tango", 30)),
                            
                          ],
                        ),
                        
                      ),
                    ),
                    SizedBox(height: 30,), 
                    Row(children: [SizedBox(child: karta("profesorAndrewsWWarszawie", 33)),
                            SizedBox(child: karta("podrozeZHerodotem", 34)),
                            SizedBox(child: karta("goraEdek", 31)),],),
                    SizedBox(height: height * 0.1),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
