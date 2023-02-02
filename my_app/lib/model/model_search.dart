class SearchModel {
  final String id;
  final String url;

  SearchModel({
    required this.id,
    required this.url,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      url: json['urls']['regular'],
    );
  }
}
