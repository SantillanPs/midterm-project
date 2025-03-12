import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 120,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Good afternoon',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromARGB(255, 243, 109, 201).withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.history),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return RecentlyPlayedItem(
                    title: 'Recently Played ${index + 1}',
                    imageUrl: 'https://picsum.photos/200?random=$index',
                  );
                },
                childCount: 6,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Text(
                'Made for you',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return AlbumCard(
                    title: 'Daily Mix $index',
                    subtitle: 'Based on your recent listening',
                    imageUrl: 'https://picsum.photos/200?random=${index + 10}',
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
              child: Text(
                'Popular playlists',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return AlbumCard(
                    title: 'Top Hits',
                    subtitle: 'Playlist • Trending songs',
                    imageUrl: 'https://picsum.photos/200?random=${index + 20}',
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
              child: Text(
                'New releases',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return AlbumCard(
                    title: 'New Album ${index + 1}',
                    subtitle: 'Artist Name',
                    imageUrl: 'https://picsum.photos/200?random=${index + 30}',
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 100), // Space for mini player
          ),
        ],
      ),
    );
  }
}

class RecentlyPlayedItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const RecentlyPlayedItem({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
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
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
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

  const AlbumCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 243, 109, 201).withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color:
                    const Color.fromARGB(255, 243, 109, 201).withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
