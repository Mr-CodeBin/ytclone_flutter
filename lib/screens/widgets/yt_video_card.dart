import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/screens/widgets/video_player.dart';
import 'package:youtube_clone/services/supabase_services.dart';

class YtVideoCard extends StatefulWidget {
  final VideoModel video;

  const YtVideoCard({super.key, required this.video});

  @override
  State<YtVideoCard> createState() => _YtVideoCardState();
}

class _YtVideoCardState extends State<YtVideoCard> {
  SupabaseService supabaseService = SupabaseService();

  void getVid() async {
    await supabaseService.getVideos();
  }

  @override
  void initState() {
    super.initState();
    getVid();
  }

  @override
  Widget build(BuildContext context) {
    log('https://www.youtube.com/watch?v=${widget.video.videoId}');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayer(
              video: widget.video,
            ),
          ),
        );
      },
      child: Hero(
        tag: widget.video.videoId,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  color: Colors.grey,
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    widget.video.thumbnail[2]['url'],
                    fit: BoxFit.cover,
                  )),
              const SizedBox(height: 8),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      // backgroundImage: NetworkImage(""),
                      backgroundImage: NetworkImage(
                        widget.video.channelThumbnail[0]['url'].toString(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            widget.video.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            // "",
                            // '${widget.video.channelTitle.toString()} ',
                            '${widget.video.channelTitle.toString()} ° ${widget.video.viewCount.toString()} views ° ${widget.video.publishedTimeText.toString()}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
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
