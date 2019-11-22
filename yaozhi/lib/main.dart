import 'package:flutter/material.dart';
import 'package:yaozhi/ChildItemView.dart';
import 'package:yaozhi/User/View/UserCenterPage.dart';
import 'Home/View/HomePaheView.dart';
import 'package:yaozhi/Home/View/CollectionPageView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '首页'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var tabController; // 先声明变量

  @override
  void initState() {
    super.initState();
    this.tabController = new TabController(
      vsync: this, // 动画效果的异步处理
      length: 3, // tab 个数
      initialIndex: 0,
    );
  }

  // 当整个页面 dispose 时，记得把控制器也 dispose 掉，释放内存
  @override
  void dispose() {
    this.tabController.dispose();
    super.dispose();
  }

  void _incrementCounterplus(BuildContext context) {
    //Navigator.push(context, route)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => CollectionPageView()));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        body: new TabBarView(
          controller: this.tabController, //配置控制器
          children: [
            // Tab 内容
            new HomePagePageView(),
            new ChildItemView("2"),
            new UserCenterPage(),
          ],
        ),

        // 底端栏是一个 TabBar
        bottomNavigationBar: new Material(
          color: Colors.blue,
          child: new TabBar(
            controller: this.tabController,
            indicatorColor: Colors.white,
            tabs: <Tab>[
              new Tab(
                text: '主页',
                icon: new Icon(Icons.home),
              ),
              new Tab(
                text: '动态',
                icon: new Icon(Icons.star),
              ),
              new Tab(
                text: '我的',
                icon: new Icon(Icons.verified_user),
              ),
            ],
          ),
        ));
  }
}
