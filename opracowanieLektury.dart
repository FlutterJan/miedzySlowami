import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OpracowanieLektury extends StatefulWidget {
  final int nrLektury;
  const OpracowanieLektury({super.key, required this.nrLektury});

  @override
  _OpracowanieLekturyState createState() => _OpracowanieLekturyState();
}

class _OpracowanieLekturyState extends State<OpracowanieLektury> {
  late Future<List<List<dynamic>>> _futureCsv;

  @override
  void initState() {
    super.initState();
    _futureCsv = wczytajCsv();
  }

  Future<List<List<dynamic>>> wczytajCsv() async {
    final String csvString = await rootBundle.loadString(
      'assets/dane/daneLektury.csv',
    );
    List<List<dynamic>> csvTable = const CsvToListConverter(
      fieldDelimiter: ';',
      eol: '\r\n',
      textDelimiter: '"',
    ).convert(csvString);

    return csvTable;
  }

  @override
  Widget build(BuildContext context) {
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

          if (widget.nrLektury < 0 || widget.nrLektury >= csvData.length) {
            return Scaffold(
              body: Center(child: Text('Nieprawidłowy numer lektury')),
            );
          }

          final row = csvData[widget.nrLektury];

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: Text(row[0], style: const TextStyle(fontFamily: "Inter")),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 2),
                    if (row[1].toString() != "-")
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "Autor: ",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                row[1].toString(),
                                style: const TextStyle(
                                  letterSpacing: 0.5,
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 30, 30, 30)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
  
                    _buildExpansionTile('Geneza', row[2].toString()),
                    _buildExpansionTile('Gatunek', row[3].toString()),
                    _buildExpansionTile(
                      'Czas i miejsce akcji',
                      row[4].toString(),
                    ),
                    _buildExpansionTile('Bohaterowie', row[5].toString()),
                    _buildExpansionTile('Streszczenie', row[6].toString()),
                    
                    if (row[7].toString() != "-")
                    _buildExpansionTile('Pytania Jawne',  row[7].toString()),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

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
}
