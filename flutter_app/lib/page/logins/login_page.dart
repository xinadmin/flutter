import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../service/service_method.dart';
import 'package:provide/provide.dart';
import '../../provide/currentIndex.dart';
import '../../config/common.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  Map arguments;

  LoginPage({Key key, this.arguments}) : super(key: key);

  @override
  LoginPageState createState() => new LoginPageState(arguments: this.arguments);
}

class LoginPageState extends State<LoginPage> {
  @override
  Map arguments;
  double hh = MediaQueryData.fromWindow(window).padding.top;

  var username;
  var password;
  var captcha;
  var nowtime = new DateTime.now().millisecondsSinceEpoch;

  LoginPageState({this.arguments});

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, hh, 0, 0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                alignment: Alignment.bottomLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(106, 106, 106, 1),
                    size: 33.0,
                  ),
                )),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              child: Image.network(
                'https://panda36.com/static/panda36/assets/img/m/main.png',
//              height: 140.0,
                width: 340.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextField(
                      decoration: InputDecoration(hintText: '请输入用户名'),
                      onChanged: (value) {
                        setState(() {
                          this.username = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: '请输入密码',
                            ),
                            onChanged: (value) {
                              setState(() {
                                this.password = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                              child: Text(
                                'Забыли пароль',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(106, 106, 106, 1),
                                    fontSize: 18.0),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/forget');
                              },
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '请输入验证码',
                            ),
                            onChanged: (value) {
                              setState(() {
                                this.captcha = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                              child: Image.network(
                                'http://192.168.10.100/m/captcha/getCaptcha?timeamp=' +
                                    this.nowtime.toString(),
                                fit: BoxFit.cover,
                                height: 50.0,
                              ),
                              onTap: () {
                                setState(() {
                                  this.nowtime =
                                      new DateTime.now().millisecondsSinceEpoch;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50.0,
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: RaisedButton(
                            child: Text(
                              '登陆',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            color: Color.fromRGBO(237, 71, 51, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            onPressed: () {
                              var formData = {
//                                'username': this.username,
//                                'captcha': this.captcha,
//                                'password': this.password
                                'username': 'RU_000002',
                                'captcha': '123123',
                                'password': '123456'
                              };
                              request('Shop-Login-login', formData: formData)
                                  .then((val) {
                                print(val);
                                if (val['status'] == 0) {
                                  getUserInfo(context);
                                  Navigator.pushNamed(context, '/');
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  void getUserInfo(context) async {

    saveisLogin('isLogin', true);

    await request('User-Profile-index').then((val) {
      if (val['status'] == 0) {
        Provide.value<CurrentIndexProvide>(context).changeUserinfo(val['data']["user"]);
//        formSave('user', json.encode(val['data']["user"]));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formClean();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(LoginPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
