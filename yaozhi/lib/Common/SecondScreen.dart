import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yaozhi/User/Model/AccountData.dart';
import 'package:flutter/foundation.dart';
import 'package:yaozhi/User/View/CommonList.dart';
import 'package:yaozhi/User/Model/goodsInfo.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  
  

  List imageSoucesArray = List();
  List _mMainBean = List();
  List goodsInfoArray = List();
  //视图尺寸
  Size screenSize;

  bool isSafeArea = true;

  ScrollController _scrollController = ScrollController();

  //列表偏移量
  int listScrollOfsety = 0;

  //banner滚动下标
  int bannerSelectIndex = 0;

  ThemeData themeData = ThemeData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var typeArray = ["","品牌","材质","图案","风格","成色","价格区间","适用性别","","品牌","材质","图案","风格","成色","价格区间","适用性别","适用性别"];

    var titleArray = ["规格参数","Dala/戴拉","合金/镀银/镀金","蝴蝶/蜻蜓/昆虫","日韩","全新","51-980元","女性","包装售后","Dala/戴拉","合金/镀银/镀金","蝴蝶/蜻蜓/昆虫","日韩","全新","51-980元","女性","女性"];
    for (int i = 0 ; i < 17; i ++){
      GoodsInfo goods = GoodsInfo();
      
      goods.title = typeArray[i];
      goods.type = titleArray[i];
      goodsInfoArray.add(goods);
    }

    AccountData account0 = AccountData();
    account0.title = "电表";
    account0.descripe = "DJG23-NLJ9876";
    account0.cover = "http://tgi13.jia.com/114/681/14681357.jpg";


    AccountData account = AccountData();
    account.isLeft = true;
    account.id = 8210;
    account.title = "NLY2678集中器";
    account.descripe = "DJG23-NLJ4532";
    account.cover = "http://img009.hc360.cn/m8/M0E/A4/91/wKhQpVcDpQ2Ea0iTAAAAAAB-o-o399.jpg..300x300.jpg";
    _mMainBean.add(account0);
    _mMainBean.add(account);
  
   
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);
    _mMainBean.add(account);

    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578583&di=8ac87ba564d8ccb00d09203360448497&imgtype=0&src=http%3A%2F%2Fwww.33lc.com%2Farticle%2FUploadPic%2F2012-8%2F2012838583248130.jpg");
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578584&di=03d74a3f537d093dedf1013f625531e9&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F59c86223661fc.jpg");
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578583&di=8ac87ba564d8ccb00d09203360448497&imgtype=0&src=http%3A%2F%2Fwww.33lc.com%2Farticle%2FUploadPic%2F2012-8%2F2012838583248130.jpg");
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578584&di=03d74a3f537d093dedf1013f625531e9&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F59c86223661fc.jpg");
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578583&di=8ac87ba564d8ccb00d09203360448497&imgtype=0&src=http%3A%2F%2Fwww.33lc.com%2Farticle%2FUploadPic%2F2012-8%2F2012838583248130.jpg");
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578584&di=03d74a3f537d093dedf1013f625531e9&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F59c86223661fc.jpg");
    imageSoucesArray.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578586&di=ad8f781833c9f16344974f2cd395540a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F55f90d999551a.jpg");


  }

  //刷新banner的个数
  refreshBannerSelect(int index){
    setState(() {
      bannerSelectIndex = index;
    });
  }

  //刷新listview偏移量
  refreshListViewOfset(int ofsety) {
    setState(() {
      listScrollOfsety = ofsety;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    if (Platform.isIOS) {
      if (MediaQuery.of(context).padding.top == null ||
          MediaQuery.of(context).padding.top == 0) {
            isSafeArea = false;
      }
    }


    //计算偏移量设置导航栏的透明度
    int navAlpha = 255;
    if (listScrollOfsety > 300){
      navAlpha = 255;
    } else if (listScrollOfsety < 200) {
      navAlpha = 0;
    } else {
      double dou = (listScrollOfsety - 200)/300;

      print("***************:  1当前透明度： $dou");
      String str = dou.toStringAsFixed(1);

      double doub = dou * dou;
      navAlpha = doub.toInt() * 225;
    }

    print("***************:  当前透明度： $navAlpha");

    return Scaffold(
      body: Stack(
        children: <Widget>[

          //列表
          Column(
          children: <Widget>[
            //列表
            new Container(
              width: screenSize.width,
              height: screenSize.height - (isSafeArea ? 88 : 64),
              //listView
              child: createListView()
            ),

            //底部操作
            Container(height: (isSafeArea ? 88 : 64), child: Row(
              children: <Widget>[
                new Container(
                  child: Row(
                    children: <Widget>[
                      createIconButton("店铺", "dianpu"),
                      createIconButton("购物车", "gouwuche"),
                      createIconButton("客服", "kefu"),
                      Container(
                        width: 105,
                        height: 40,
                        margin: const EdgeInsets.only(left: 30),
                        child: MaterialButton(color: Colors.red[500],textColor: Colors.white, child: Text("加入购物车"),onPressed: (){

                        },)
                      ),
                      Container(
                        width: 90,
                        height: 40,
                        margin: const EdgeInsets.only(left: 0),
                        child: MaterialButton(color: Colors.orange[500],textColor: Colors.white, child: Text("立即购买"),onPressed: (){

                        },)
                      ),
                    ],
                  ),
                )
              ],
            ),),
          ],
        ),

        //自定义导航栏
        Container(
          width: screenSize.width,
          height: isSafeArea ? 88 : 64,
          color: Colors.blue.withAlpha(navAlpha),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.only(bottom: 0, left: 10, top: 15),
                child: IconButton(
                  icon: Image.asset("images/back.png", width: 44, height: 44),
                  onPressed: (){
                    Navigator.pop(context);

                  },
                ),
              ),
                  ],
                )
              ),

              Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.only(bottom: 0, right: 10, top: 15),
                child: IconButton(
                  icon: Image.asset("images/more.png", width: 44, height: 44),
                  onPressed: (){

                  },
                ),
              ),
            ],
          ),
        )
        ],
      ),
    );
  }
  //创建按钮
  createIconButton(String title, String icon){
    return Container(
                        width: 55,
                        height: 55,
                        child: Column(
                        children: <Widget>[
                          Container(width: 25, height: 25, child: Image.asset("images/$icon.png"),),
                          Text(title, style: TextStyle(color: title.contains("店") ? Colors.blue : Colors.black),)],
                        ),
                      );
  }


  //构建listView
  createListView(){
    return new NotificationListener(
      onNotification: (ScrollNotification note) {
        ScrollMetrics metrics = note.metrics;
        if (metrics.axisDirection == AxisDirection.down || metrics.axisDirection == AxisDirection.down) {
          refreshListViewOfset(note.metrics.pixels.toInt());
        }
        },
        child:  MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: new Container(child: ListView.builder(
                itemCount: 27,
                itemBuilder: (context, index){
                  switch (index) {
                    case 0: return createSwiperAction(context);
                    break;
                    case 1: return createInfoAction(context, index);
                    break;
                    case 2: return InkWell(
                      onTap: (){
                        //领券
                        this.showAlert("领券", "优惠券已经领取完毕，\n快去使用吧！");
                        },
                      child: createCouponAction(context),
                    );
                    break;
                    case 3: return InkWell(
                      onTap: (){
                        showActionSheet("配电站高低压配电设备");
                      },
                      child: createSkuSelectCell(context),
                    );
                    break;
                    case 4: return createCommonHeader(context);
                    break;
                    case 5:
                    case 6: {
                        return createCommonCell(context);
                    }
                    break;
                    case 7: return createCommonFooterCell(context);
                    break;
                    case 8: return createShopCell(context);
                    break;
                    case 10:
                    return creatGoodsDetailCell(context);
                    case 9:
                    return createCollectionView(context, index);
                    break;
                    default:
                    return createTextCell(context, index);
                  }
                },
              ),
              ), ),
    );
  }
  //创建banner
  createSwiperAction(BuildContext context) {
    return Stack(
      alignment: const Alignment(0.9, 0.9),  
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 240,
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
            outer: false,
            autoplayDisableOnInteraction: false,
            onTap: (index) {
              print('点击了第$index个');
              
            },
            onIndexChanged: (index){
              refreshBannerSelect(index);
            },
          )),

          new ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
             width: 80,
             height: 30,
             decoration: new BoxDecoration(
              color: Colors.black.withAlpha(100),
              
            ),
            child: new Center(
              child: Text("${bannerSelectIndex + 1}/${imageSoucesArray.length}", style: TextStyle(fontSize: 21, color: Colors.white),),
            )
            ),
          ),

      ],
    );
  }

    //创建cell
  createCellAction(BuildContext context, int index) {
    return Container(
      child: Row(
        children: <Widget>[
          Text("data"),
        ],
      ),
    );
  }

    //创建主要信息
  createInfoAction(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(top: 15),
          child: new Row(
          children: <Widget>[
            Text("   ¥   ", style: TextStyle(color: Colors.red, fontSize: 16), ),
            new Container(width: screenSize.width - 220,child: Text("325.21", style: TextStyle(color: Colors.red, fontSize: 23, fontWeight: FontWeight.w500),),),
            new ClipRRect(
              borderRadius: BorderRadius.circular(3),
              
              child: Container(
                width: 90,
                height: 28,
                margin: const EdgeInsets.only(right: 10),
                decoration: new BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue[800], Colors.blue.withAlpha(200)])
                ),
                child: new Center(
                  child: Text("已收藏", style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
              ),
            ),

            new ClipRRect(
              child: Container(
                width: 70,
                height: 28,
                decoration: new BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue[800], Colors.blue.withAlpha(200)])
                ),
                child: Center(
                  child: Text("收藏", style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
              ),
              borderRadius: BorderRadius.circular(3),
            ),

          ],
        ),
        ),
        new Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: new Container(
                margin: const EdgeInsets.only(top: 10,bottom: 10),
                child: Text("遥知不是雪，唯有暗香来；遥知不是雪，唯有暗香来。", style: TextStyle(fontSize: 20, color: Colors.black),),
              )
        ),

        new Container(
              width: screenSize.width,
                height: 12,
                decoration: new BoxDecoration(
                  color: Colors.grey.withAlpha(80)
                ),
        )

      ],
    );
  }

  createCouponAction(BuildContext context){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
                    child:Container(
                      child: Center(
                        child: Text("领券", style: TextStyle(color: Colors.grey, fontSize: 16),),
                      ),
                    ),
                  ),
                  
                  //层
                  Stack(
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 20,
                        child: Image.asset("images/quanY1ellow.png", fit: BoxFit.cover,),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        child: Text("店铺券 满200减10", style: TextStyle(fontSize: 16, color: Colors.red),),
                      ),
                    ],
                  ),
                  
                  //层叠
                  Stack(
                    children: <Widget>[
                      Container(height: 20, child: Image.asset("images/quanB1lue.png",  fit: BoxFit.cover),),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text("平台券 满200减10", style: TextStyle(fontSize: 16, color: Colors.blue),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Container(
              width: 22,
              height: 28,
              margin: const EdgeInsets.only(right: 10),
              child: Image.asset("images/row.png"),
              )
            ],
          ),
          
          new Container(
            width: screenSize.width,
            height: 12,
            decoration: new BoxDecoration(
              color: Colors.grey.withAlpha(80)
            ),
          )
        ],
      );
    }


  //sku
  createSkuSelectCell(BuildContext context){
    return Column(
      children: <Widget>[
        Row(
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
              child:Container(
                child: Center(
                  child: Text("选择", style: TextStyle(color: Colors.grey, fontSize: 18),),
                ),
              ),
            ),
        Container(
          width: screenSize.width - 88,
          child: Text("配电站高低压配电设备 5.7Kg", style: TextStyle(color: Colors.black, fontSize: 18),),
        ),
        Container(
          width: 22,
          height: 28,
          child: Image.asset("images/row.png"),
        )
      ],
    ),
         new Container(
           width: screenSize.width,
           height: 8,
           decoration: new BoxDecoration(
             color: Colors.grey.withAlpha(80)
             ),
        )
      ],
    ); 
  }

  //评论头部
  createCommonHeader(BuildContext context){
    return InkWell(
      onTap: (){
        //宝贝评价点击
        Navigator.push(context, new MaterialPageRoute(builder: (context) => CommonList(title:"宝贝评论列表"),));

      },
      child: Row(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
          child: Text("宝贝评价", style: TextStyle(fontSize: 20, color: Colors.blue[500]),),
        ),
        Container(
          width: screenSize.width - 130,
          child: Text("1209", style: TextStyle(fontSize: 16, color: Colors.grey),),
        ),
        Container(
          width: 22,
          height: 28,
          child: Image.asset("images/row.png"),
        )
      ],
    ),
    );
  }

  //评论
  createCommonCell(BuildContext context){
    return Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            Container(margin: const EdgeInsets.only(left: 10, top: 12), child: CircleAvatar(
              //头像半径
              radius: 15,
              //头像图片
              backgroundImage: NetworkImage('https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg'),
            ),),
            Container(margin: const EdgeInsets.only(left: 10), child: Text("我是用户1", style: TextStyle(fontSize: 20,color: Colors.grey),),)
          ],
        ),

        Container(
          margin: const EdgeInsets.only(left: 10, top: 10), 
          child: Text(
            "我是评价我是评价我是评价我是评价我是评价我是评价我是评价我是评价我是评价我是评价", 
            style: TextStyle(color: Colors.black, fontSize: 18),), ),
        
        Container(
          height: 70,
          margin: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),child: Row(
         children: <Widget>[
           Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574067083971&di=6263f15fbd5f904b54f6b6e7077ff52d&imgtype=0&src=http%3A%2F%2Fimg003.hc360.cn%2Fm6%2FM05%2FF5%2F53%2FwKhQoVUsXdmEfoXxAAAAAFsMTCU247.jpg"),
         ], 
        ),)
      ],
    );
  }

  //
  createCommonFooterCell(BuildContext context){
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (){
            //全部评价
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return CommonList(title: "查看全部评价");
            }));

          },
          child: Container(
          width: screenSize.width - 200,
          margin: const EdgeInsets.only(top: 10, bottom: 10), 
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey, width: 1), // 边色与边宽度
            ),// 也可控件一边圆角大小
            child: new Center(child: Text("查看全部评价", style: TextStyle(fontSize: 22, color: Colors.black),),
          ),
      ),
        ),
      new Container(
        width: screenSize.width,
                height: 12,
                decoration: new BoxDecoration(
                  color: Colors.grey.withAlpha(80)
                ),
        )
      ],
    );
  }


  //
  createShopCell(BuildContext context){
    final double leftNum = (screenSize.width - 300 - 40)/2;
    return Column(
      children: <Widget>[

        Row(children: <Widget>[
          Container( margin: const EdgeInsets.only(left: 10, top: 15,bottom: 10), child: CircleAvatar(
              //头像半径
              radius: 15,
              //头像图片
              backgroundImage: NetworkImage('https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg'),
            ),),
            Container(margin: const EdgeInsets.only(left: 10), child: Text("福禄克旗舰店", style: TextStyle(fontSize: 20,color: Colors.black),),)
        ],),


        Center(
          child: Row(
            children: <Widget>[
                      Container(
                        width: (screenSize.width - 60)/3,
                        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20), 
                        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.blue, width: 1), 
            ),// 也可控件一边圆角大小
            child: new Center(
            child: Text("进店逛逛", style: TextStyle(fontSize: 18, color: Colors.blue),),
            
        ),),
                Container(
                  width: (screenSize.width - 60)/3,
          margin: const EdgeInsets.only(top: 10, bottom: 10, right: 20), 
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.blue, width: 1), 
            ),// 也可控件一边圆角大小
            child: new Center(
            child: Text("收藏本店", style: TextStyle(fontSize: 18, color: Colors.blue),),
            
        ),),
                Container(
                  width: (screenSize.width - 60)/3,
          margin: const EdgeInsets.only(top: 10, bottom: 10), 
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.blue, width: 1), 
            ),// 也可控件一边圆角大小
            child: new Center(
            child: Text("联系客服", style: TextStyle(fontSize: 18, color: Colors.blue),),
            
        ),),

            ],
          ),
        ),
              new Container(
        width: screenSize.width,
                height: 12,
                decoration: new BoxDecoration(
                  color: Colors.grey.withAlpha(80)
                ),
        )
      ],
    );
  }


  //商品详情cell
  creatGoodsDetailCell(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          child: Text("- 商品介绍 -", style:  TextStyle(color: Colors.black, fontSize: 18,), textAlign: TextAlign.center,),
        ),

        Container(
          height: 180,
          margin: const EdgeInsets.only(left: 10,right: 10),
          child: Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574073518273&di=937157ef5a49d48685d3f9127fc489dd&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201305%2F26%2F20130526140022_5fMJe.jpeg"),
        ),
        Container(
          height: 180,
          margin: const EdgeInsets.only(left: 10,right: 10),
          child: Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574073518273&di=937157ef5a49d48685d3f9127fc489dd&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201305%2F26%2F20130526140022_5fMJe.jpeg"),
        ),
      ],
    );
  }
  ////网格
  createCollectionView(BuildContext context, int index){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            new Container(
              width: 120,
              height: 35,
              margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Text("商品推荐", style: TextStyle(color: Colors.blue[500], fontSize: 20, fontWeight: FontWeight.w600),textAlign: TextAlign.left,)
        ),
          ],
        ),
        

        new Container(
            width: screenSize.width,
            height: 230,
            margin: const EdgeInsets.only(left: 10),
            child: new StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      scrollDirection: Axis.horizontal,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 14.0,
                      //padding: const EdgeInsets.all(4.0),
                      itemCount: _mMainBean.length,
                      itemBuilder: (context, index) {
                        return _getGridViewItemUI(context, index);
                      },
                      controller: _scrollController,
                      staggeredTileBuilder: (int index) {//设置宽高比 2代表两倍的item宽度
                        return new StaggeredTile.count(3, 1.6);
                      },
                    ),
          ),

          new Container(
            width: screenSize.width,
            margin: const EdgeInsets.only(top: 10),
                height: 12,
                decoration: new BoxDecoration(
                  color: Colors.grey.withAlpha(80)
                ),)

      ],
    );
  }


  //创建问文字cell
  createTextCell(BuildContext context, int index){
    GoodsInfo model = goodsInfoArray[index - 11];
    if (model.title.length == 0) {
      return Center(
          child: Container(
          margin: const EdgeInsets.only(top:25, bottom: 25),
          child: Text("- ${model.type} -", style:  TextStyle(color: Colors.black, fontSize: 22,), textAlign: TextAlign.center,),
        ));
    } else {
      return Row(
        children: <Widget>[  
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          child: Text("${model.title}: ", style:  TextStyle(color: Colors.black.withAlpha(100), fontSize: 16,), textAlign: TextAlign.left,),
        ),
        Text("${model.type} ", style:  TextStyle(color: Colors.black, fontSize: 16,), textAlign: TextAlign.left,),
        
                  
        ],
      );
    }
  }


    Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "${imageSoucesArray[index]}",
      fit: BoxFit.fill,
    ));
  }




    Widget _getGridViewItemUI(BuildContext context, int index) {
      AccountData model = _mMainBean[index];

      return InkWell(
        onTap: () {
          Navigator.of(context).pop(index);
        },
        child: Container(
          decoration: new BoxDecoration(border: new Border.all(color: Colors.grey, width: 0.5),),
          //elevation: 4.0,//阴影
          child: Column(
            children: <Widget>[
              Container(
                width: screenSize.width/2 - 50,
                height: 110,
                margin: const EdgeInsets.only(top: 10),
                child: Image.network(
                  model.cover,
                  fit: BoxFit.cover,
                ),

              ),
              new Container(
                width: screenSize.width/2 - 30,
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Text(
                  model.title,
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ),
              new Container(
                width: screenSize.width/2 - 30,
                margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                child: Text(
                  model.descripe,
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ),
              new Container(
                width: screenSize.width/2 - 30,
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(
                  "¥ 479.69",
                  style: TextStyle(fontSize: 14.0, color: Colors.red[500]),
                ),
              ),
            ],
          ),
        ),
      );

}







//自定义弹窗
showAlert(String title, String content){
  showCupertinoDialog(
       context:context,
       builder:(BuildContext context){
           return new CupertinoAlertDialog(
             title: new Text(
               title,
             ),
             content: new Text(content),
             actions: <Widget>[
               new Container(
                 decoration: BoxDecoration(
                   border: Border(right:BorderSide(color: themeData.dividerColor,width: 1.0),top:BorderSide(color: themeData.dividerColor,width: 1.0))
                 ),
                 child: FlatButton(
                   child: new Text("确定"),
                   onPressed:(){
                     Navigator.pop(context);
                   },
                 ),
               ),
               new Container(
                 decoration: BoxDecoration(
                     border: Border(top:BorderSide(color: themeData.dividerColor,width: 1.0))
                 ),
                 child: FlatButton(
                   child: new Text("取消"),
                   onPressed:(){
                     Navigator.pop(context);
                   },
                 ),
               )
             ],
           );
       }
    );
  }



  //弹出actionsheet
  showActionSheet(String content){
    showModalBottomSheet(context: context,builder: (BuildContext context) {
      return new Container(
        height: 88,
        child: Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 10, top: 15),
                  child: new Text(
                    content,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, right: 10),
            height: 88,
            child: Column(
              children: <Widget>[

          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          new Text('41')
              ],
            ),
          )
        ],
      ),
      );
    },).then((val) {
      print(val);
    });
  }
}







