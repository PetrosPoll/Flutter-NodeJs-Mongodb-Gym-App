class Exercise {
  String id;
  String name;
  String imageUrl;
  String videoUrl;

  Exercise({required this.id, required this.name, required this.imageUrl, required this.videoUrl});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
    );
  }
}
