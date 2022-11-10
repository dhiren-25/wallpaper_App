import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sdp_project/widgets/widget.dart';
import 'package:http/http.dart' as http;
import '../data/data.dart';
import '../model/wallpaper_model.dart';

class Search extends StatefulWidget {
  // const Search({Key? key}) : super(key: key);
   final String SearchQuery;
   Search({required this.SearchQuery});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpapers = [];
  TextEditingController searchController = new TextEditingController();
  //here we create also search bar bcoz some user want to search from this page also so they can search.

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
    getSearchWallpapers(widget.SearchQuery);
    super.initState();
    searchController.text = widget.SearchQuery ;
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

          ///*********** For Search Button////////////////////////////

          child: Column(
            children: <Widget>[Container(
              decoration: BoxDecoration(
                  color: Color(0xffe8e8e8),
                  borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.symmetric(horizontal: 24,vertical: 15),
              child: Row(children:<Widget> [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "Search wallpaper",
                        border: InputBorder.none
                    ),
                  ),
                ),
                ///*************For Search Button////////////////////////////

                GestureDetector(
                  ///GestureDetector is a property to check ...user click on search button or not?
                  onTap: (){
                  getSearchWallpapers(searchController.text);
                  },
                  child: Container(
                      child: Icon(Icons.search)),
                )
              ],),
            ),SizedBox(
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
