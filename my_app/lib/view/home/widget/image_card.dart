// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String url;

  const ImageCard({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
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
                  onTap: () => {print("zoom photo")},
                  child: Image.network(url, fit: BoxFit.fill),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        print("like");
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 25,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        print("download");
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
                      onPressed: () {
                        print("share");
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
