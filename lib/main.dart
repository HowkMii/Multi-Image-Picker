import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 // This widget is the root of your application.
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Flutter Demo',
     theme: ThemeData(
       primarySwatch: Colors.blue,
     ),
     home: MyHomePage(title: 'Flutter Demo Home Page'),
   );
 }
}

class MyHomePage extends StatefulWidget {
 MyHomePage({Key key, this.title}) : super(key: key);
 final String title;

 @override
 _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 List<Asset> images =List<Asset>();
 Future loadAssets() async{
   List<Asset> resultList =List<Asset>();
   try{
     resultList =await MultiImagePicker.pickImages(
       maxImages: 300,
       selectedAssets:images,
       enableCamera: true,
       materialOptions: MaterialOptions(
         actionBarColor: 'green',
         selectCircleStrokeColor: 'green'
       )
     );
     setState(() {
             images = resultList;
           });
   }catch(e){
     print(e);

   }
 }
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Pick Images"),
       actions: [
         FlatButton(
           onPressed: loadAssets,
           child: Text("Pick image"),
         ),
       ],
       
     ),
     body: GridView.count(
       crossAxisCount: 3,
       children: List.generate(images.length, (index){
         return AssetThumb(
           asset: images[index],
           width: 300,
           height: 300,

         );
       }),
        // This trailing comma makes auto-formatting nicer for build methods.
     ),
   );
 }
}