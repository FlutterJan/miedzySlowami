import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class OpisEpokiLaptop extends StatefulWidget {
  int nrEpoki;
  OpisEpokiLaptop({super.key, required this.nrEpoki});

  @override
  State<OpisEpokiLaptop> createState() => _OpisEpokiLaptopState();
}

class _OpisEpokiLaptopState extends State<OpisEpokiLaptop> {
  late Future<List<List<dynamic>>> _futureCsv;

  @override
  void initState() {
    super.initState();
    _futureCsv = _loadCsv();
  }

  Future<List<List<dynamic>>> _loadCsv() async {
    final String csvString = await rootBundle.loadString(
      'assets/dane/daneEpoki.csv',
    );
    return const CsvToListConverter(
      fieldDelimiter: ';',
      eol: '\r\n',
      textDelimiter: '"',
    ).convert(csvString);
  }

  @override
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
          return const Scaffold(
            body: Center(child: Text('Błąd podczas wczytywania danych')),
          );
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Scaffold(body: Center(child: Text('Brak danych')));
        }

        final csvData = snapshot.data!;

        final row = csvData[widget.nrEpoki];

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: Text(
              row[0].toString(),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 2),
                        _buildExpansionTile('Ramy czasowe', row[1].toString(),width),
                        _buildExpansionTile('Kluczowe pojęcia', row[2].toString(),width),
                        _buildExpansionTile('Filozofia', row[3].toString(),width),
                        _buildExpansionTile('Sztuka', row[4].toString(),width),
                        _buildExpansionTile('Cechy literatury', row[5].toString(),width),
                        _buildExpansionTile('Typy bohaterów', row[6].toString(),width),
                        _buildExpansionTile('Motywy', row[7].toString(),width),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpansionTile(String title, String content,double width) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        iconColor: const Color.fromARGB(220, 0, 0, 0),
        title: Text(
          title,
          style:  TextStyle(fontFamily: "Inter", fontSize: 14+width*0.006),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              content,
              textAlign: TextAlign.left,
              style:  TextStyle(
                fontFamily: "Inter",
                color: Color.fromARGB(255, 30, 30, 30),
                fontSize: 12+width*0.005,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
