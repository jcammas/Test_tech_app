import 'package:flutter/material.dart';
import 'package:my_app/provider/provider_images.dart';
import 'package:my_app/view/home/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImgProvider imageProvider = ImgProvider();

    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: imageProvider)],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Home(),
      ),
    );
  }
}
