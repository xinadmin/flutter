import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/service/service_method.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/currentIndex.dart';
import 'package:flutter_app/provide/cart.dart';
import 'package:flutter_app/config/common.dart';
import 'dart:convert';
import 'package:flutter_app/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/request/Api.dart';

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
  SharedPreferences prefs;

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
                margin: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(20),
                    ScreenUtil().setWidth(40),
                    ScreenUtil().setWidth(40),
                    ScreenUtil().setWidth(40)),
                alignment: Alignment.bottomLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(106, 106, 106, 1),
                    size: ScreenUtil().setSp(45),
                  ),
                )),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Image.network(
                'https://panda36.com/static/panda36/assets/img/m/main.png',
                width: ScreenUtil().setWidth(680),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(40),
                        ScreenUtil().setWidth(20),
                        ScreenUtil().setWidth(40),
                        0),
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
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(40),
                        ScreenUtil().setWidth(20),
                        ScreenUtil().setWidth(40),
                        0),
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
                                    fontSize: ScreenUtil().setSp(32)),
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
                                'https://panda36.com/m/captcha/getCaptcha?timeamp=' +
                                    this.nowtime.toString(),
                                fit: BoxFit.cover,
                                height: ScreenUtil().setHeight(88),
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
                          height: ScreenUtil().setHeight(90),
                          margin: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(40),
                              ScreenUtil().setWidth(40),
                              ScreenUtil().setWidth(40),
                              0),
                          child: RaisedButton(
                            child: Text(
                              '登陆',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(28),
                                color: Colors.white,
                              ),
                            ),
                            color: Color.fromRGBO(237, 71, 51, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              login();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(40),
                        ScreenUtil().setWidth(40),
                        ScreenUtil().setWidth(40),
                        0),
                    child: InkWell(
                      child: Text(
                        '注册',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(34),
                          color: Colors.black38,
                        ),
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, '/sigin');
                      },
                    ),
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

//  登录
  login() async {
    if (this.username == null) {
      return G.toast('用户名不能为空');
    }
    if (this.password == null) {
      return G.toast('密码不能为空');
    }
    if (this.captcha == null) {
      return G.toast('验证码不能为空');
    }

    /// 登录前移除user， 不然登录会提示token错误
//    prefs.remove('user');
    var data = {
      'username': this.username,
      'captcha': this.captcha,
      'password': this.password
//      'username': 'RU_000002',
//      'captcha': '123123',
//      'password': '123456'
    };
    try {
//      G.loading.show(context);
      List<Cookie> cookies = [];
      var result = await G.req.index.login(data);
      var val = result.data;
      cookies = (await Api.cookieJar)
          .loadForRequest(Uri.parse(G.url + '/m/login/login'));
      (await Api.cookieJar)
          .saveFromResponse(Uri.parse(G.url + '/m/login/login'), cookies);
      if (val['status'] == 0) {
        await getUserDetail();
//        G.loading.hide(context);
      }else {
//        G.loading.hide(context);
        await G.toast(val.messages);
      }
    } catch (e) {
//      G.loading.hide(context);
      G.toast('登录');
    }
  }

//  获取用户信息
  getUserDetail() async {
    await Provide.value<CurrentIndexProvide>(context).changelogin(true);
    var res = await G.req.user.index();
    var data = res.data;
    Map json = data['data']['user'];
    G.user.init(json);
    await G.toast('登录成功');
    Navigator.pop(context);
    await Provide.value<CartProvide>(context).save();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
