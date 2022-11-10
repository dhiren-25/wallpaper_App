import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sdp_project/data/data.dart';
import 'package:sdp_project/model/wallpaper_model.dart';
import 'package:sdp_project/views/categorie.dart';
import 'package:sdp_project/views/image_view.dart';
import 'package:sdp_project/views/search.dart';
import 'package:sdp_project/widgets/widget.dart';
import 'package:sdp_project/model/categories_model.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];

  TextEditingController searchController = new TextEditingController();

   getTrendingWallpapers() async {
     ///********************** Random Wallpapers ******///////////////////////////////

     var response =  await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=50&page=1"),
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
    getTrendingWallpapers();
   categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body:SingleChildScrollView(
        child: Container(child: Column(

          ///******************* For Search Button////////////////////////////

          children: <Widget>[
            Container(
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

                GestureDetector(
                  //GestureDetector is a property to check ...user click on search button or not?
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Search(
                          SearchQuery: searchController.text,
                        )
                    ));
                  },
                  child: Container(
                      child: Icon(Icons.search)),
                )

              ],),
            ),
  SizedBox(height: 16,),
            Container(

              height: 80,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder : (context,index){

                return CategoriesTile(
                  title: categories[index].categoriesName,
                  imgUrl: categories[index].imgUrl,
                );
              }),
            ),
            SizedBox(height: 16,),
            wallpaperList(wallpapers: wallpapers,context:context)
          ],
        ),),
      ),
    );
  }
}


class CategoriesTile extends StatelessWidget {
  //const CategoriesTile({Key? key}) : super(key: key);
   final String imgUrl, title ;
  CategoriesTile({required this.title , required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        ///*////**** redirect to categorie.dart file **** ////////////////////////////

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Categorie(
                categorieName: title.toLowerCase(),
            )
        ));
      },

      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(children:<Widget> [

          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl,height: 50,width: 100,fit: BoxFit.cover,)),
          Container(

          decoration:BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 50 ,width: 100,
          alignment: Alignment.center,
            child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),),
        ],),
      ),
    );
  }
}

