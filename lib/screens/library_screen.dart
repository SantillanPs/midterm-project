import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).primaryColor,
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
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100), // Space for mini player
      itemCount: 20,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ListTile(
            leading: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            title: const Text('Liked Songs'),
            subtitle: const Text('Playlist • 123 songs'),
          );
        }
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              'https://picsum.photos/56?random=$index',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          title: Text('Playlist ${index}'),
          subtitle: Text(
              index % 2 == 0 ? 'Playlist • By You' : 'Playlist • By Artist'),
        );
      },
    );
  }

  Widget _buildArtistsTab() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100), // Space for mini player
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipOval(
            child: Image.network(
              'https://picsum.photos/56?random=${index + 100}',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          title: Text('Artist ${index + 1}'),
          subtitle: const Text('Artist'),
        );
      },
    );
  }

  Widget _buildAlbumsTab() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100), // Space for mini player
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              'https://picsum.photos/56?random=${index + 200}',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          title: Text('Album ${index + 1}'),
          subtitle: Text('Artist ${index + 1}'),
        );
      },
    );
  }
}
