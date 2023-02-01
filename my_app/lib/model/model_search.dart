class SearchModel {
  final String id;
  final String url;
  final int uniqueId;

  SearchModel({required this.id, required this.url, required this.uniqueId});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      url: json['urls']['regular'],
      uniqueId: json['likes'],
    );
  }
}
