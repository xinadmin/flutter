import 'package:flutter/material.dart';
import 'package:flutter_app/jsonserialize/user/data.dart';
import 'package:flutter_app/utils/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:color_dart/color_dart.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  UserData userData = G.user.data;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设置',
          style: TextStyle(
            color: Color.fromRGBO(106, 106, 106, 1),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color.fromRGBO(85, 85, 85, 1),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
//        width: ScreenUtil().setWidth(750),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            listtitle('国籍',userData.country+tranfate(userData.language)),
            listtitle('真实姓名',userData.realname),
            listtitle('手机号码',userData.phone),
            listtitle('电子邮箱',userData.email),
            listtitle('省份',userData.province),
            listtitle('城市',userData.city),
            listtitle('地址',userData.city),
            listtitle('邮编',userData.zip_code),
            listtitle('性别',sex(userData.gender)),
            listtitle('账号',userData.username),

          ],
        ),
      ),
    );
  }
  String tranfate(String item) {
    var items= {'zh':'中文',"ru":'俄文',"en":'英文'};
    return items[item];
  }
  String sex(String item) {
    var items= {'0':'保密',"1":'男生',"2":'女生'};
    return items[item];
  }
  Widget listtitle (String title,String val){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setWidth(30),ScreenUtil().setWidth(20),ScreenUtil().setWidth(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: hex('#000000'),
                fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            val,
            style: TextStyle(
                color: hex('#999999'),
                fontSize: ScreenUtil().setSp(30)),
          ),
        ],
      ),
    );
  }
}
