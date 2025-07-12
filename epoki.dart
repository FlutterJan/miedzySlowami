import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class OpisEpoki extends StatefulWidget {
  int nrEpoki;
  OpisEpoki({super.key, required this.nrEpoki});

  @override
  State<OpisEpoki> createState() => _OpisEpokiState();
}

class _OpisEpokiState extends State<OpisEpoki> {
  late Future<List<List<dynamic>>> _futureCsv;

  @override
  void initState() {
    super.initState();
    _futureCsv = _loadCsv();
  }

  Future<List<List<dynamic>>> _loadCsv() async {
    final String csvString = await rootBundle.loadString('assets/dane/daneEpoki.csv');
    return const CsvToListConverter(
      fieldDelimiter: ';',
      eol: '\r\n',
      textDelimiter: '"',
    ).convert(csvString);
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
          return const Scaffold(
            body: Center(child: Text('Błąd podczas wczytywania danych')),
          );
        } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('Brak danych')),
          );
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 2),
                  _buildExpansionTile('Ramy czasowe', row[1].toString()),
                  _buildExpansionTile('Kluczowe pojęcia', row[2].toString()),
                  _buildExpansionTile('Filozofia', row[3].toString()),
                  _buildExpansionTile('Sztuka', row[4].toString()),
                  _buildExpansionTile('Cechy literatury', row[5].toString()),
                  _buildExpansionTile('Typy bohaterów', row[6].toString()),
                  _buildExpansionTile('Motywy', row[7].toString()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpansionTile(String title, String content) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        iconColor: const Color.fromARGB(220, 0, 0, 0),
        title: Text(
          title,
          style: const TextStyle(fontFamily: "Inter", fontSize: 14),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              content,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: "Inter",
                color: Color.fromARGB(255, 30, 30, 30),
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
