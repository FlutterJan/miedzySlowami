import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class PytaniaJawneLaptop extends StatefulWidget {
  int nrPytania;
  PytaniaJawneLaptop({super.key, required this.nrPytania});

  @override
  State<PytaniaJawneLaptop> createState() => _PytaniaJawneLaptopState();
}

class _PytaniaJawneLaptopState extends State<PytaniaJawneLaptop> {
  late Future<List<List<dynamic>>> _futureCsv;
  @override
  void initState() {
    super.initState();
    _futureCsv = wczytajCsv();
  }

  Future<List<List<dynamic>>> wczytajCsv() async {
    final String csvString = await rootBundle.loadString(
      'assets/dane/jawneDane.csv',
    );
    List<List<dynamic>> csvTable = const CsvToListConverter(
      fieldDelimiter: ';',
      eol: '\r\n',
      textDelimiter: '"',
    ).convert(csvString);

    return csvTable;
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<List<dynamic>>>(
      future: _futureCsv,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Błąd podczas wczytywania danych')),
          );
        } else {
          final csvData = snapshot.data!;

          if (widget.nrPytania < 0 || widget.nrPytania >= csvData.length) {
            return Scaffold(
              body: Center(child: Text('Nieprawidłowy numer lektury')),
            );
          }

          final row = csvData[widget.nrPytania];

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 1,
              centerTitle: true,
              title: Text(
                "Pytanie ${row[0]}",
                style: const TextStyle(
                  fontFamily: "Inter",

                  // fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * 0.4 + 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE0E0E0)),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: SelectableText(
                              row[2].toString(),
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                fontFamily: "Inter",
                                fontStyle: FontStyle.italic,
                                fontSize: 14+width*0.005,
                                color: Color(0xFF141414),
                              ),
                            ),
                          ),
                    
                          const SizedBox(height: 25),
                    
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              row[3].toString(),
                              style:  TextStyle(
                                fontFamily: "Inter",
                               fontSize: 12+width*0.005,
                                color: Color.fromARGB(255, 30, 30, 30),
                              ),
                            ),
                          ),
                          SizedBox(height: 100,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
