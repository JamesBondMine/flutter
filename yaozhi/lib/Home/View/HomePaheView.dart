import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tableview/flutter_tableview.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:yaozhi/User/View/CommonList.dart';
import 'package:yaozhi/Home/View/PhotoSelect.dart';

class HomePagePageView extends StatefulWidget {
  String title;
  HomePagePageView({Key key, this.title}) : super(key: key);

  @override
  HomePageViewState createState() => HomePageViewState(title: this.title);
}

class HomePageViewState extends State<HomePagePageView> {
  String title;
  var contentText;
  List imageSoucesArray = List();

  String imgsrc = 'http://5b0988e595225.cdn.sohucs.com/images' +
      '/20171218/342e43903694448b91698b5ce7623314.jpeg';

  HomePageViewState({Key key, this.title}) {}

  String selectSigle;
  bool selectMore = true;

  double sliderValue = 0.4;

  String timeStr;
  String dateStr;

  Size screenSize;

  int sectionCount = 3;

  bool isSafeArea = true;

  // 每组有多少行（每组有多少个cell item）
  int _rowCountAtSection(int section) {
    if (section == 0) {
      return 5;
    } else if (section == 1) {
      return 10;
    } else {
      return 20;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imageSoucesArray.add(
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578583&di=8ac87ba564d8ccb00d09203360448497&imgtype=0&src=http%3A%2F%2Fwww.33lc.com%2Farticle%2FUploadPic%2F2012-8%2F2012838583248130.jpg");
    imageSoucesArray.add(
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578584&di=03d74a3f537d093dedf1013f625531e9&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F59c86223661fc.jpg");
    imageSoucesArray.add(
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573794578586&di=ad8f781833c9f16344974f2cd395540a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F55f90d999551a.jpg");

    //初始化数据
    operateChangeContent();

    requestDataSoucesAction();
  }

  //操作数据
  operateChangeContent() {
    setState(() {
      Future.delayed(Duration(seconds: 5), () {
        contentText = "修改后的数据*************************8";
      });
    });
  }

  //请求数据
  requestDataSoucesAction() async {
    Dio request = Dio();
    Response object;

    var url = "https://api.apiopen.top/musicRankings";
    object = await request.get(
      Uri.encodeFull(url),
    );
    print("请求到的数据如下：${object.data.toString()}");

    //response=await dio.post("/test",data:{"id":12,"name":"wendu"})
    //response=await dio.download("https://www.google.com/","./xx.html")

    //FormData formData = new FormData.from({"name": "wendux","age": 25});
    //response = await dio.post("/info", data: formData)

    setState(() {});
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

    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          width: screenSize.width,
          height: 180,
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
          ),
        ),
        Container(
            width: screenSize.width,
            height: screenSize.height - 180 - (isSafeArea ? 88 : 49),
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: FlutterTableView(
                sectionCount: sectionCount,
                rowCountAtSection: _rowCountAtSection,
                sectionHeaderBuilder: _sectionHeaderBuilder,
                cellBuilder: _cellBuilder,
                sectionHeaderHeight: _sectionHeaderHeight,
                cellHeight: _cellHeight,
              ),
            ))
      ],
    ));
  }

  // 创建每组的 section header widget
  Widget _sectionHeaderBuilder(BuildContext context, int section) {
    return InkWell(
      onTap: () {
        print('click section header. -> section:$section');
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16.0),
        color: Color.fromRGBO(220, 220, 220, 1),
        height: 100,
        child: Text('当前第$section组 :'),
      ),
    );
  }

  // 根据 section 和 row, 创建对应的 cell item widget
  Widget _cellBuilder(BuildContext context, int section, int row) {
    if (section == 0 && row == 0) {
      return InkWell(
        child: Container(
          child: Row(
            children: <Widget>[
              Switch(
                value: true,
                activeColor: Colors.blue,
                onChanged: (bool open) {
                  //Navigator.push(context, new MaterialPageRoute(builder:  (context) => DatePickerDemo()));
                  this.setState(() {
                    print("$open");
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else if (section == 0 && row == 1) {
      TextEditingController _textEditingController =
          new TextEditingController();
      return InkWell(
        child: Row(
          children: <Widget>[
            Container(
              width: screenSize.width / 2,
              height: 30,
              margin: const EdgeInsets.only(left: 10, right: 20),
              child: new TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: '请输入手机号',
                  //设置输入框前面有一个电话的按钮 suffixIcon
                  prefixIcon: Icon(Icons.phone),
                  labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
            new RaisedButton(
              onPressed: () {
                print(_textEditingController.text);
                _textEditingController.clear();
              },
              child: Text('清除'),
            )
          ],
        ),
      );
    } else if (section == 0 && row == 2) {
      return InkWell(
        onTap: () {
          //
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => CommonList(
                        title: "动画",
                      )));
        },
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: screenSize.width - 50,
              child: Text("动画"),
            ),
            Icon(Icons.arrow_right)
          ],
        ),
      );
    } else if (section == 0 && row == 3) {
      return Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 30),
            child: Text("单选"),
          ),
          Radio(
            groupValue: this.selectSigle,
            activeColor: Colors.red,
            value: "aa",
            onChanged: (String val) {
              this.setState(() {
                this.selectSigle = val; // aaa
              });
            },
          )
        ],
      );
    } else if (section == 0 && row == 4) {
      return Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 30),
            child: Text("复选"),
          ),
          Container(
            child: new Checkbox(
              value: this.selectMore,
              activeColor: Colors.red,
              onChanged: (bool val) {
                this.setState(() {
                  this.selectMore = !this.selectMore; //
                });
              },
            ),
          )
        ],
      );
    } else if (section == 1 && row == 0) {
      return Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 30),
            child: Text("Slider"),
          ),
          new Slider(
            value: this.sliderValue,
            max: 100.0,
            min: 0.0,
            activeColor: Colors.blue,
            onChanged: (double val) {
              this.setState(() {
                this.sliderValue = val;
              });
            },
          ),
        ],
      );
    } else if (section == 1 && row == 1) {
      return InkWell(
          onTap: () {
            //
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return PhotoSelect(
                title: "photo",
              );
            }));
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10, right: 30),
                width: screenSize.width - 80,
                child: Text("调用相册"),
              ),
              Icon(Icons.arrow_right)
            ],
          ));
    } else if (section == 1 && row == 2) {
      return InkWell(
          onTap: () {
            // 调用函数打开
            showDatePicker(
              context: context,
              initialDate: new DateTime.now(),
              firstDate:
                  new DateTime.now().subtract(new Duration(days: 30)), // 减 30 天
              lastDate:
                  new DateTime.now().add(new Duration(days: 30)), // 加 30 天
            ).then((DateTime val) {
              print(val); // 2018-07-12 00:00:00.000
              this.setState(() {
                dateStr = "${val.toString()}";
              });
            }).catchError((err) {
              print(err);
            });
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10, right: 30),
                width: screenSize.width - 80,
                child: Text("选择日期"),
              ),
              Icon(Icons.arrow_right)
            ],
          ));
    } else if (section == 1 && row == 3) {
      return InkWell(
          onTap: () {
            // 调用函数打开
            showTimePicker(
              context: context,
              initialTime: new TimeOfDay.now(),
            ).then((val) {
              print(
                  "****************************: ${val.hour} : ${val.minute} : ${val.period}");

              timeStr = "${val.hour} : ${val.minute} : ${val.period}";
              this.setState(() {});
            }).catchError((err) {
              print(err);
            });
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10, right: 30),
                width: screenSize.width - 80,
                child: Text("选择时间"),
              ),
              Icon(Icons.arrow_right)
            ],
          ));
    } else {
      return InkWell(
        onTap: () {
          print('click cell item. -> section:$section row:$row');
        },
        child: Container(
          padding: EdgeInsets.only(left: 16.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
          ))),
          height: 50.0,
          child: Text('I am cell -> section:$section  row$row'),
        ),
      );
    }
  }

  // section header widget 的高度
  double _sectionHeaderHeight(BuildContext context, int section) {
    return 50.0;
  }

  // cell item widget 的高度
  double _cellHeight(BuildContext context, int section, int row) {
    return 50.0;
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "${imageSoucesArray[index]}",
      fit: BoxFit.fill,
    ));
  }
}
