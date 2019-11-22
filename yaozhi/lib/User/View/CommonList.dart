import 'package:flutter/material.dart';

class CommonList extends StatefulWidget{

  CommonList({Key key, @required this.title}): super(key: key);

  var title;
  

  @override
  CommonListState createState() => CommonListState();

}

class CommonListState extends State<CommonList> with SingleTickerProviderStateMixin {

var title;


  Animation <double> animat;
  AnimationController aniController ;

@override
  void initState() {
    super.initState();

    aniController = AnimationController(
      duration: const Duration(milliseconds: 500),vsync: this);
      animat = new Tween(begin: 0.0, end: 200.0).animate(aniController)
      ..addListener((){
      setState((){

      });
    });
    aniController.forward();


  }

  @override
  Widget build(BuildContext context){


    return Scaffold(
      appBar: AppBar(
        title: Text("评价"),
      ),
      body: new Center(
        child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animat.value,
        width: animat.value,
        child: new FlutterLogo(),
      ),
      )
    );
  }


  dispose() {
    aniController.dispose();
    super.dispose();
  }


}


