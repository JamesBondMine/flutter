import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoSelect extends StatefulWidget {
  var title;
  PhotoSelect({Key key, this.title}): super (key: key);

  @override 
  PhotoSelectState createState() => PhotoSelectState();
}

class PhotoSelectState extends State<PhotoSelect>{

  var _imgPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //调用相册
  loadSystermPhoto() {

    //var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  }

        /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _imgPath = image;
    });
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
  }

  openPhoto(){

  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("相册调用"),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _ImageView(_imgPath),
              RaisedButton(
                onPressed: (){
                  _openGallery();

                },
                child: Text("拍照"),
              ),
              RaisedButton(
                onPressed: (){
                  _takePhoto();
                },
                child: Text("选择照片"),
              ),
            ],
          ),

    )
    );
  }


    /*图片控件*/
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return Center(
        child: Text("请选择图片或拍照"),
      );
    } else {
      return Image.file(
        imgPath,
      );
    }






  }

  
}