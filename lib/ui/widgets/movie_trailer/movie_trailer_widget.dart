import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerWidget extends StatefulWidget {
  final String youtubeKey;
  const MovieTrailerWidget({super.key, required this.youtubeKey});

  @override
  State<MovieTrailerWidget> createState() => _MovieTrailerWidgetState();
}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
        initialVideoId: widget.youtubeKey,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: const ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
      onReady: () => _controller.addListener(() {}),
    );
    return YoutubePlayerBuilder(
      player: player,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Трейлер'),
          ),
          body: Center(child: player),
        );
      },
    );
  }
}
