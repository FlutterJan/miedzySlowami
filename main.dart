import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:human_maturalny/laptop%20/lekturyLaptop.dart';
import 'package:human_maturalny/laptop%20/menuEpokiLaptop.dart';
import 'package:human_maturalny/laptop%20/menuFiszkiLaptop.dart';
import 'package:human_maturalny/laptop%20/menuMotywyLaptop.dart';
import 'package:human_maturalny/laptop%20/pytaniaJawneMenuLaptop.dart';
import 'package:human_maturalny/lektury.dart';
import 'package:human_maturalny/menuEpoki.dart';
import 'package:human_maturalny/menuFiszki.dart';
import 'package:human_maturalny/menuMotywy.dart';
import 'package:human_maturalny/menuPytaniaJawne.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const Menu());
}

class AppUsage {
  static const _keyFirstLaunch = 'first_launch';
  static const _keyLaunchCount = 'launch_count';
  static const _keyInstallTimestamp = 'install_timestamp';

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final firstLaunch = prefs.getBool(_keyFirstLaunch) ?? true;

    if (firstLaunch) {
      await prefs.setBool(_keyFirstLaunch, false);
      await prefs.setInt(_keyLaunchCount, 1);
      await prefs.setInt(_keyInstallTimestamp, DateTime.now().millisecondsSinceEpoch);
    } else {
      final launchCount = prefs.getInt(_keyLaunchCount) ?? 0;
      await prefs.setInt(_keyLaunchCount, launchCount + 1);
    }
  }

  Future<int> getLaunchCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyLaunchCount) ?? 0;
  }

  Future<int> getInstallTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyInstallTimestamp) ?? 0;
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  var _selectedTab = _SelectedTab.lektury;
  int x = 0;
  final AppUsage _appUsage = AppUsage();

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      x = i;
    });
  }

  @override
  void initState() {
    super.initState();
    _appUsage.initialize().then((_) {
      _checkForReview();
    });
  }

  Future<void> _checkForReview() async {
    final launchCount = await _appUsage.getLaunchCount();
    final installTimestamp = await _appUsage.getInstallTimestamp();
    final installDate = DateTime.fromMillisecondsSinceEpoch(installTimestamp);
    final now = DateTime.now();
    final daysSinceInstall = now.difference(installDate).inDays;

    if (launchCount >= 5 && daysSinceInstall >= 3) {
      final inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> ekranyTelefon = [
      Lektury(),
      Menufiszki(),
      MenuEpoki(),
      PytaniaJawneMenu(),
      MenuMotywy(),
    ];
    List<Widget> ekranyLaptop = [
      LekturyLaptop(),
      MenuFiszkiLaptop(),
      MenuEpokiLaptop(),
      PytaniaJawneMenuLaptop(),
      MenuMotywyLaptop(),
    ];
    var ekrany = width > height ? ekranyLaptop : ekranyTelefon;
    var bottomNavigationBar = width > height
        ? Positioned(
            left: 10 + 0.3 * width,
            right: 10 + 0.3 * width,
            bottom: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: DotNavigationBar(
                backgroundColor: const Color.fromARGB(245, 255, 255, 255),
                margin: EdgeInsets.symmetric(horizontal: 5),
                currentIndex: _SelectedTab.values.indexOf(_selectedTab),
                dotIndicatorColor: const Color.fromARGB(100, 255, 0, 0),
                unselectedItemColor: const Color.fromARGB(255, 195, 195, 195),
                splashBorderRadius: 50,
                selectedItemColor: const Color.fromARGB(80, 255, 0, 0),
                enableFloatingNavBar: false,
                onTap: _handleIndexChanged,
                items: [
                  DotNavigationBarItem(icon: Icon(Icons.menu_book)),
                  DotNavigationBarItem(icon: Icon(Icons.style)),
                  DotNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.landmark, size: 20),
                  ),
                  DotNavigationBarItem(icon: Icon(FontAwesomeIcons.listOl, size: 20)),
                  DotNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.feather, size: 20),
                  ),
                ],
              ),
            ),
          )
        : Positioned(
            left: 10 + 0.05 * width,
            right: 10 + 0.05 * width,
            bottom: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: DotNavigationBar(
                backgroundColor: const Color.fromARGB(245, 255, 255, 255),
                margin: EdgeInsets.symmetric(horizontal: 5),
                currentIndex: _SelectedTab.values.indexOf(_selectedTab),
                dotIndicatorColor: const Color.fromARGB(100, 255, 0, 0),
                unselectedItemColor: const Color.fromARGB(255, 195, 195, 195),
                splashBorderRadius: 50,
                selectedItemColor: const Color.fromARGB(80, 255, 0, 0),
                enableFloatingNavBar: false,
                onTap: _handleIndexChanged,
                items: [
                  DotNavigationBarItem(icon: Icon(Icons.menu_book)),
                  DotNavigationBarItem(icon: Icon(Icons.style)),
                  DotNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.landmark, size: 20),
                  ),
                  DotNavigationBarItem(icon: Icon(FontAwesomeIcons.listOl, size: 20)),
                  DotNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.feather, size: 20),
                  ),
                ],
              ),
            ),
          );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [ekrany[x], bottomNavigationBar]),
      ),
    );
  }
}

enum _SelectedTab { lektury, fiszki, epoki, szukaj, menu }
