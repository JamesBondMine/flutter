import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  var list = ['a', 'b', 'c', 'a', 'b', 'c'];

  @override
  Widget build(BuildContext context) {
    print('${this} hashCode=${this.hashCode}');
    return Scaffold(
      appBar: AppBar(title: Text('详情'),),
      body: new ListView(
        children: this.getList(),
          ),
          );
  }


   getList() {
    Iterable<Widget> listTitles = list.map((String item) {
        return new ListTile(
            isThreeLine: true,
            dense: false,
            leading: new CircleAvatar(child: new Text(item)),
            title: new Text('item 的标题'),
            subtitle: new Text('item 的内容'),
            trailing: new Icon(Icons.arrow_right, color: Colors.green),

            onTap: () {
              //监听点击事件
              print("您点击了当前行");

            },
        );
    });
    return listTitles.toList();
    }


    
}