// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../model/model_images.dart';

class ImgProvider with ChangeNotifier {
  List<ImageModel> _images = [];
  int page = 1;
  List<ImageModel> get images => _images;

  Future<List<ImageModel>> fetchImages(int perPage) async {
    String url =
        'https://api.unsplash.com/photos?page=$page&per_page=$perPage&client_id=ZCtlipEM8ix3jzwSone0mtvsPeENgZy7CSluV1J7d7Y';
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _images = data.map((e) => ImageModel.fromJson(e)).toList();
        notifyListeners();
        return _images;
      } else {
        throw Exception("failed to load data");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<ImageModel>> fetchMoreImages(int perPage) async {
    page++;
    String url =
        'https://api.unsplash.com/photos?page=$page&per_page=$perPage&client_id=ZCtlipEM8ix3jzwSone0mtvsPeENgZy7CSluV1J7d7Y';
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _images = data.map((e) => ImageModel.fromJson(e)).toList();
        notifyListeners();
        return _images;
      } else {
        throw Exception("failed to load data");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
