import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:flutter_swiper/flutter_swiper.dart';

class ChildItemView extends StatefulWidget {
  
  String title;

  ChildItemView(this.title);

  @override
  _ChildItemViewState createState() => _ChildItemViewState();
}

class _ChildItemViewState extends State<ChildItemView> {
  

  var screenSize = window.physicalSize;
  
  
  List imageSoucesArray = List();

  //String imgsrc = 'http://5b0988e595225.cdn.sohucs.com/images' +'/20171218/342e43903694448b91698b5ce7623314.jpeg';
  
  var list = ['a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c'];
  var imgsrc = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573641346022&di=be8180633c93ef68872e4cf3535fff55&imgtype=0&src=http%3A%2F%2Fimg.jammyfm.com%2Fwordpress%2Fwp-content%2Fuploads%2Fimages%2F2017%2F11%2F12%2F1510465008281546.jpg';

  
  @override void initState() {
    // TODO: implement initState
    super.initState();

    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578583&di=8ac87ba564d8ccb00d09203360448497&imgtype=0&src=http%3A%2F%2Fwww.33lc.com%2Farticle%2FUploadPic%2F2012-8%2F2012838583248130.jpg");
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578584&di=03d74a3f537d093dedf1013f625531e9&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F59c86223661fc.jpg");
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578586&di=ad8f781833c9f16344974f2cd395540a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F55f90d999551a.jpg");

    //初始化数据
    //operateChangeContent();
    
  }

  @override
  Widget build(BuildContext context) {
    print('${this} hashCode=${this.hashCode}');


    final size = MediaQuery.of(context).size;
    final viewWidth = size.width;
    final viewHeight = size.height;


    return Scaffold(
      //上下结构
      body: Column(
        children: <Widget>[
          new Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150.0,
                  child: Swiper(
                    itemBuilder: _swiperBuilder,
                    itemCount: imageSoucesArray.length,
                    pagination: new SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.black54,
                        activeColor: Colors.white,
                      )),
                  control: new SwiperControl(),
                  scrollDirection: Axis.horizontal,
                  autoplay: true,
                  onTap: (index) {
                    print('点击了第$index个');
                  },
                )),

          new Container(
            height: 55,
            width: window.physicalSize.width,
            child: new Row(
              
              children: <Widget>[
                new Container(
                  width: viewWidth - 64,
                  height: 55,
                  child: MaterialButton(color: Colors.red,textColor: Colors.white, child: Text("北京恒华伟业科技股份有限公司"),onPressed: (){
                    showModalBottomSheet(context: context,builder: (BuildContext context) {
                      return new Container(height: viewHeight/4*3,child: new Image.network(this.imgsrc,));
                    },
                  ).then((val) {
                    print(val);
                  });
                },),
                ),
                
                new Container(
                  width: 64,
                  height: 55,
                  child: MaterialButton(color: Colors.green,textColor: Colors.white, child: Text("点我"),onPressed: (){

                  },),
                )
            ],
          ),
          ),

          new Container(
            width: viewWidth,
            height: viewHeight - 180 - 55 - 88,
            child: new GridView.count(
              padding: const EdgeInsets.all(8.0),
              primary: false,
              mainAxisSpacing: 1.0,
              crossAxisCount: 4,
              crossAxisSpacing: 1.0,
              children: buildGridTileList(9),
            ),
          ),
        ],
      )
      );
    }



    List<Widget> buildGridTileList(int number) {
      List<Widget> widgetList = new List();
      
      for (int i = 0; i < number; i++) {
        widgetList.add(
          new Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(top: 10),
                  child: Icon(Icons.today, color: Colors.red,),
                ),
                Text("发票信息"),
              ],
            ),
            /*decoration: new BoxDecoration(

                color: Colors.white,
                image: new DecorationImage(
                    image: new NetworkImage(this.imgsrc),
                    fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                    new BoxShadow(
                        offset: new Offset(0.0, 1.0),
                        blurRadius: 2.0,
                        color: const Color(0xffaaaaaa),
                    ),
                ],
            ),*/
        ));
      }
      return widgetList;
   }



    
  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "${imageSoucesArray[index]}",
      fit: BoxFit.fill,
    ));
  }
}


