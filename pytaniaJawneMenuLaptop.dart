import 'package:flutter/material.dart';
import 'package:human_maturalny/laptop%20/pytaniaJawneLaptop.dart';

class PytaniaJawneMenuLaptop extends StatelessWidget {
  const PytaniaJawneMenuLaptop({super.key});


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



  Widget naglowek(context,tekst) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 12, right: 8, top: 3, bottom: 6),
      child: Text(
        tekst,
        style: TextStyle(
          letterSpacing: 0.45,
          fontFamily: "Inter",
          fontSize: 24+MediaQuery.of(context).size.width*0.003,
          //
          fontStyle: FontStyle.italic,
          //fontWeight: FontWeight.bold,
          color: const Color.fromARGB(220, 30, 30, 30),
        ),
      ),
    );
  }

  Widget pytanie(context,tekst,  nrPytania) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 4, vertical: 1.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        // style: ButtonStyle(
        //   padding: WidgetStatePropertyAll(EdgeInsets.zero)
        // ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 0.5),
          child: Text(
            tekst,
            style: TextStyle(
              letterSpacing: 0.3,
              fontFamily: "Inter",
              fontSize: 20+MediaQuery.of(context).size.width*0.0025,
              fontStyle: FontStyle.italic,
              //fontWeight: FontWeight.w600,
              color: const Color.fromARGB(210, 60, 60, 60),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(
                    context,
                  ).push(_createRoute(PytaniaJawneLaptop(nrPytania: nrPytania)));
                
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Center(child: Text("Pytania Jawne", style: TextStyle(fontFamily: "Inter"))),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                naglowek(context,"Biblia"),
          
                pytanie(context, "1. Motyw cierpienia niezawinionego.",1),
                pytanie(context, "2. Człowiek wobec niestałości świata.",2),
                pytanie(context, "3. Wizja końca świata.",3),
                SizedBox(height: 20),
                naglowek(context,"Mitologia, Jan Parandowski"),
                pytanie(context, "4. Oświęcenie się w imię wyższych wartości.",4),
                pytanie(context, "5. Problematyka winy i kary.",5),
                pytanie(context, "6. Miłość silniejsza niż śmierć.",6),
                pytanie(context, 
                  "7. Heroizm jako postawa człowieka w zmaganiu się z losem.",7
                ),
                SizedBox(height: 20),
                naglowek(context,"Antygona, Sofokles"),
                pytanie(context, "8. Prawa boskie a prawa ludzkie.",8),
                pytanie(context, "9. Człowiek wobec przeznaczenia.",9),
                SizedBox(height: 20),
                naglowek(context,"Lament świętokrzyski"),
                pytanie(context, "10. Motyw cierpiącej matki.",10),
                SizedBox(height: 20),
                naglowek(context,"Rozmowa Mistrza Polikarpa ze Śmiercią"),
                pytanie(context, "11. Motyw tańca śmierci.",11),
                SizedBox(height: 20),
                naglowek(context,"Pieśń o Rolandzie"),
                pytanie(context, "12. Średniowieczny wzorzec rycerza.",12),
                SizedBox(height: 20),
                naglowek(context,"Makbet, William Szekspir"),
                pytanie(context, "13. Moralna odpowiedzialność za czyny.",13),
                pytanie(context, "14. Czy człowiek decyduje o własnym losie?",14),
                pytanie(context, 
                  "15. Jaki wpływ na człowieka ma sprawowanie przez niego władzy?",15
                ),
                SizedBox(height: 20),
                naglowek(context,"Skąpiec, Molier"),
                pytanie(context, "16. Czy dobra materialne czynią człowieka szczęśliwym?",16),
                pytanie(context, "17. Przyczyny nieporozumień między rodzicami a dziećmi.",17),
          
                SizedBox(height: 20),
                naglowek(context,"Wybrana satyra, Ignacy Krasicki"),
                pytanie(context, "18. Wady ludzkie w krzywym zwierciadle satyry.",18),
                SizedBox(height: 20),
                naglowek(context,"Romantyczność oraz wybrane ballady, Adam Mickiewicz"),
                pytanie(context, "19. Świat ducha a świat rozumu.",19),
                pytanie(context, "20. Na czym polega ludowa sprawiedliwość?",20),
                SizedBox(height: 20),
                naglowek(context,"Dziady cz.III, Adam Mickiewicz"),
                pytanie(context, "21. Losy młodzieży polskiej pod zaborami.",21),
                pytanie(context, "22. Mesjanizm jako romantyczna idea poświęcenia.",22),
           pytanie(context, "23. Postawy społeczeństwa polskiego wobec zaborcy.",23),
                pytanie(context, "24. Różne postawy człowieka wobec Boga.",24),
                pytanie(context, 
                  "25. Jakie prawdy o człowieku ujawniają jego sny albo widzenia?",25
                ),
                pytanie(context, "26. W jakim celu twórca nawiązuje do motywów biblijnych?",26),
                pytanie(context, "27. Walka dobra ze złem o duszę ludzką.",27),
                pytanie(context, "28. Czym dla człowieka może być wolność?",28),
                pytanie(context, "29. Motyw samotności.",29),
                SizedBox(height: 20),
                naglowek(context,"Lalka, Bolesław Prus"),
                pytanie(context, 
                  "30. Miłość – siła destrukcyjna czy motywująca do działania?",30
                ),
                pytanie(context, "31. Praca jako pasja człowieka.",31),
                pytanie(context, 
                  "32. Jaką rolę w relacjach międzyludzkich odgrywają majątek i pochodzenie?",32
                ),
                pytanie(context, "33. Konfrontacja marzeń z rzeczywistością.",33),
                pytanie(context, "34. Miasto – przestrzeń przyjazna czy wroga człowiekowi?",34),
                pytanie(context, "35. Czym dla człowieka mogą być wspomnienia?",35),
                SizedBox(height: 20),
                naglowek(context,"Potop, Henryk Sienkiewicz"),
                pytanie(context, "36. Postawy odwagi i tchórzostwa.",36),
                SizedBox(height: 20),
                naglowek(context,"Zbrodnia i kara, Fiodor Dostojewski"),
                pytanie(context, "37. Walka człowieka ze swoimi słabościami.",37),
                pytanie(context, "38. Motyw winy i kary.",38),
                pytanie(context, "39. Ile człowiek jest gotów poświęcić dla innych?",39),
                pytanie(context, "40. Co może determinować ludzkie postępowanie?",40),
                pytanie(context, "41. Motyw przemiany bohatera.",41),
                SizedBox(height: 20),
                naglowek(context,"Wesele, Stanisław Wyspiański"),
                pytanie(context, 
                  "42. Co utrudnia porozumienie między przedstawicielami różnych grup społecznych?",42
                ),
                pytanie(context, 
                  "43. Rola chłopów i inteligencji w sprawie niepodległościowej.",43
                ),
                pytanie(context, "44. Sen o Polsce czy sąd nad Polską?",44),
                pytanie(context, "45. Symboliczne znaczenie widm i zjaw.",45),
                pytanie(context, "46. Motyw tańca.",46),
                SizedBox(height: 20),
                naglowek(context,"Chłopi, Władysław Reymont"),
                pytanie(context, "47. Obyczaj i tradycja w życiu społeczeństwa.",47),
                SizedBox(height: 20),
                naglowek(context,"Przedwiośnie, Stefan Żeromski"),
                pytanie(context, 
                  "48. Jakie znaczenie ma tytuł dla odczytania sensu utworu?",48
                ),
                pytanie(context, "49. Wojna i rewolucja jako źródła doświadczeń człowieka.",49),
                pytanie(context, 
                  "50. Różne wizje odbudowy Polski po odzyskaniu niepodległości.",
                50),
                pytanie(context, "51. Młodość jako czas kształtowania własnej tożsamości.",51),
                pytanie(context, "52. Rola autorytetu w życiu człowieka.",52),
                pytanie(context, "53. Utopijny i realny obraz rzeczywistości.",53),
                SizedBox(height: 20),
                naglowek(context,"Ferdydurke, Witold Gombrowicz"),
                pytanie(context, "54. Groteskowy obraz świata.",54),
                pytanie(context, "55. Człowiek wobec presji otoczenia.",55),
                SizedBox(height: 20),
                naglowek(context,"Proszę państwa do gazu, Tadeusz Borowski"),
                pytanie(context, 
                  "57. Jakie znaczenie ma tytuł dla odczytania sensu utworu?",56
                ),
                SizedBox(height: 20),
                naglowek(context,"Inny świat, Gustaw Herling-Grudziński"),
                pytanie(context, 
                  "57. Jakie znaczenie ma tytuł dla odczytania sensu utworu?",57
                ),
                pytanie(context, "58. Konsekwencje zniewolenia człowieka.",58),
                SizedBox(height: 20),
                naglowek(context,"Zdążyć przed Panem Bogiem, Hanna Krall"),
                pytanie(context, 
                  "59. Czy możliwe jest zachowanie godności w skrajnych sytuacjach?",59
                ),
                pytanie(context, 
                  "60. Zagłada z perspektywy świadka i uczestnika wydarzeń w getcie.",60
                ),
                pytanie(context, "61. Walka o życie z perspektywy wojennej i powojennej.",61),
                SizedBox(height: 20),
                naglowek(context,"Dżuma, Albret Camus"),
                pytanie(context, "62. Co skłania człowieka do poświęceń?",62),
                pytanie(context, "63. Człowiek wobec cierpienia i śmierci.",63),
                pytanie(context, "64. Czy możliwa jest przyjaźń w sytuacjach skrajnych?",64),
                pytanie(context, "65. Jakie postawy przyjmuje człowiek wobec zła?",65),
          
                SizedBox(height: 20),
                naglowek(context,"Rok 1984, George Orwell"),
                pytanie(context, "66. Czy możliwe jest zbudowanie doskonałego państwa?",66),
                pytanie(context, "67. Jak zachować wolność w państwie totalitarnym?",67),
                pytanie(context, "68. Znaczenie propagandy w państwie totalitarnym.",68),
                pytanie(context, 
                  "69. Nowomowa jako sposób na ograniczenie wolności człowieka.",
                69),
                SizedBox(height: 20),
                naglowek(context,"Tango, Sławomir Mrożek"),
                pytanie(context, "70. Bunt przeciwko porządkowi społecznemu.",70),
                pytanie(context, "71. Konflikt pokoleń.",71),
                pytanie(context, 
                  "72. Normy społeczne – ograniczają człowieka czy porządkują życie?",72
                ),
                SizedBox(height: 20),
                naglowek(context,"Górą Edek, Marek Nowakowski"),
                pytanie(context, 
                  "73. W jakim celu autor nawiązuje w swoim tekście do innego utworu literackiego?",73
                ),
                SizedBox(height: 20),
                naglowek(context,"Miejsce, Andrzej Stasiuk"),
                pytanie(context, "74. Miejsca ważne w życiu człowieka.",74),
                SizedBox(height: 20),
                naglowek(context,"Profesor Andrews w Warszawie, Olga Tokarczuk"),
                pytanie(context, "75. Stan wojenny z perspektywy obcokrajowca.",75),
                SizedBox(height: 20),
                naglowek(context,"Podróże z Herodotem, Ryszard Kapuściński,"),
                pytanie(context, "76. Czym dla człowieka może być podróżowanie?",76),
          
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
