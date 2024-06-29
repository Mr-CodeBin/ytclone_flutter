import 'package:get/get.dart';
import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/services/supabase_manager.dart';

class VideoController extends GetxController {
  final supabaseClient = SupabaseManager.supabaseClient;
  var videos = <VideoModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVideos();
  }

  void fetchVideos() async {
    // final response = await supabaseClient.from('videos').select().execute();
    // if (response.error == null) {
    //   videos.value =
    //       (response.data as List).map((e) => VideoModel.fromJson(e)).toList();
    // } else {
    //   Get.snackbar('Error', response.error.message);
    // }
    // isLoading.value = false;
  }
}
