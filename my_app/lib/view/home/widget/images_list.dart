// ignore_for_file: unused_local_variable, unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:my_app/model/model_images.dart';
import 'package:my_app/view/home/widget/image_card.dart';
import 'package:provider/provider.dart';
import 'package:my_app/provider/provider_images.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  late Future<List<ImageModel>> _future;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _future = Provider.of<ImgProvider>(context, listen: false).fetchImages(30);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: _future,
      builder:
          (BuildContext context, AsyncSnapshot<List<ImageModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      scrollNotification.metrics.pixels ==
                          scrollNotification.metrics.maxScrollExtent) {
                    setState(() {
                      _future = Provider.of<ImgProvider>(context, listen: false)
                          .fetchMoreImages(30);
                    });
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, i) {
                    return ImageCard(
                      url: snapshot.data![i].url,
                    );
                  },
                ));
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to load images'),
            );
          } else {
            return const Center(
              child: Text('No data'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
