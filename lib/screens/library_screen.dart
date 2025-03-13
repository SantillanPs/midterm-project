import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Your Library',
          style: TextStyle(
            color: isDarkMode
                ? Colors.white
                : const Color.fromARGB(255, 60, 60, 80),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: isDarkMode
                  ? Colors.white
                  : const Color.fromARGB(255, 60, 60, 80),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: isDarkMode
                  ? Colors.white
                  : const Color.fromARGB(255, 60, 60, 80),
            ),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color.fromARGB(255, 243, 109, 201),
          labelColor:
              isDarkMode ? Colors.white : const Color.fromARGB(255, 60, 60, 80),
          unselectedLabelColor: isDarkMode ? Colors.white70 : Colors.grey,
          tabs: const [
            Tab(text: 'Playlists'),
            Tab(text: 'Artists'),
            Tab(text: 'Albums'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPlaylistsTab(),
          _buildArtistsTab(),
          _buildAlbumsTab(),
        ],
      ),
    );
  }

  Widget _buildPlaylistsTab() {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100), // Space for mini player
      itemCount: 20,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color:
                    const Color.fromARGB(255, 243, 109, 201).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: ListTile(
              leading: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 243, 109, 201).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.favorite,
                  color: isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(255, 60, 60, 80),
                ),
              ),
              title: Text(
                'Liked Songs',
                style: TextStyle(
                  color: isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(255, 60, 60, 80),
                ),
              ),
              subtitle: Text(
                'Playlist • 123 songs',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey : Colors.grey.shade600,
                ),
              ),
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(255, 243, 109, 201).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                'https://picsum.photos/56?random=$index',
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'Playlist ${index}',
              style: TextStyle(
                color: isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(255, 60, 60, 80),
              ),
            ),
            subtitle: Text(
              index % 2 == 0 ? 'Playlist • By You' : 'Playlist • By Artist',
              style: TextStyle(
                color: isDarkMode ? Colors.grey : Colors.grey.shade600,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildArtistsTab() {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100), // Space for mini player
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(255, 243, 109, 201).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      const Color.fromARGB(255, 243, 109, 201).withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/56?random=${index + 100}',
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              'Artist ${index + 1}',
              style: TextStyle(
                color: isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(255, 60, 60, 80),
              ),
            ),
            subtitle: Text(
              'Artist',
              style: TextStyle(
                color: isDarkMode ? Colors.grey : Colors.grey.shade600,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAlbumsTab() {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100), // Space for mini player
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(255, 243, 109, 201).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                'https://picsum.photos/56?random=${index + 200}',
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              'Album ${index + 1}',
              style: TextStyle(
                color: isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(255, 60, 60, 80),
              ),
            ),
            subtitle: Text(
              'Artist ${index + 1}',
              style: TextStyle(
                color: isDarkMode ? Colors.grey : Colors.grey.shade600,
              ),
            ),
          ),
        );
      },
    );
  }
}
