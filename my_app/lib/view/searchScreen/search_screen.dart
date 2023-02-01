import 'package:flutter/material.dart';
import 'package:my_app/model/model_search.dart';
import 'package:my_app/provider/provider_images.dart';
import 'package:my_app/view/components/app_bar.dart';
import 'package:my_app/view/home/widget/image_card.dart';
import 'package:provider/provider.dart';

class SearchScreenResults extends StatefulWidget {
  final String? query;
  const SearchScreenResults({super.key, this.query});

  static const String routeName = "/searchScreenResults";

  @override
  State<SearchScreenResults> createState() => _SearchScreenResultsState();
}

class _SearchScreenResultsState extends State<SearchScreenResults> {
  late Future<List<SearchModel>> _future;
  @override
  void initState() {
    super.initState();
    _future = Provider.of<ImgProvider>(context, listen: false)
        .searchImages(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.grey, Colors.grey])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
            title: const MyAppBar()),
        body: FutureBuilder(
          future: _future,
          builder: (context, AsyncSnapshot<List<SearchModel>> snapshot) {
            if (snapshot.hasData) {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      scrollNotification.metrics.pixels ==
                          scrollNotification.metrics.maxScrollExtent) {
                    setState(() {
                      _future = Provider.of<ImgProvider>(context, listen: false)
                          .searchMoreImages(widget.query);
                    });
                  }
                  return false;
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ImageCard(
                      url: snapshot.data![index].url,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to load images'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
