import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stok_takip/providers/stok_save_provider.dart';
import 'package:stok_takip/providers/stok_summary_provider.dart';
import 'package:stok_takip/services/service_locator.dart';
import 'views/summary_screen.dart';
import 'views/save_screen.dart';


void main() {
  setupLocator();
   runApp(
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => StokProvider()),
    ChangeNotifierProvider(create: (_) => StokSummaryProvider()),
  ],
  child: const MyApp(),
)

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stok Takip',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const StokHomePage(),
    );
  }
}

class StokHomePage extends StatefulWidget {
  const StokHomePage({super.key});

  @override
  State<StokHomePage> createState() => _StokHomePageState();
}

class _StokHomePageState extends State<StokHomePage> {
  final PageController _pageController = PageController(
    initialPage: 0
  );
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Stok Kayıt' : 'Stok Özet'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: PageView(
        
        controller: _pageController,
       
        children: const [
          SavePage(),
          SummaryPage(),
        ],
         onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: NavigationBar(
        
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.save),
            label: 'Kayıt',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Özet',
          ),
        ],
      ),
    );
  }
}