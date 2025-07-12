import 'package:csv/csv.dart';
import 'package:flash_card/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fiszki extends StatefulWidget {
  final int nr; // numer pliku CSV z listy

  const Fiszki({required this.nr, super.key});

  @override
  State<Fiszki> createState() => _FiszkiState();
}

class _FiszkiState extends State<Fiszki> {
  final List<String> nazwyPlikow = [
    "fiszkiSrodkiStylistyczne",
    "fiszkiLektury",
    "fiszkiFilozofie",
    "fiszkiEpoki",
    "fiszkiMotywy",
    "fiszkiKonteksty",
  ];
  final List<String> nazwy = [
    "Środki Stylistyczne",
    "Lektury",
    "Filozofie",
    "Epoki",
    "Motywy",
    "Konteksty",
  ];
  PageController? _controller;
  int currentIndex = 0;
  late Future<List<List<dynamic>>> _futureCsv;
  Set<String> favoriteFlashcards = {};
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _futureCsv = wczytajCsv();
    _initIndex();
    loadFavorites();
  }

  Future<void> _initIndex() async {
    final data = await _futureCsv;
    final int? loadedIndex = await loadIntValue();
    final int safeIndex = (loadedIndex ?? 0).clamp(0, data.length - 1);

    setState(() {
      currentIndex = safeIndex;
      _controller = PageController(initialPage: safeIndex);
    });
  }

  Future<void> saveIntValue(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fiszki_index_${widget.nr}', value);
  }

  Future<int?> loadIntValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('fiszki_index_${widget.nr}');
  }

  Future<List<List<dynamic>>> wczytajCsv() async {
    final String csvString = await rootBundle.loadString(
      'assets/dane/${nazwyPlikow[widget.nr]}.csv',
    );
    List<List<dynamic>> csvTable = const CsvToListConverter(
      fieldDelimiter: ';',
      eol: '\r\n',
      textDelimiter: '"',
    ).convert(csvString);

    return csvTable;
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('ulubione_fiszki') ?? [];
    setState(() {
      favoriteFlashcards = saved.toSet();
      isFavorite = favoriteFlashcards.contains('${widget.nr}_$currentIndex');
    });
  }

  Future<void> toggleFavorite() async {
    final id = '${widget.nr}_$currentIndex';
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteFlashcards.contains(id)) {
        favoriteFlashcards.remove(id);
        isFavorite = false;
      } else {
        favoriteFlashcards.add(id);
        isFavorite = true;
      }
    });
    await prefs.setStringList('ulubione_fiszki', favoriteFlashcards.toList());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<List<dynamic>>>(
      future: _futureCsv,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || _controller == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Błąd: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Brak danych'));
        }

        final csvData = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? const Color.fromARGB(214, 244, 67, 54)
                        : const Color.fromARGB(139, 228, 72, 72),
                    size: 32,
                  ),
                  onPressed: toggleFavorite,
                ),
              ),
            ],
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: Center(child: Text(nazwy[widget.nr],style: TextStyle(fontFamily: "Inter"))),
          ),
          backgroundColor: Colors.white,
          body: PageView.builder(
            controller: _controller,
            itemCount: csvData.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
                isFavorite = favoriteFlashcards.contains('${widget.nr}_$index');
              });
              saveIntValue(index);
            },
            itemBuilder: (context, index) {
              final dane = csvData[index];
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
                            dane[1],
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
                            dane[0],
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
                ],
              );
            },
          ),
        );
      },
    );
  }
}
