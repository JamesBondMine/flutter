import 'package:flutter/material.dart';
import 'package:yaozhi/User/View/UserDetail.dart';
import 'package:dio/dio.dart';
import 'package:yaozhi/Common/SecondScreen.dart';
import 'UpLoadMore.dart';



class UserCenterPage extends StatelessWidget{

  //初始化数据
  var dataSouce = ['商品详情','listView','上拉加载','设置'];

  var headerImageUrl = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573645991554&di=129aa7ba9004d43ddb6e740add7f0ada&imgtype=0&src=http%3A%2F%2Fpic27.nipic.com%2F20130329%2F3941201_000946128123_2.jpg';


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        slivers: <Widget>[
          // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
          SliverToBoxAdapter(
            child: Container(
              height: 240,
              color: Colors.white,
              child: new Image.network(this.headerImageUrl, fit: BoxFit.cover,),
                ),
          ),
          // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(_buildListItem, childCount: dataSouce.length),
              itemExtent: 55.0
          )
        ],
      ),
      
    );
  }




    // 列表项
  Widget _buildListItem(BuildContext context, int index){
    return ListTile(
      title: Text(dataSouce[index], style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600,),),
      onTap: (){
        
        print('您点击了第$index行');

        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpLoadMore()));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetail()));
        }
       // this.getData();


    },);
  }


   //异步函数，用于网络请求
  //HTTP的get请求返回值为Future<String>类型，即其返回值未来是一个String类型的值
  getData() async {
    //async关键字声明该函数内部有代码需要延迟执行    
    Dio dioRequest = Dio();
    Response respons ;
    var url = "http://www.google.cn";
    respons = await dioRequest.get(Uri.encodeFull(url), );
    print('请求结果是： ${respons.data.toString()}');

  }


}

