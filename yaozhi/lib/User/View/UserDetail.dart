import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'dart:ui';

class UserDetail extends StatefulWidget {
  dynamic movieType;

  //must be
  //final String title;

  UserDetail({Key key, this.movieType}) : super(key: key);

  @override
  _UserDetailState createState() {
    return new _UserDetailState(movieType: this.movieType);
  }
}

class _UserDetailState extends State<UserDetail> {
  var requestContent = '请求中。。。';
  int currentPage = 0;

  List movieList = new List();
  var totalSize;
  var screenSize = window.physicalSize;

  dynamic movieType;

  String loadMoreText = "";
  TextStyle loadMoreTextStyle =
      new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
  TextStyle titleStyle =
      new TextStyle(color: const Color(0xFF757575), fontSize: 14.0);

  //初始化滚动监听器，加载更多使用
  ScrollController _controller = new ScrollController();

  _UserDetailState({Key key, this.movieType}) {
    //固定写法，初始化滚动监听器，加载更多使用
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      print("___________________________滚动：$maxScroll");
      print("___________________________滚动1：$pixel");
      if (maxScroll == pixel && movieList.length < totalSize) {
        print("___________________________正在加载中");
        setState(() {
          loadMoreText = "正在加载中...";
          loadMoreTextStyle =
              new TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);
        });
        loadMoreData();
      } else {
        print("___________________________没有更多数据");
        setState(() {
          loadMoreText = "没有更多数据";
          loadMoreTextStyle =
              new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
        });
      }
    });
  }

  //加载数据
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadMoreData();
  }

  void loadMoreData() async {
    this.currentPage++;
    var start = (currentPage - 1) * 15;
    var url = "https://api.apiopen.top/todayVideo";

    print('****************************************请求数据如下：\n URL ： $url');

    Dio dio = new Dio();
    Response response = await dio.get(url);
    print('****************************************请求结果如下：\n  ${response.data.toString()}');

    setState(() {
      movieList.addAll(response.data["result"]);
      totalSize = 88;
    });
  }

  Future<Null> _refresh() async {
    movieList.clear();
    loadMoreData();
    print("refresh刷新****************\n\n\n");
    return null;
  }

  Future _pullToRefresh() async {
    currentPage = 0;
    movieList.clear();
    loadMoreData();
    print("下拉刷新********************\n\n\n");
    return null;
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
      appBar: AppBar(title: Text('设置'), actions: <Widget>[
        new IconButton(
            icon: new Icon(Icons.add),
            tooltip: 'Add Alarm',
            onPressed: () {
              print("跳转下一页");
            }),
      ]),
      body: movieList.length == 0
          ? new Center(child: new CircularProgressIndicator())
          : new RefreshIndicator(
              color: const Color(0xFF4483f6),
              //下拉刷新
              child: ListView.builder(
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
              onRefresh: _pullToRefresh,
            ),
    );

    //异步函数，用于网络请求
    //HTTP的get请求返回值为Future<String>类型，即其返回值未来是一个String类型的值
    getData() async {
      print('-------------------------------------------------');
      //async关键字声明该函数内部有代码需要延迟执行
      Dio dioRequest = Dio();
      Response respons;
      var url = "http://www.google.cn";
      respons = await dioRequest.get(
        Uri.encodeFull(url),
      );
      print('请求结果是：******\n ${respons.data.toString()}     ********');

      requestContent = respons.data.toString();

      requestContent = '请求成功了！';
    }
  }

  //列表的ltem
  renderRow(index, context) {
    Map movie = movieList[index]["data"];

    var id = movie["id"];
    var title = movie["text"];
    var type = movie["type"];
    var year = "最近";
    var score = 8.8;
    var logo = "";
    var descripe = "";
    double rowHeight = 100;
    bool videoRow = false;

    if (movie.containsKey("header")) {
      var date2 = DateTime.fromMillisecondsSinceEpoch(movie["header"]["time"]);
      title = movie["header"]["title"];
      if (title == null) {
        title = movie["header"]["issuerName"];
      }
      year = "$date2";
      logo = movie["url"];
      videoRow = true;
    }

    if (movie.containsKey("content")) {
      Map contentMap = movie["content"]["data"];
      if (contentMap.containsKey("url")) {
        logo = contentMap["url"];
      } else if (contentMap.containsKey("cover")) {
        logo = contentMap["cover"]["feed"];
      }
      descripe = contentMap["description"];
    }

    //根据是否有图来处理数据
    if (videoRow) {
      return new Container(
          height: videoRow ? 180 : 100,
          color: Colors.white,
          child: new InkWell(
              onTap: () {
                //Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new MovieDetail(movieId: id)));
              },
              child: new Column(children: <Widget>[
                new Container(
                    height: videoRow ? 179 : 99,
                    // color: Colors.blue,
                    child: new Row(children: <Widget>[
                      //图片
                      new Container(
                        width: 100.0,
                        height: 160.0,
                        margin: const EdgeInsets.all(10.0),
                        child: Image.network(logo),
                      ),

                      Expanded(
                        child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //第一行
                              new Container(
                                  width: screenSize.width - 150,
                                  padding: const EdgeInsets.only(
                                      bottom: 20.0, top: 8),
                                  child: new Row(children: <Widget>[
                                    new Container(
                                      //width: screenSize.width - 150 - 180,
                                      alignment: FractionalOffset.topLeft,
                                      padding: const EdgeInsets.only(right: 20),
                                      child: new Row(children: <Widget>[
                                        new Text("$title",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w700)),
                                      ]),
                                    ),
                                    new Icon(Icons.star, color: Colors.red[500])
                                  ])),

                              //第二行
                              new Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 12.0, right: 5),
                                  child: new Text(
                                    "描述：$descripe",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )),
                              new Container(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: new Text(
                                    "年份：$year",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )),
                              new Container(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: new Text(
                                    "评分：$score",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )),
                            ]),
                      ),
                    ])),
                new Divider(height: 1)
              ])));
    } else {
      return new Container(
          height: 88,
          color: Colors.white,
          child: new InkWell(
            onTap: () {
              //Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new MovieDetail(movieId: id)));
            },
            child: new Column(
              children: <Widget>[
                new Container(
                  height: 85,
                  // color: Colors.blue,
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Container(
                          height: 60.0,
                          margin: const EdgeInsets.all(12.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                "$title",
                                overflow: TextOverflow.ellipsis,
                              ),
                              new Text(
                                "类型：$type   年份：$year    评分：$score",
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //分割线
                new Divider(height: 1)
              ],
            ),
          ));
    }
  }
}
