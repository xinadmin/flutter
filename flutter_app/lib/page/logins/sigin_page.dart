import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SiginPage extends StatefulWidget {
  @override
  Map arguments;

  SiginPage({Key key, this.arguments}) : super(key: key);

  SiginPageState createState() => new SiginPageState(arguments: this.arguments);
}

class SiginPageState extends State<SiginPage> {
  @override
  Map arguments;

  var email;
  var password;
  var password1;
  var security_password;
  var security_password1;
  var pid;
  var accept = false;
  var nationality;
  var captcha;
  var realname;
  var phone;

  SiginPageState({this.arguments});

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '注册',
            style: TextStyle(
              color: Color.fromRGBO(106, 106, 106, 1),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(106, 106, 106, 1),
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextField(
                        decoration: InputDecoration(hintText: '请填写你的真实姓名'),
                        onChanged: (value) {
                          setState(() {
                            this.realname = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextField(
                        decoration: InputDecoration(hintText: '请填写你的手机号'),
                        onChanged: (value) {
                          setState(() {
                            this.phone = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextField(
                        decoration: InputDecoration(hintText: '请填写你的电子邮箱'),
                        onChanged: (value) {
                          setState(() {
                            this.email = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextField(
                        obscureText: true,
                        decoration:
                            InputDecoration(hintText: '密码由6-16个数字/字母组成'),
                        onChanged: (value) {
                          setState(() {
                            this.password = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: '请再次输入登录密码'),
                        onChanged: (value) {
                          setState(() {
                            this.password1 = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextField(
                        obscureText: true,
                        decoration:
                            InputDecoration(hintText: '安全密码由6-16个数字字母组成'),
                        onChanged: (value) {
                          setState(() {
                            this.security_password = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: '请再次输入安全密码'),
                        onChanged: (value) {
                          setState(() {
                            this.security_password1 = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextField(
                        decoration: InputDecoration(hintText: '请输入推荐人id'),
                        onChanged: (value) {
                          setState(() {
                            this.pid = value;
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
                                  'http://panda36.com/m/captcha/getCaptcha?timeamp=1581177033525',
                                  fit: BoxFit.cover,
                                  height: 48.0,
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
                            child: Checkbox(
                              value: this.accept,
                              materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
                              activeColor: Color.fromRGBO(255, 51, 51, 1),
                              onChanged: (value) {
                                setState(() {
                                  this.accept = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  child: Text(
                                    '您已阅读并同意条款和条件协议',
                                    style: TextStyle(
                                      color: Color.fromRGBO(51, 51, 51, 1),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/forget');
                                  },
                                ),
                              ],
                            ),
//                              您已阅读并同意
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50.0,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                              onPressed: () {},
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
      ),
    );
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
  void didUpdateWidget(SiginPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
