import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/controllers/auth_controller.dart';
import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/services/supabase_manager.dart';

class SupabaseService {
  final client = SupabaseManager.supabaseClient;

  Future<List<VideoModel>> getVideos() async {
    final response = await client.from('videos_yttttt').select('*');

    if (response.isEmpty == true) {
      return Future.error(response[0]);
    }

    // log('response: $response');
    List<VideoModel> videos = List<VideoModel>.from(
        response.map((video) => VideoModel.fromJson(video)));

    // log('videos: $videos');
    return videos;
  }

  //fetch lib/screens/widgets/data.json 's data to supabase
  Future<void> insertData() async {
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final Map<String, dynamic> jsonData = json.decode(response);
    // log('jsonData: $jsonData');

    for (final datum in jsonData['data']) {
      final dataResponse = await client.from('videos_yttttt').insert({
        'type': datum['type'],
        'video_id': datum['videoId'],
        'title': datum['title'],
        'channel_title': datum['channelTitle'],
        'channel_id': datum['channelId'],
        'description': datum['description'],
        'view_count': datum['viewCount'],
        'published_time_text': datum['publishedTimeText'],
        'length_text': datum['lengthText'],
        'rich_thumbnail': datum['richThumbnail'],
        'thumbnail': datum['thumbnail'],
        'channel_thumbnail': datum['channelThumbnail'],
      });
      // log('dataResponse: $dataResponse');

      if (dataResponse == null) {
        log('Error: dataResponse is null ');
        continue;
      }

      if (dataResponse.error != null) {
        log('Error inserting into videos :  ${dataResponse.error!.message}');
        continue;
      }
    }
    log('Data inserted successfully');
  }

  Future<void> signOut() async {
    await client.auth.signOut();
    //update the login state
    AuthController().isLogged.value = false;
    //clear the login state
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);

    Get.offAllNamed('/login');
  }
}
