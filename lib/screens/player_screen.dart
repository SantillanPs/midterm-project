import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPlaying = true;
  double _currentSliderValue = 40;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: isDarkMode
                ? Colors.white
                : const Color.fromARGB(255, 60, 60, 80),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          children: [
            Text(
              'PLAYING FROM PLAYLIST',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: isDarkMode ? Colors.grey : Colors.grey.shade600,
              ),
            ),
            Text(
              'Your Favorites',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(255, 60, 60, 80),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDarkMode
                  ? Colors.white
                  : const Color.fromARGB(255, 60, 60, 80),
            ),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    const Color.fromARGB(255, 37, 38, 66),
                    const Color.fromARGB(255, 24, 22, 47),
                  ]
                : [
                    const Color.fromARGB(255, 245, 245, 250),
                    const Color.fromARGB(255, 235, 235, 245),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, child) {
                        return Transform.rotate(
                          angle: _controller.value * 2 * 3.14159,
                          child: child,
                        );
                      },
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 243, 109, 201)
                                  .withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                          border: Border.all(
                            color: const Color.fromARGB(255, 243, 109, 201)
                                .withOpacity(0.5),
                            width: 2,
                          ),
                          image: const DecorationImage(
                            image: NetworkImage('https://picsum.photos/500'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Song Title',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
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
                                  fontSize: 16,
                                  color: isDarkMode
                                      ? Colors.grey
                                      : Colors.grey.shade600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite,
                              color: Color.fromARGB(255, 243, 109, 201)),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 14,
                            ),
                            activeTrackColor:
                                const Color.fromARGB(255, 243, 109, 201),
                            inactiveTrackColor: isDarkMode
                                ? Colors.grey[800]
                                : Colors.grey[300],
                            thumbColor: Colors.white,
                            overlayColor:
                                const Color.fromARGB(255, 243, 109, 201)
                                    .withOpacity(0.2),
                          ),
                          child: Slider(
                            value: _currentSliderValue,
                            min: 0,
                            max: 100,
                            onChanged: (value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '1:40',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode
                                    ? Colors.grey
                                    : Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              '4:10',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode
                                    ? Colors.grey
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shuffle,
                              color: Color.fromARGB(255, 243, 109, 201)),
                          iconSize: 24,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.skip_previous,
                            color: isDarkMode
                                ? Colors.white
                                : const Color.fromARGB(255, 60, 60, 80),
                          ),
                          iconSize: 36,
                          onPressed: () {},
                        ),
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 243, 109, 201),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 243, 109, 201)
                                    .withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            iconSize: 36,
                            onPressed: () {
                              setState(() {
                                _isPlaying = !_isPlaying;
                                if (_isPlaying) {
                                  _controller.repeat();
                                } else {
                                  _controller.stop();
                                }
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.skip_next,
                            color: isDarkMode
                                ? Colors.white
                                : const Color.fromARGB(255, 60, 60, 80),
                          ),
                          iconSize: 36,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.repeat,
                            color: isDarkMode
                                ? Colors.white
                                : const Color.fromARGB(255, 60, 60, 80),
                          ),
                          iconSize: 24,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.devices,
                            color: isDarkMode
                                ? Colors.white
                                : const Color.fromARGB(255, 60, 60, 80),
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: isDarkMode
                                ? Colors.white
                                : const Color.fromARGB(255, 60, 60, 80),
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.playlist_play,
                            color: isDarkMode
                                ? Colors.white
                                : const Color.fromARGB(255, 60, 60, 80),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
