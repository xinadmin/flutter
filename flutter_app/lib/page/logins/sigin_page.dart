import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:color_dart/color_dart.dart';
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
  var nowtime = new DateTime.now().millisecondsSinceEpoch;

  SiginPageState({this.arguments});

  List<DropdownMenuItem> getListData(){
    List<DropdownMenuItem> items=new List();
    DropdownMenuItem dropdownMenuItem1=new DropdownMenuItem(
      child:new Text('1'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2=new DropdownMenuItem(
      child:new Text('2'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3=new DropdownMenuItem(
      child:new Text('3'),
      value: '3',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4=new DropdownMenuItem(
      child:new Text('4'),
      value: '4',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5=new DropdownMenuItem(
      child:new Text('5'),
      value: '5',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6=new DropdownMenuItem(
      child:new Text('6'),
      value: '6',
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7=new DropdownMenuItem(
      child:new Text('7'),
      value: '7',
    );
    items.add(dropdownMenuItem7);
    DropdownMenuItem dropdownMenuItem8=new DropdownMenuItem(
      child:new Text('8'),
      value: '8',
    );
    items.add(dropdownMenuItem8);
    DropdownMenuItem dropdownMenuItem9=new DropdownMenuItem(
      child:new Text('9'),
      value: '9',
    );
    items.add(dropdownMenuItem9);
    DropdownMenuItem dropdownMenuItem10=new DropdownMenuItem(
      child:new Text('10'),
      value: '10',
    );
    items.add(dropdownMenuItem10);
    DropdownMenuItem dropdownMenuItem101=new DropdownMenuItem(
      child:new Text('10'),
      value: '10',
    );
    items.add(dropdownMenuItem101);
    DropdownMenuItem dropdownMenuItem102=new DropdownMenuItem(
      child:new Text('10'),
      value: '10',
    );
    items.add(dropdownMenuItem102);
    DropdownMenuItem dropdownMenuItem103=new DropdownMenuItem(
      child:new Text('10'),
      value: '10',
    );
    items.add(dropdownMenuItem103);
    DropdownMenuItem dropdownMenuItem104=new DropdownMenuItem(
      child:new Text('10'),
      value: '10',
    );
    items.add(dropdownMenuItem104);
    return items;
  }
  var value;

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
      ..init(context);
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color.fromRGBO(85, 85, 85, 1),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                      width: ScreenUtil().setWidth(670),
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(40),
                          ScreenUtil().setWidth(20),
                          ScreenUtil().setWidth(40),
                          0),
                      child: DropdownButton(
                        items: getListData(),
                        hint:Container(
                          width: ScreenUtil().setWidth(565),
                          child: new Text('下拉选择你想要的数据',style: TextStyle(
                            fontSize: ScreenUtil().setSp(36)
                          ),),
                        )
                        ,//当没有默认值的时候可以设置的提示
                        value: value,//下拉菜单选择完之后显示给用户的值
                        onChanged: (T){//下拉菜单item点击之后的回调
                          setState(() {
                            value=T;
                          });
                        },
                        elevation: 24,//设置阴影的高度
                        style: new TextStyle(//设置文本框里面文字的样式
                            color: Colors.red
                        ),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                        iconSize: 50.0,//设置三角标icon的大小
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(670),
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(40),
                          ScreenUtil().setWidth(20),
                          ScreenUtil().setWidth(40),
                          0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '请填写你的真实姓名',
                        ),
                        
                        onChanged: (value) {
                          setState(() {
                            this.realname = value;
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
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(40),
                          ScreenUtil().setWidth(20),
                          ScreenUtil().setWidth(40),
                          0),
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
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(40),
                          ScreenUtil().setWidth(20),
                          ScreenUtil().setWidth(40),
                          0),
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
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(40),
                          ScreenUtil().setWidth(20),
                          ScreenUtil().setWidth(40),
                          0),
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
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(40),
                          ScreenUtil().setWidth(20),
                          ScreenUtil().setWidth(40),
                          0),
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
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(40),
                          ScreenUtil().setWidth(20),
                          ScreenUtil().setWidth(40),
                          0),
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
                      margin: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(40),
                          ScreenUtil().setWidth(20),
                          ScreenUtil().setWidth(40),
                          0),
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
                                  height: 48.0,
                                ),
                                onTap: () {
                                  setState(() {
                                    this.nowtime =
                                        new DateTime.now()
                                            .millisecondsSinceEpoch;
                                  });
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
                              materialTapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap,
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
                            height: ScreenUtil().setHeight(90),
                            margin: EdgeInsets.fromLTRB(
                                ScreenUtil().setWidth(40),
                                ScreenUtil().setWidth(40),
                                ScreenUtil().setWidth(40),
                                ScreenUtil().setWidth(20)),
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
