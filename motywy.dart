import 'package:flutter/material.dart';

class Motyw extends StatelessWidget {
  final tytul;
  final opis;
  final List listaLektur;
  const Motyw({
    super.key,
    required this.tytul,
    required this.opis,
    required this.listaLektur,
  });

  @override
  Widget build(BuildContext context) {
    Widget _buildExpansionTile(String title, String content) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: const Color.fromARGB(0, 86, 86, 86),
      ),
      child: ExpansionTile(
        iconColor: const Color.fromARGB(220, 0, 0, 0),
        title: Text(
          title,
          style: const TextStyle(fontFamily: "Inter", fontSize: 14),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              content,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 12,
                letterSpacing: 0.5,
                color: Color.fromARGB(255, 30, 30, 30)
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
              title: Text(tytul,textAlign: TextAlign.center, style: const TextStyle(fontFamily: "Inter")),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 2),
                    
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child:Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(12),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  opis.toString(),
                                  style: const TextStyle(
                                    letterSpacing: 0.5,
                                    fontFamily: "Inter",
                                    fontSize: 13,
                                    color: Color.fromARGB(240, 30, 30, 30)
                                  ),
                                ),
                              ),
                        ),
                      ),
  
                    for (int i = 0; i<listaLektur.length; i++)
                      _buildExpansionTile(listaLektur[i][0], listaLektur[i][1])
                  ],
                ),
              ),
            ),
          );
  }
}
