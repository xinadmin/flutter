import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpsetPage extends StatefulWidget {
  @override
  _UpsetPageState createState() => _UpsetPageState();
}

class _UpsetPageState extends State<UpsetPage> {
  @override
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
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            listtitle('我的信息', () {
              Navigator.pushNamed(context, '/person');
            }),
            listtitle('收货地址', () {
              Navigator.pushNamed(context, '/address');
            }),
            listtitle('修改登录密码', () {
              Navigator.pushNamed(context, '/updateLoginPassword');
            }),
            listtitle('修改安全密码', () {
              Navigator.pushNamed(context, '/updateSecurityPassword');
            }),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            listtitle('语言', () {
              Navigator.pushNamed(context, '/person');
            }),
            listtitle('关于Panda', () {
              Navigator.pushNamed(context, '/person');
            }),
          ],
        ),
      ),
    );
  }

  Container listtitle(String title, tap) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          tap();
        },
        title: Text(
          title,
          style:
              TextStyle(color: Color.fromRGBO(48, 49, 51, 1), fontSize: 18.0),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: ScreenUtil().setSp(32),
          color: Color.fromRGBO(144, 147, 153, 1),
        ),
      ),
    );
  }
}
