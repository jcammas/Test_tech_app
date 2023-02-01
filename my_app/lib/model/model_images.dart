class ImageModel {
  final String id;
  final String url;
  final int uniqueId;

  ImageModel({required this.id, required this.url, required this.uniqueId});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['urls']['regular'],
      uniqueId: json['likes'],
    );
  }
}
