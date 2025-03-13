import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/library_screen.dart';
import 'screens/player_screen.dart';
import 'screens/login_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JukeVibe',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 243, 109, 201),
        scaffoldBackgroundColor: const Color.fromARGB(255, 24, 22, 47),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isPlayerVisible = false;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const LibraryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "JukeVibe",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 27,
              shadows: [
                Shadow(
                  color: Color.fromARGB(255, 243, 109, 201).withAlpha(178),
                  blurRadius: 15,
                ),
                Shadow(
                  color: Color.fromARGB(255, 243, 109, 201).withAlpha(128),
                  blurRadius: 25,
                ),
              ]),
        ),
        shape: Border(
            bottom: BorderSide(
                color: Color.fromARGB(255, 243, 109, 201).withAlpha(178))),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color.fromARGB(255, 37, 38, 66),
                const Color.fromARGB(255, 24, 22, 47),
              ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
            ),
          ),

          // Main content
          _screens[_selectedIndex],

          // Mini player at bottom
          if (_isPlayerVisible)
            Positioned(
              left: 0,
              right: 0,
              bottom: 10, // Above bottom navigation
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlayerScreen(),
                    ),
                  );
                },
                child: const MiniPlayer(),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          border: Border(
            top: BorderSide(
              color: const Color.fromARGB(255, 243, 109, 201).withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color.fromARGB(255, 243, 109, 201),
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _isPlayerVisible = true; // Show player after navigation
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Library',
            ),
          ],
        ),
      ),
    );
  }
}

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 243, 109, 201).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 243, 109, 201).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Album art
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.network(
              'https://picsum.photos/200',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          // Song info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Song Title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Artist Name',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          // Controls
          IconButton(
            icon: const Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {},
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 243, 109, 201),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
