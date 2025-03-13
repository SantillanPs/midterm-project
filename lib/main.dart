import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/library_screen.dart';
import 'screens/player_screen.dart';
import 'screens/login_screen.dart';
import 'providers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MusicApp(),
    ),
  );
}

class MusicApp extends StatelessWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JukeVibe',
      theme: themeProvider.themeData,
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "JukeVibe",
          style: TextStyle(
              color: isDarkMode
                  ? Colors.white
                  : const Color.fromARGB(255, 60, 60, 80),
              fontWeight: FontWeight.bold,
              fontSize: 27,
              shadows: [
                Shadow(
                  color:
                      const Color.fromARGB(255, 243, 109, 201).withAlpha(178),
                  blurRadius: 15,
                ),
                Shadow(
                  color:
                      const Color.fromARGB(255, 243, 109, 201).withAlpha(128),
                  blurRadius: 25,
                ),
              ]),
        ),
        shape: Border(
            bottom: BorderSide(
                color:
                    const Color.fromARGB(255, 243, 109, 201).withAlpha(178))),
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode
                  ? Colors.white
                  : const Color.fromARGB(255, 60, 60, 80),
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [
                        const Color.fromARGB(255, 37, 38, 66),
                        const Color.fromARGB(255, 24, 22, 47),
                      ]
                    : [
                        const Color.fromARGB(255, 245, 245, 250),
                        const Color.fromARGB(255, 235, 235, 245),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
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
          color: isDarkMode
              ? Colors.black.withOpacity(0.3)
              : Colors.white.withOpacity(0.9),
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
          unselectedItemColor: isDarkMode ? Colors.grey : Colors.grey.shade600,
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
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.white,
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
                children: [
                  Text(
                    'Song Title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isDarkMode
                          ? Colors.white
                          : const Color.fromARGB(255, 60, 60, 80),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Artist Name',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey : Colors.grey.shade600,
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
            icon: Icon(
              Icons.skip_previous,
              color: isDarkMode
                  ? Colors.white
                  : const Color.fromARGB(255, 60, 60, 80),
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
            icon: Icon(
              Icons.skip_next,
              color: isDarkMode
                  ? Colors.white
                  : const Color.fromARGB(255, 60, 60, 80),
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
