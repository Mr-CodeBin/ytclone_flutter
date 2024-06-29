import 'package:flutter/material.dart';
import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/screens/widgets/custom_sliver_app_bar.dart';
import 'package:youtube_clone/screens/widgets/yt_video_card.dart';
import 'package:youtube_clone/services/supabase_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            const CustomSliverAppBar(),
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: SupabaseService().getVideos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
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
            ),
          ],
        ),
      ),
    );
  }
}
