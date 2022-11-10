import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import 'downloading_dialog.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({required this.imgUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[

        ///   img set to screen ************* ///
        Hero(
          tag: widget.imgUrl,
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              child: Image.network(widget.imgUrl, fit: BoxFit.cover,)),
        ),
        ///*************** cancel button start ******//
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 16,),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    ///by using Navigator.pop we redirect to home page.
                  },
                  child: Text("Cancel", style: TextStyle(color: Colors.white,fontSize: 20),)),
              SizedBox(height: 50,)

            ],),
        ),
      ],),

      ///**************  Set image as Wallpaper on home screen and lock screen
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 220),
        child: Row(
          children: [
            FloatingActionButton.extended(onPressed: ()async{

              int location = WallpaperManager.BOTH_SCREEN;
              var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
              bool result = await WallpaperManager.setWallpaperFromFile(file.path,location);

            }, label: Icon(Icons.wallpaper)),
            SizedBox(width: 10,),

///****************************  Share Button **************///////////////////////////

            FloatingActionButton(
              child: Icon(Icons.share_outlined),
              onPressed: (){
                Share.share(widget.imgUrl);
            },),
            SizedBox(width: 10,),



            /////////********* download button *****////////////////
            //
            // FloatingActionButton(onPressed: (){
            //
            //
            //   showDialog(context: context, builder: (context)=> const DownloadingDialog(),);
            // },
            // tooltip: 'Download Image',
            // child: const Icon(Icons.download),),


          ],
        ),
      ),

    );
  }
}


