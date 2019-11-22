
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yaozhi/User/Model/AccountData.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class CollectionPageView extends StatefulWidget {

  final title;
  CollectionPageView({Key key, this.title}): super(key:key);


  @override
  CollectionPageViewState createState() {
    return CollectionPageViewState(title: this.title);
  }

}

class CollectionPageViewState extends State<CollectionPageView> {

  final title;

  List _mMainBean = List();
  //轮播图图片
  List imageSoucesArray = List();

  ScrollController _scrollController = new ScrollController();
 
  
  CollectionPageViewState({Key key, this.title}){

  }

  @override
  void initState() {
    
    super.initState();

    //封装图片
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578583&di=8ac87ba564d8ccb00d09203360448497&imgtype=0&src=http%3A%2F%2Fwww.33lc.com%2Farticle%2FUploadPic%2F2012-8%2F2012838583248130.jpg");
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578584&di=03d74a3f537d093dedf1013f625531e9&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F59c86223661fc.jpg");
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578586&di=ad8f781833c9f16344974f2cd395540a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F55f90d999551a.jpg");


    requestDataSouce();
  }

  requestDataSouce(){
    setState(() {


    //封装列表数据
    AccountData account1 = AccountData();
    account1.isLeft = true;
    account1.id = 8210;
    account1.cover = "title";
    

    AccountData account = AccountData();
    account.isLeft = true;
    account.id = 8210;
    account.cover = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578583&di=8ac87ba564d8ccb00d09203360448497&imgtype=0&src=http%3A%2F%2Fwww.33lc.com%2Farticle%2FUploadPic%2F2012-8%2F2012838583248130.jpg";
  
    _mMainBean.add(account);
    _mMainBean.add(account1);
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);

    _mMainBean.add(account1);
    account.cover = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578583&di=8ac87ba564d8ccb00d09203360448497&imgtype=0&src=http%3A%2F%2Fwww.33lc.com%2Farticle%2FUploadPic%2F2012-8%2F2012838583248130.jpg";
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);
      
    });
  }

  @override
  Widget build(BuildContext context) {

        
    final size = MediaQuery.of(context).size;
    final viewWidth = size.width;
    final viewHeight = size.height;

    return Scaffold(
      appBar: AppBar(title: Text("data"),),
      body: Column(
        children: <Widget>[

          new Container(
            width: viewWidth,
            height: viewHeight - 88,
            child: new StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      padding: const EdgeInsets.all(4.0),
                      itemCount: _mMainBean.length,
                      itemBuilder: (context, index) {
                        AccountData bean = _mMainBean[index];
                        return _getGridViewItemUI(context, bean, index);
                      },
                      controller: _scrollController,
                      staggeredTileBuilder: (int index) {//设置宽高比 2代表两倍的item宽度
                        AccountData bean1 = _mMainBean[index];
                        if (index == 0) {
                          return new StaggeredTile.count(2, 1);
                        } else if (bean1.cover == "title") {
                          return new StaggeredTile.count(2, 0.3);
                        } else if (index == 4) {
                          return new StaggeredTile.count(1, 1.6);
                        } else {
                          return new StaggeredTile.count(1, 1);
                        }
                      },
                    ),
          )  
        ],
      ),

    );
  }


  Widget _getGridViewItemUI(BuildContext context, AccountData city, int index) {
    if (index == 0) {
      return new Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150.0,
                  child: Swiper(
                    itemHeight: 149,
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
                ));
    } else if (city.cover == "title") {
      return Container(
          margin: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            "----------- 11"  + " 月 -----------",
            style: TextStyle(fontSize: 15, color: Colors.black38),
          ),
          alignment: Alignment.center,
        );
    } else {
      return InkWell(
        onTap: () {
          Navigator.of(context).pop(index);
        },
        child: Card(
          elevation: 4.0,
          child: Column(
            children: <Widget>[
              Image.network(
                city.cover,
                fit: BoxFit.cover,
              ),
              new Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  "city.date",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }



  //创建轮播图
  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "${imageSoucesArray[index]}",
      fit: BoxFit.fill,
    ));
  }









}