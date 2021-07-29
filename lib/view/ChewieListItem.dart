import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';


// Créditos: https://github.com/ResoCoder
class ChewieListItem extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;
  final bool looping;

  ChewieController? chewieController;

  ChewieListItem({
    required this.videoPlayerController,
    required this.looping,
  });

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController

    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio:16/9,
      // Prepare the video to be played and display the first frame
      autoPlay: true,
      //autoInitialize: true,
      //allowFullScreen: false,
      looping: false,

      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            "Canal indisponível!",
            style: GoogleFonts.encodeSans(
                color: Colors.red, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    if(_chewieController!.isPlaying)
     _chewieController!.pause();
     _chewieController!.dispose();
  }
}