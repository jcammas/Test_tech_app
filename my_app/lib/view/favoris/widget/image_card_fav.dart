// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app/helper/db_helper.dart';
import 'package:my_app/provider/provider_images.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageCardFav extends StatefulWidget {
  final String url;
  final String id;

  const ImageCardFav({super.key, required this.url, required this.id});

  static const String routeName = "/favoris";

  @override
  State<ImageCardFav> createState() => _ImageCardFavState();
}

class _ImageCardFavState extends State<ImageCardFav> {
  bool isDownloading = false;
  bool isFav = false;

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.grey,
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: InkWell(
                  onTap: () async {
                    Object arguments = {"url": widget.url};
                    String query = '/fullScreen';
                    Navigator.pushNamed(context, query, arguments: arguments);
                  },
                  child: Image.network(widget.url, fit: BoxFit.fill),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      var rng = Random();
                      int id = rng.nextInt(100000000);
                      Provider.of<ImgProvider>(context, listen: false)
                          .removeFromFavorites(
                        ImageData(id: id, imageUrl: widget.url),
                      );
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
                        _downloadImage(widget.url);
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
                        shareImage(widget.url);
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
  }
}




// IconButton(
//                           onPressed: () {
//                             var rng = Random();
//                             int id = rng.nextInt(100000000);
//                             Provider.of<ImgProvider>(context, listen: false)
//                                 .removeFromFavorites(
//                                     ImageData(id: id, imageUrl: widget.url));

//                             setState(() {
//                               isFav = !isFav;
//                             });
//                           },
//                           icon: const Icon(
//                             Icons.remove,
//                             size: 25,
//                             color: Colors.grey,
//                           ),
//                         ),