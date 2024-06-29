class VideoModel {
  final String type;
  final String videoId;
  final String title;
  final String channelTitle;
  final String channelId;
  final List channelThumbnail;
  final String description;
  final String viewCount;
  final String publishedTimeText;
  final String lengthText;
  final List thumbnail;
  final List? richThumbnail;

  VideoModel({
    required this.type,
    required this.videoId,
    required this.title,
    required this.channelTitle,
    required this.channelId,
    required this.channelThumbnail,
    required this.description,
    required this.viewCount,
    required this.publishedTimeText,
    required this.lengthText,
    required this.thumbnail,
    required this.richThumbnail,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      type: json['type'] ?? "",
      videoId: json['video_id'] ?? "",
      title: json['title'] ?? "",
      channelTitle: json['channel_title'] ?? "",
      channelId: json['channel_id'] ?? "",
      channelThumbnail: json['channel_thumbnail'] ?? [],
      description: json['description'],
      viewCount: json['view_count'] ?? "",
      publishedTimeText: json['published_time_text'] ?? "",
      lengthText: json['length_text'] ?? "",
      thumbnail: json['thumbnail'] ?? [],
      richThumbnail: json['rich_thumbnail'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'video_id': videoId,
      'title': title,
      'channel_title': channelTitle,
      'channel_id': channelId,
      'channel_thumbnail': channelThumbnail,
      'description': description,
      'view_count': viewCount,
      'published_time_text': publishedTimeText,
      'length_text': lengthText,
      'thumbnail': thumbnail,
      'rich_thumbnail': richThumbnail,
    };
  }
}

// class Thumbnail {
//   final String url;
//   final int width;
//   final int height;

//   Thumbnail({
//     required this.url,
//     required this.width,
//     required this.height,
//   });

//   factory Thumbnail.fromJson(Map<String, dynamic> json) {
//     return Thumbnail(
//       url: json['url'],
//       width: json['width'],
//       height: json['height'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'url': url,
//       'width': width,
//       'height': height,
//     };
//   }
// }

// enum Type { VIDEO }

// extension TypeExtension on Type {
//   String toJson() {
//     return toString().split('.').last;
//   }
// }
