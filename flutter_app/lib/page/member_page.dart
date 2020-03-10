import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:color_dart/color_dart.dart';
import 'package:flutter_app/components/a_row/a_row.dart';
import 'package:flutter_app/utils/global.dart';
import 'package:flutter_app/utils/Icon.dart';
import 'package:flutter_app/components/a_row/custom_swiper/index.dart';
import 'package:flutter_app/jsonserialize/user/data.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/currentIndex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberPage extends StatelessWidget {
  var url = "https://panda36.com";

  UserData userData = G.user.data;

  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    getUserDetail();
    return Scaffold(
        appBar: new PreferredSize(
          child: new Container(
            padding:
                new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    color: hex('#ffffff'),
                    onPressed: () {
                      Navigator.pushNamed(context,'/upset');
                    },
                  ),
                )
              ],
            ),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(colors: [
                Color.fromRGBO(236, 56, 56, 1),
                Color.fromRGBO(247, 105, 105, 1)
              ]),
            ),
          ),
          preferredSize: new Size(MediaQuery.of(context).size.width, 40.0),
        ),
        body: Container(
          width: ScreenUtil().setWidth(750),
          child: ListView(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(510),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: buildUser(),
                    ),
                    Positioned(
                      top: ScreenUtil().setHeight(240),
                      child: _orderList(),
                    ),
                  ],
                ),
              ),
              banner(),
              _actionList(),
              setList(),
              LoginOutView(context),
            ],
          ),
        ));
  }

  Widget collect() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(330),
            child: Column(
              children: <Widget>[
                Text(
                  '10',
                  style: TextStyle(color: hex('#ffffff')),
                ),
                Text(
                  '收藏',
                  style: TextStyle(color: hex('#ffffff')),
                ),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(330),
            child: Column(
              children: <Widget>[
                Text(
                  '100',
                  style: TextStyle(color: hex('#ffffff')),
                ),
                Text(
                  '分享',
                  style: TextStyle(color: hex('#ffffff')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget banner() {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(25), 0,
          ScreenUtil().setWidth(25), ScreenUtil().setWidth(30)),
      width: ScreenUtil().setWidth(700),
      decoration: BoxDecoration(
        color: hex('#ffffff'),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomSwiper([
        'https://panda36.com/images/20200120/b346c32a265a5a6cfcad29930a0fcab6.jpeg',
//                          'lib/assets/images/menu/swiper2.png',
      ], height: 130),
    );
  }

  Widget _ordertitle(title) {
    return Container(
      width: ScreenUtil().setWidth(700),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(20),
          ScreenUtil().setWidth(10),
          ScreenUtil().setWidth(5),
          ScreenUtil().setWidth(20)),
      child: Text(
        title,
        style: TextStyle(
          color: hex('#333333'),
          fontSize: ScreenUtil().setSp(37),
        ),
      ),
    );
  }

  Widget _orderType() {
    return Container(
      width: ScreenUtil().setWidth(700),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
//      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(175),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30,
                  color: hex("#ec3838"),
                ),
                Text('待付款'),
              ],
            ),
          ),
          //-----------------
          Container(
            width: ScreenUtil().setWidth(175),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                  color: hex("#ec3838"),

                ),
                Text('待发货'),
              ],
            ),
          ),
          //-----------------
          Container(
            width: ScreenUtil().setWidth(175),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                  color: hex("#ec3838"),

                ),
                Text('待收货'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(175),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30,
                  color: hex("#ec3838"),

                ),
                Text('待评价'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderList() {
    return Container(
      width: ScreenUtil().setWidth(700),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(25), 0,
          ScreenUtil().setWidth(25), ScreenUtil().setWidth(30)),
      decoration: BoxDecoration(
        color: hex('#ffffff'),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          _ordertitle('我的订单'),
          _orderType(),
        ],
      ),
    );
  }

  Widget _myListTile(String title,String point) {
    return Container(
      width: ScreenUtil().setWidth(175),
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
      child: Column(
        children: <Widget>[
          Text(
            point,
            style: TextStyle(
                color: hex(
                  '#ec3838',
                ),
                fontSize: ScreenUtil().setSp(35)),
          ),
          Text('(￥'+point+')',
              style: TextStyle(
                  color: hex(
                    '#333333',
                  ),
                  fontSize: ScreenUtil().setSp(30))),
          Text(
            title,
            style: TextStyle(
                color: hex(
                  '#333333',
                ),
                fontSize: ScreenUtil().setSp(26)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _actionList() {
    return Container(
      width: ScreenUtil().setWidth(700),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(25), 0,
          ScreenUtil().setWidth(25), ScreenUtil().setWidth(30)),
      decoration: BoxDecoration(
        color: hex('#ffffff'),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          _ordertitle('我的积分'),
          Container(
            child: Row(
              children: <Widget>[
                _myListTile('现金积分',userData.award_integral),
                _myListTile('奖励积分',userData.award_integral),
                _myListTile('待返还积分',userData.award_integral),
                _myListTile('pv',userData.award_integral),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget setList() {
    return Container(
      width: ScreenUtil().setWidth(700),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(25), 0,
          ScreenUtil().setWidth(25), ScreenUtil().setWidth(30)),
      decoration: BoxDecoration(
        color: hex('#ffffff'),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          _ordertitle('我的设置'),
          Container(
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
            child: Row(
              children: <Widget>[
                settitle(Icons.edit_location, '代理中心', hex('#ec3838')),
                settitle(Icons.thumbs_up_down, '推广', hex('#46D661')),
                settitle(Icons.stars, '设置', hex('#0d96f7')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settitle(var icon, var title, var color) {
    return Container(
      width: ScreenUtil().setWidth(230),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Icon(icon, color: color, size: ScreenUtil().setSp(78)),
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(title),
          )
        ],
      ),
    );
  }

  //头像区域
  Widget buildUser() {
    return Container(
        height: ScreenUtil().setHeight(350),
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(30),
            ScreenUtil().setHeight(0),
            ScreenUtil().setWidth(20),
            ScreenUtil().setHeight(0)),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(236, 56, 56, 1),
            Color.fromRGBO(247, 105, 105, 1)
          ]),
        ),
        child: Column(
          children: <Widget>[
            ARow(
              height: ScreenUtil().setHeight(150),
              color: Colors.transparent,
              border: G.borderBottom(show: false),
              padding: EdgeInsets.all(0),
              leftChild: ClipRRect(
                borderRadius: new BorderRadius.circular(27),
                child: Image.network(
//                  userData.profile_avatar == null
//                      ?
                'https://panda36.com/static/panda36/assets/img/touxianggray.png',
//                      : url + userData.profile_avatar,
                  width: ScreenUtil().setWidth(99),
                  height: ScreenUtil().setHeight(99),
                  fit: BoxFit.cover,
                ),
              ),
//              leftChild: Text(
//                userData.username,
//                style: TextStyle(
//                    color: rgba(255, 255, 255, 1),
//                    fontSize: ScreenUtil().setSp(48)),
//              ),
              centerChild: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  userData.username,
                  style: TextStyle(
                      color: rgba(255, 255, 255, 1),
                      fontSize: ScreenUtil().setSp(48)),
                ),
              ),
              rightChild: InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenUtil().setHeight(80),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(51, 51, 51, 0.15),
                      borderRadius: BorderRadius.all(Radius.circular(13))),
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0,
                      ScreenUtil().setWidth(30), 0),
                  child: Text(
                    '签到',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                  ),
                ),
              ),
              onPressed: () {},
            ),
            collect(),
          ],
        ));
  }

  Widget LoginOutView(context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      color: hex('#ffffff'),
      margin: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(25),
        0,
        ScreenUtil().setWidth(25),
        ScreenUtil().setWidth(30),
      ),
      height: ScreenUtil().setHeight(90),
      child: RaisedButton(
        child: Text(
          '退出',
          style: TextStyle(
            fontSize: 18.0,
            color: hex('#333333'),
          ),
        ),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
          loginout(context);
        },
      ),
    );
  }

  loginout(context) async {
    try {
      var result = await G.req.index.logout();
      var val = result.data;
      if (val['status'] == 0) {
//        saveisLogin('isLogin', true);
        Provide.value<CurrentIndexProvide>(context).changeIndex(0);
        Navigator.pushNamed(context, '/');
        await Provide.value<CurrentIndexProvide>(context).changelogin(false);
        await getUserDetail();
        prefs.remove('user');
        await G.toast('退出成功');
      }
    } catch (e) {
      G.toast('登录');
    }
  }

//  获取用户信息
  getUserDetail() async {
    var data ={
      'orderType' :'allOrder'
    };
    var res = await G.req.order.getAllOrder(data);
    Map val = res.data;
    print(val);
    G.toast(val['data'].toString());
  }
}
