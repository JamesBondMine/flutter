import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'dart:ui';

class UpLoadMore extends StatefulWidget {
  dynamic movieType;

  UpLoadMore({Key key, this.movieType}) : super(key: key);

  @override
  UpLoadMoreState createState() => UpLoadMoreState();
}

class UpLoadMoreState extends State<UpLoadMore> {
  var requestContent = '请求中。。。';
  int currentPage = 0;

  List movieList = new List();
  var totalSize;
  var screenSize = window.physicalSize;

  String loadMoreText = "";
  TextStyle loadMoreTextStyle =
      new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
  TextStyle titleStyle =
      new TextStyle(color: const Color(0xFF757575), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  //加载数据
  @override
  void initState() {
    super.initState();

    loadMoreData();

    uploadOperate();
  }

  //添加上拉加载组件
  uploadOperate() {
    //固定写法，初始化滚动监听器，加载更多使用
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;

      if (maxScroll == pixel && movieList.length < totalSize) {
        setState(() {
          loadMoreText = "正在加载中...";
          loadMoreTextStyle =
              new TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);
        });
        loadMoreData();
      } else {
        setState(() {
          loadMoreText = "没有更多数据";
          loadMoreTextStyle =
              new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
        });
      }
    });
  }

  void loadMoreData() async {
    var url = "https://api.apiopen.top/todayVideo";
    Dio dio = new Dio();
    Response response = await dio.get(url);

    setState(() {
      movieList.addAll(response.data["result"]);
      totalSize = 88;
    });
  }

  //加载更多进度条
  Widget buildProgressMoreIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Center(
        child: new Text(loadMoreText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload')),
      body: ListView.builder(
        itemCount: movieList.length + 1,
        itemBuilder: (context, index) {
          if (index == movieList.length) {
            return buildProgressMoreIndicator();
          } else {
            return renderRow(index, context);
          }
        },
        controller: _controller, //指明控制器加载更多使用
      ),
    );
  }

  //列表的ltem
  renderRow(index, context) {
    return Container(
      height: 100,
      color: Colors.red,
      margin: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
      child: Center(
        child: Text("上拉"),
      ),
    );
  }
}
