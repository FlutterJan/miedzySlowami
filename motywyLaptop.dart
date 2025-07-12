import 'package:flutter/material.dart';

class MotywyLaptop extends StatelessWidget {
  final tytul;
  final opis;
  final List listaLektur;
  const MotywyLaptop({
    super.key,
    required this.tytul,
    required this.opis,
    required this.listaLektur,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Widget _buildExpansionTile(String title, String content) {
      return Theme(
        data: Theme.of(
          context,
        ).copyWith(dividerColor: const Color.fromARGB(0, 86, 86, 86)),
        child: ExpansionTile(
          iconColor: const Color.fromARGB(220, 0, 0, 0),
          title: Text(
            title,
            style:  TextStyle(fontFamily: "Inter", fontSize: 14+width*0.006,),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                content,
                textAlign: TextAlign.left,
                style:  TextStyle(
                  fontFamily: "Inter",
                  fontSize: 12+width*0.005,
                  letterSpacing: 0.5,
                  color: Color.fromARGB(255, 30, 30, 30),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          tytul,
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: "Inter"),
        ),
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width * 0.5 + 200,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 2),
            
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Card(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: Text(
                            textAlign: TextAlign.center,
                            opis.toString(),
                            style:  TextStyle(
                              letterSpacing: 0.5,
                              fontFamily: "Inter",
                              fontSize: 14+width*0.006,
                              color: Color.fromARGB(240, 30, 30, 30),
                            ),
                          ),
                        ),
                      ),
                    ),
            
                    for (int i = 0; i < listaLektur.length; i++)
                      _buildExpansionTile(listaLektur[i][0], listaLektur[i][1]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
