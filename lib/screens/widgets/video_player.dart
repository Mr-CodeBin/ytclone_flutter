import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/screens/widgets/yt_video_card.dart';
import 'package:youtube_clone/services/supabase_services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final VideoModel video;

  const VideoPlayer({super.key, required this.video});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;
  bool showMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.videoId)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragStart: (details) {
            log('Vertical Drag Start--------------------------------------');
            Navigator.pop(context);

            _controller.dispose();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: widget.video.videoId,
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.red,
                      handleColor: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.video.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            Text(
                              '${widget.video.viewCount} views',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.video.publishedTimeText,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    showMore = !showMore;
                                  });
                                },
                                child: (!showMore)
                                    ? const Text(
                                        "...more",
                                        style: TextStyle(),
                                      )
                                    : const Text("...less")),
                          ],
                        ),
                      ),
                      (showMore)
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .copyWith()
                                          .splashColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      widget.video.description,
                                      maxLines: 10,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          //channel's circle avatar
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey,
                            // backgroundImage: NetworkImage(""),
                            backgroundImage: NetworkImage(
                              widget.video.channelThumbnail[0]['url']
                                  .toString(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.video.channelTitle,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),

                          //subscribe button

                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Subscribe',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Up next:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                //List of video cards
                FutureBuilder(
                  future: SupabaseService().getVideos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 150.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    List<VideoModel> videos = snapshot.requireData;

                    videos.shuffle();
                    // log('videos: $videos');
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        VideoModel video = videos[index];
                        return YtVideoCard(
                          video: video,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
