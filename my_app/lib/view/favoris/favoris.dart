// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:my_app/model/model_db_helper.dart';
import 'package:my_app/provider/provider_images.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class FavorisList extends StatefulWidget {
  const FavorisList({super.key});

  @override
  _FavorisListState createState() => _FavorisListState();
}

class _FavorisListState extends State<FavorisList> {
  late Future<List<ImageData>> _favorites;
  bool isDownloading = false;

  static const snackBar = SnackBar(
    content: Text('Successful download.'),
  );

  static const snackBarError = SnackBar(
    content: Text('Download failed.'),
  );

  void shareImage(String url) async {
    await Share.share(
      url,
    );
  }

  Future<void> _downloadImage(String url) async {
    setState(() {
      isDownloading = true;
    });
    Dio dio = Dio();
    try {
      Response response = await dio.get(url,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
      );
      setState(() {
        isDownloading = false;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } catch (e) {
      setState(() {
        isDownloading = false;
        ScaffoldMessenger.of(context).showSnackBar(snackBarError);
      });
    }
  }

  Future<void> deleteFav(String url) async {
    var rng = Random();
    int id = rng.nextInt(100000000);
    Provider.of<ImgProvider>(context, listen: false).removeFromFavorites(
      ImageData(id: id, imageUrl: url),
    );
  }

  @override
  void initState() {
    super.initState();
    _favorites =
        Provider.of<ImgProvider>(context, listen: false).fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FutureBuilder<List<ImageData>>(
        future: _favorites,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                ImageData imageData = snapshot.data![i];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shadowColor: Colors.grey,
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0), width: 0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: InkWell(
                              onTap: () async {
                                Object arguments = {"url": imageData.imageUrl};
                                String query = '/fullScreen';
                                Navigator.pushNamed(context, query,
                                    arguments: arguments);
                              },
                              child: Image.network(imageData.imageUrl,
                                  fit: BoxFit.fill),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  deleteFav(imageData.imageUrl);
                                  setState(() {
                                    _favorites = Provider.of<ImgProvider>(
                                            context,
                                            listen: false)
                                        .fetchFavorites();
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () async {
                                    _downloadImage(imageData.imageUrl);
                                  },
                                  icon: const Icon(
                                    Icons.download,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () async {
                                    shareImage(imageData.imageUrl);
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An error occured: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
