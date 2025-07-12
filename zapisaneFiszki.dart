import 'package:csv/csv.dart';
import 'package:flash_card/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZapisaneFiszki extends StatefulWidget {
  const ZapisaneFiszki({super.key});

  @override
  State<ZapisaneFiszki> createState() => _ZapisaneFiszkiState();
}

class _ZapisaneFiszkiState extends State<ZapisaneFiszki> {
  final List<String> nazwyPlikow = [
    "fiszkiSrodkiStylistyczne",
    "fiszkiLektury",
    "fiszkiFilozofie",
    "fiszkiEpoki",
    "fiszkiMotywy",
    "fiszkiKonteksty",
  ];

  PageController? _controller;
  int currentIndex = 0;
  List<Map<String, dynamic>> zapisaneFiszki = [];

  @override
  void initState() {
    super.initState();
    _loadZapisaneFiszki();
  }

  Future<void> _loadZapisaneFiszki() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('ulubione_fiszki') ?? [];

    List<Map<String, dynamic>> loaded = [];

    for (final id in saved) {
      final parts = id.split('_');
      if (parts.length != 2) continue;

      final int? fileIndex = int.tryParse(parts[0]);
      final int? fiszkaIndex = int.tryParse(parts[1]);
      if (fileIndex == null || fiszkaIndex == null) continue;

      final data = await _wczytajCsv(fileIndex);
      if (fiszkaIndex >= 0 && fiszkaIndex < data.length) {
        loaded.add({
          'nazwaPliku': nazwyPlikow[fileIndex],
          'front': data[fiszkaIndex][1],
          'back': data[fiszkaIndex][0],
        });
      }
    }

    setState(() {
      zapisaneFiszki = loaded;
      _controller = PageController(initialPage: 0);
    });
  }

  Future<List<List<dynamic>>> _wczytajCsv(int fileIndex) async {
    final String csvString = await rootBundle.loadString(
      'assets/dane/${nazwyPlikow[fileIndex]}.csv',
    );
    return const CsvToListConverter(
      fieldDelimiter: ';',
      eol: '\r\n',
      textDelimiter: '"',
    ).convert(csvString);
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (zapisaneFiszki.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Zapisane fiszki'),
        ),
        body: const Center(child: Text('Brak zapisanych fiszek.')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('Zapisane fiszki'),
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: zapisaneFiszki.length,
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        itemBuilder: (context, index) {
          final fiszka = zapisaneFiszki[index];
          String nazwa = fiszka['nazwaPliku'];
          nazwa =  nazwa.replaceFirst("fiszki", "");
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlashCard(
                frontWidget: () => Card(
                  shadowColor: Colors.black,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        fiszka['front'],
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 18,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(210, 0, 0, 0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                backWidget: () => Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        fiszka['back'],
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontSize: 15,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                width: 300,
                height: 400,
              ),
              const SizedBox(height: 100),
              Text(
                nazwa,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          );
        },
      ),
    );
  }
}
