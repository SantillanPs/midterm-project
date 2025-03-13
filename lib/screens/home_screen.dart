import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Enhanced App Bar with greeting
          // SliverAppBar(
          //   floating: true,
          //   pinned: true,
          //   expandedHeight: 150,
          //   backgroundColor: Colors.transparent,
          //   flexibleSpace: FlexibleSpaceBar(
          //     titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
          //     title: Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           _getGreeting(),
          //           style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.normal,
          //             color: isDarkMode ? Colors.white70 : Colors.black54,
          //           ),
          //         ),
          //         Text(
          //           'Music Lover',
          //           style: TextStyle(
          //             fontSize: 22,
          //             fontWeight: FontWeight.bold,
          //             color: isDarkMode
          //                 ? Colors.white
          //                 : const Color.fromARGB(255, 60, 60, 80),
          //           ),
          //         ),
          //       ],
          //     ),
          //     background: Container(
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [
          //             const Color.fromARGB(255, 243, 109, 201).withOpacity(0.4),
          //             Colors.transparent,
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          //   actions: [
          //     IconButton(
          //       icon: const Icon(Icons.notifications_outlined),
          //       onPressed: () {},
          //     ),
          //     IconButton(
          //       icon: const Icon(Icons.history),
          //       onPressed: () {},
          //     ),
          //     IconButton(
          //       icon: const Icon(Icons.settings_outlined),
          //       onPressed: () {},
          //     ),
          //   ],
          // ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 80, 16, 24),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color:
                      isDarkMode ? Colors.black.withOpacity(0.2) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color.fromARGB(255, 243, 109, 201)
                        .withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: TextField(
                  style: TextStyle(
                      color: isDarkMode
                          ? Colors.white
                          : const Color.fromARGB(255, 60, 60, 80)),
                  decoration: InputDecoration(
                    hintText: 'Search songs, artists, playlists...',
                    hintStyle: TextStyle(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.5)
                            : Colors.grey),
                    prefixIcon: Icon(Icons.search,
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.5)
                            : Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),
          ),

          // Quick Categories
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryChip(context, 'For You', isSelected: true),
                  _buildCategoryChip(context, 'Popular'),
                  _buildCategoryChip(context, 'Trending'),
                  _buildCategoryChip(context, 'New Releases'),
                  _buildCategoryChip(context, 'Moods'),
                  _buildCategoryChip(context, 'Genres'),
                ],
              ),
            ),
          ),

          // Continue Listening Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Continue Listening',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.play_circle_filled,
                      color: Color.fromARGB(255, 243, 109, 201),
                      size: 16,
                    ),
                    label: const Text(
                      'Play All',
                      style: TextStyle(
                        color: Color.fromARGB(255, 243, 109, 201),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Continue Listening Cards
          SliverToBoxAdapter(
            child: SizedBox(
              height: 190,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ContinueListeningCard(
                    title: 'Song Title ${index + 1}',
                    artist: 'Artist Name',
                    imageUrl: 'https://picsum.photos/200?random=${index + 5}',
                    progress: (index + 1) * 0.15,
                  );
                },
              ),
            ),
          ),

          // Recently Played Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recently Played',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white70 : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: isDarkMode ? Colors.white70 : Colors.grey,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Enhanced Recently Played Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return RecentlyPlayedItem(
                    title: 'Recently Played ${index + 1}',
                    subtitle: 'Artist ${index + 1}',
                    imageUrl: 'https://picsum.photos/200?random=$index',
                  );
                },
                childCount: 6,
              ),
            ),
          ),

          // Made for You Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Made for You',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white70 : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: isDarkMode ? Colors.white70 : Colors.grey,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Enhanced Album Cards
          SliverToBoxAdapter(
            child: SizedBox(
              height: 240,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return AlbumCard(
                    title: 'Daily Mix $index',
                    subtitle: 'Based on your recent listening',
                    imageUrl: 'https://picsum.photos/200?random=${index + 10}',
                    isRecommended: true,
                  );
                },
              ),
            ),
          ),

          // Popular Playlists Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Playlists',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white70 : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: isDarkMode ? Colors.white70 : Colors.grey,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Popular Playlists Cards
          SliverToBoxAdapter(
            child: SizedBox(
              height: 240,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return AlbumCard(
                    title: 'Top Hits',
                    subtitle: 'Playlist • Trending songs',
                    imageUrl: 'https://picsum.photos/200?random=${index + 20}',
                    playlistCount: '${(index + 1) * 10} songs',
                  );
                },
              ),
            ),
          ),

          // New Releases Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Releases',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white70 : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: isDarkMode ? Colors.white70 : Colors.grey,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // New Releases Cards
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return AlbumCard(
                    title: 'New Album ${index + 1}',
                    subtitle: 'Artist Name',
                    imageUrl: 'https://picsum.photos/200?random=${index + 30}',
                    isNew: true,
                  );
                },
              ),
            ),
          ),

          // Space for mini player
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label,
      {bool isSelected = false}) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? (isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(255, 60, 60, 80))
                : (isDarkMode ? Colors.white70 : Colors.grey),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        backgroundColor: isSelected
            ? const Color.fromARGB(255, 243, 109, 201)
                .withOpacity(isDarkMode ? 0.3 : 0.2)
            : (isDarkMode
                ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1)),
        side: BorderSide(
          color: isSelected
              ? const Color.fromARGB(255, 243, 109, 201)
              : (isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.3)),
          width: 1,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}

class RecentlyPlayedItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const RecentlyPlayedItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 243, 109, 201).withOpacity(0.2),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: isDarkMode
                        ? Colors.white
                        : const Color.fromARGB(255, 60, 60, 80),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.play_circle_filled,
              color: Color.fromARGB(255, 243, 109, 201),
              size: 24,
            ),
            onPressed: () {},
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.only(right: 12),
          ),
        ],
      ),
    );
  }
}

class AlbumCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isRecommended;
  final bool isNew;
  final String? playlistCount;

  const AlbumCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.isRecommended = false,
    this.isNew = false,
    this.playlistCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 243, 109, 201)
                          .withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: const Color.fromARGB(255, 243, 109, 201)
                        .withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              if (isNew)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 243, 109, 201),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'NEW',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 109, 201),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
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
            subtitle,
            style: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          if (playlistCount != null) ...[
            const SizedBox(height: 4),
            Text(
              playlistCount!,
              style: TextStyle(
                color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                fontSize: 11,
              ),
            ),
          ],
          if (isRecommended) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color: Color.fromARGB(255, 243, 109, 201),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  'Recommended for you',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class ContinueListeningCard extends StatelessWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final double progress;

  const ContinueListeningCard({
    Key? key,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 243, 109, 201)
                          .withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: const Color.fromARGB(255, 243, 109, 201)
                        .withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: (progress * 100).toInt(),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 243, 109, 201),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 100 - (progress * 100).toInt(),
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: isDarkMode
                  ? Colors.white
                  : const Color.fromARGB(255, 60, 60, 80),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            artist,
            style: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              fontSize: 11,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
