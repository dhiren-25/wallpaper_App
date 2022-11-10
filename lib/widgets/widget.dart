
import 'package:flutter/material.dart';
import 'package:sdp_project/views/image_view.dart';
import '../model/wallpaper_model.dart';

Widget brandName(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center, // title ne center ma krva
    children: <Widget>[
      Text("CHITR",style: TextStyle(color: Colors.white),),
      Text('HUB',style: TextStyle(color: Colors.black87),)
    ],);

  // return RichText(text: TextSpan(
  //
  //   style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: <TextSpan>[
  //
  //     TextSpan(text: 'CHITR',style: TextStyle(color: Colors.black87)),
  //     TextSpan(text: 'HUB',style: TextStyle(color: Colors.blue)),
  //   ],
  // ),);
}

Widget wallpaperList( {required List<WallpaperModel> wallpapers ,context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
      //use of crossaxiscount we getting 2 img
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children:wallpapers.map((wallpaper){
        return GridTile(
           child: GestureDetector(
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(
                 imgUrl: wallpaper.src!.portrait,
               )
               ));
             },

             child: Hero(
                tag: wallpaper.src!.portrait,
               child: Container(
          // child: Image.network(wallpaper.src.portrait),
                 child: ClipRRect(
                         borderRadius: BorderRadius.circular(16),
                        child: Image.network(wallpaper.src!.portrait,fit: BoxFit.cover,)),
                ),
             ),
           ),
        );
      }).toList(),

    ),
  );
}