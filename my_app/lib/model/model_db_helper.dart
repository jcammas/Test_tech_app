class ImageData {
  late int? id;
  late String imageUrl;

  ImageData({
    this.id,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
    };
    return map;
  }

  ImageData.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    imageUrl = map['imageUrl'];
  }
}
