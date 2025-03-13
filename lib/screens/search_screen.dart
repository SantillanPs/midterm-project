import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            title: _isSearching
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: TextStyle(
                        color: isDarkMode
                            ? Colors.white
                            : const Color.fromARGB(255, 60, 60, 80)),
                    decoration: InputDecoration(
                      hintText: 'Search for songs, artists...',
                      hintStyle: TextStyle(
                          color:
                              isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear,
                            color: isDarkMode
                                ? Colors.white
                                : const Color.fromARGB(255, 60, 60, 80)),
                        onPressed: () {
                          _searchController.clear();
                        },
                      ),
                    ),
                  )
                : Text(
                    'Search',
                    style: TextStyle(
                      color: isDarkMode
                          ? Colors.white
                          : const Color.fromARGB(255, 60, 60, 80),
                    ),
                  ),
            actions: [
              if (!_isSearching)
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: isDarkMode
                        ? Colors.white
                        : const Color.fromARGB(255, 60, 60, 80),
                  ),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                ),
              if (_isSearching)
                IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: isDarkMode
                        ? Colors.white
                        : const Color.fromARGB(255, 60, 60, 80),
                  ),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                    });
                  },
                ),
            ],
          ),
          if (!_isSearching) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your top genres',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.0,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final genres = [
                      'Pop',
                      'Rock',
                      'Hip-Hop',
                      'Electronic',
                      'R&B',
                      'Jazz'
                    ];
                    final colors = [
                      const Color.fromARGB(255, 243, 109, 201),
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.purple,
                      Colors.teal
                    ];
                    return GenreCard(
                      title: genres[index % genres.length],
                      color: colors[index % colors.length],
                    );
                  },
                  childCount: 6,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Browse all',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.0,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final categories = [
                      'Podcasts',
                      'New Releases',
                      'Charts',
                      'Concerts',
                      'Made for You',
                      'At Home',
                      'Workout',
                      'Chill',
                      'Mood',
                      'Party',
                    ];
                    final colors = [
                      Colors.red,
                      Colors.indigo,
                      Colors.amber,
                      Colors.cyan,
                      Colors.deepOrange,
                      Colors.lightGreen,
                      Colors.deepPurple,
                      Colors.lightBlue,
                      Colors.brown,
                      const Color.fromARGB(255, 243, 109, 201),
                    ];
                    return GenreCard(
                      title: categories[index % categories.length],
                      color: colors[index % colors.length],
                    );
                  },
                  childCount: 10,
                ),
              ),
            ),
          ] else ...[
            // Search results
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color.fromARGB(255, 243, 109, 201)
                            .withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          'https://picsum.photos/50?random=$index',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        'Search Result ${index + 1}',
                        style: TextStyle(
                          color: isDarkMode
                              ? Colors.white
                              : const Color.fromARGB(255, 60, 60, 80),
                        ),
                      ),
                      subtitle: Text(
                        index % 2 == 0 ? 'Song' : 'Artist',
                        style: TextStyle(
                          color:
                              isDarkMode ? Colors.grey : Colors.grey.shade600,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: isDarkMode
                              ? Colors.white
                              : const Color.fromARGB(255, 60, 60, 80),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
          const SliverToBoxAdapter(
            child: SizedBox(height: 100), // Space for mini player
          ),
        ],
      ),
    );
  }
}

class GenreCard extends StatelessWidget {
  final String title;
  final Color color;

  const GenreCard({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(isDarkMode ? 0.2 : 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Diagonal pattern for visual interest
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              transform: Matrix4.rotationZ(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                color: isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(255, 60, 60, 80),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
