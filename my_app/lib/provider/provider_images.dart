// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:my_app/globals.dart' as globals;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/helper/db_helper.dart';
import 'package:my_app/model/model_db_helper.dart';
import 'package:my_app/model/model_search.dart';
import '../model/model_images.dart';

class ImgProvider with ChangeNotifier {
  List<ImageModel> _images = [];
  List<SearchModel> _searchImages = [];
  final List<ImageData> _favorites = [];

  int page = 1;
  int pageSearch = 1;

  final DbHelper _dbHelper = DbHelper();

  UnmodifiableListView<ImageData> get favs => UnmodifiableListView(_favorites);

  Future<List<ImageData>> fetchFavorites() async {
    DbHelper dbHelper = DbHelper();
    List<ImageData> imageDataList = await dbHelper.getAllImageData();
    return imageDataList;
  }

  Future<void> addToFavorites(ImageData imageData) async {
    removeFromFavorites(imageData);
    await _dbHelper.addImageData(imageData);
    _favorites.add(imageData);
    notifyListeners();
  }

  Future<void> removeFromFavorites(ImageData imageData) async {
    await _dbHelper.deleteImageData(imageData.imageUrl);
    _favorites.removeWhere((fav) => fav.imageUrl == imageData.imageUrl);
    notifyListeners();
  }

  Future<List<SearchModel>> searchImages(String? query, int perPage) async {
    String url =
        "${globals.urlApi}search/photos?page=$pageSearch&query=$query&per_page=$perPage&client_id=${globals.key}";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['results'] as List;
        _searchImages = data.map((item) => SearchModel.fromJson(item)).toList();
        notifyListeners();
        return _searchImages;
      } else {
        throw Exception("failed to load data");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<SearchModel>> searchMoreImages(String? query, int perPage) async {
    pageSearch++;
    String url =
        "${globals.urlApi}search/photos?page=$pageSearch&query=$query&per_page=$perPage&client_id=${globals.key}";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['results'] as List;

        _searchImages = data.map((item) => SearchModel.fromJson(item)).toList();
        if (data.isEmpty) {
          pageSearch--;
          notifyListeners();
          return searchImages(query, 30);
        } else {
          notifyListeners();
          return _searchImages;
        }
      } else {
        throw Exception("failed to load data");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<ImageModel>> fetchImages(int perPage) async {
    String url =
        '${globals.urlApi}photos?page=$page&per_page=$perPage&client_id=${globals.key}';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
        },
      );

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
        '${globals.urlApi}photos?page=$page&per_page=$perPage&client_id=${globals.key}';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
        },
      );

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
