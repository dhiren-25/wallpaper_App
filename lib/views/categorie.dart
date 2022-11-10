import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';
import '../model/wallpaper_model.dart';
import '../widgets/widget.dart';


class Categorie extends StatefulWidget {
  final String categorieName;
  Categorie({required this.categorieName});


  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {

  List<WallpaperModel> wallpapers = [];

  getSearchWallpapers(String query) async {
    var response =  await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=45&page=1"),
        headers: {"Authorization" : apiKey});
    // print(response.body.toString());
    Map<String,dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      // forEach is a loop function
      //   print(element);
      WallpaperModel wallpaperModel  = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState((){});
  }

  @override
  void initState() {
   getSearchWallpapers(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
              height:16,
            ),
              wallpaperList(wallpapers: wallpapers,context:context)
            ],
          ),
        ),
      ),
    );
  }
}
