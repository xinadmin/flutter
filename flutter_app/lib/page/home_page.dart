import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

//import 'package:flutter_app/config/json.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_method.dart';
import '../config/common.dart';
import 'package:flutter/cupertino.dart';
import '../provide/currentIndex.dart';
class HomePage extends StatelessWidget {
  @override
//  double hh = MediaQueryData.fromWindow(window).padding.top;

  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title:Text('hello'),
//        ),
      body: MainContent(),
    );
  }
}

class MainContent extends StatefulWidget {
  @override
  MainContentState createState() => new MainContentState();
}

class MainContentState extends State<MainContent> {
  var url = "https://panda36.com";
  var adver = [];
  var navList = [];
  Map adver1 = {'ad_image': "", 'ad_url': ""};
  var text01 = {};
  var text02 = {};
  var text03 = {};
  var good_list1 = [];
  var good_list2 = [];
  var good_list3 = [];
  var list = [];

//  首页轮播图，导航栏，广告位，楼层数据
  void _getIndex() {
    request('Shop-Index-index').then((val) {
      if (val['status'] == 0) {
        setState(() {
          this.navList = val['navList'];
          this.adver = val['adver'];
          this.adver1['ad_url'] = val['adver1']['ad_url'];
          this.adver1['ad_image'] = val['adver1']['ad_image'];
          this.good_list1 = val['good_list1'];
          this.good_list2 = val['good_list2'];
          this.good_list3 = val['good_list3'];
          this.text01 = val['text01'];
          this.text02 = val['text02'];
          this.text03 = val['text03'];
        });
      }
    });

  }
 void _getuserinfo(){
   request('User-Profile-index').then((val) {
     print(val);
   });
 }
//  底部商品列表
  void _getGoodsList() {
    var formData = {
      'id': "",
      'page': 1,
      'limit': 20,
      'where_by': 'all',
      'order_by': 'default',
      'sort_asc': ""
    };
    request('Shop-Shop-goodsList', formData: formData).then((val) {
      if (val['status'] == 0) {
        setState(() {
          this.list = val['data']['list'];
        });
      }
    });
  }
// 头部搜索
  Widget AppContent() {
    return Container(
//        padding: EdgeInsets.fromLTRB(0, hh, 0, 0),
        child: Container(
      color: Color.fromRGBO(157, 27, 13, 1),
      height: 48.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 40.0,
              height: 40.0,
              child: Icon(
                Icons.ac_unit,
                color: Colors.white,
                size: 28.0,
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '请输入商品关键词',
                  style: TextStyle(
                    color: Colors.black12,
                  ),
                ),
              )),
          Expanded(
            child: Container(
              width: 80.0,
              height: 80.0,
              child: Icon(
                Icons.art_track,
                size: 28.0,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ],
      ),
    ));
  }

//  轮播图数据遍历
  List<Widget> _getAdv() {
    var list = adver.map((value) {
      return new Builder(
        builder: (BuildContext context) {
          return new Container(
            width: MediaQuery.of(context).size.width,
            margin: new EdgeInsets.symmetric(horizontal: 5.0),
            decoration: new BoxDecoration(
              color: Color.fromRGBO(157, 27, 13, 1),
            ),
            child: new Image.network(
              url + value["ad_image"],
              fit: BoxFit.fill,
            ),
          );
        },
      );
    });
    return list.toList();
  }

//  轮播图默认数据
  List<Widget> _getAdvExample() {
    var list = [1, 2, 3].map((value) {
      return new Builder(
        builder: (BuildContext context) {
          return new Container(
            width: MediaQuery.of(context).size.width,
            margin: new EdgeInsets.symmetric(horizontal: 5.0),
            decoration: new BoxDecoration(
              color: Color.fromRGBO(157, 27, 13, 1),
            ),
            child: Container(
              height: 144.0,
              decoration: BoxDecoration(color: Colors.black12),
            ),
          );
        },
      );
    });
    return list.toList();
  }

//  多个菜单栏
  List<Widget> _getNav(BuildContext context) {
    var list = this.navList.map((value) {
      return GestureDetector(
        child: Container(
          width: ScreenUtil().setWidth(187),
          child: Column(
            children: <Widget>[
              ClipOval(
                child: Image.network(
                  url + value["ad_image"],
                  fit: BoxFit.cover,
                  height: 44.0,
                  width: 44.0,
                ),
              ),
              Text(
                value["ad_name"],
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/search', arguments: {"id": 1});
        },
      );
    });
    return list.toList();
  }

//默认菜单栏
  List<Widget> _getNavExample(BuildContext context) {
    var list = [1, 2, 3, 4].map((value) {
      return GestureDetector(
        child: Container(
          width: ScreenUtil().setWidth(187),
          child: Column(
            children: <Widget>[
              ClipOval(
                child: Container(
                  height: 44.0,
                  width: 44.0,
                  decoration: BoxDecoration(color: Colors.black12),
                ),
              ),
              Container(
                height: 24.0,
                width: 84.0,
                margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                decoration: BoxDecoration(color: Colors.black12),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/search', arguments: {"id": 1});
        },
      );
    });
    return list.toList();
  }

//  轮播图
  Widget BannerContent() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: new CarouselSlider(
          items: this.adver.length > 0 ? this._getAdv() : this._getAdvExample(),
          height: 180.0,
          autoPlay: true),
    );
  }

  Widget advcontent() {
    if (this.adver1['ad_image'] == "") {
      return Container(
        height: 100.0,
        margin: EdgeInsets.all(20.0),
        color: Colors.black12,
      );
    }
    return InkWell(
      onTap: () {},
      child: AspectRatio(
        aspectRatio: 12/4,
        child: Image.network(
          this.url + this.adver1['ad_image'],
          fit: BoxFit.cover,
//          height: 80.0,
          alignment: Alignment.center,
        ),
      )
    );
  }

//  导航栏
  Widget NavContent(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(405),
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
              height: ScreenUtil().setHeight(190.0),
              child: Row(
                children: this.navList.length > 0
                    ? _getNav(context)
                    : _getNavExample(context),
              )),
          Container(
              width: ScreenUtil().setWidth(700),
              height: ScreenUtil().setHeight(165.0),
//              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: this.advcontent())
        ],
      ),
    );
  }

//  一层商品格式列表
  Widget _getFlootGoods(content, index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(content, '/product', arguments: {
          "goodsId": good_list1[index]['goods_series_id'],
        });
      },
      child: Container(
        width: 120.0,
        height: 142.0,
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        decoration: BoxDecoration(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                child: ClipRRect(
                  child: Image.network(
                    url + this.good_list1[index]['goods_image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 20.0,
                padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  this.good_list1[index]["locale_goods_name"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Color.fromRGBO(48, 49, 51, 1), fontSize: 14.0),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 18.0,
                padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  tranFrom(this.good_list1[index]["goods_price"]),
                  maxLines: 1,
                  style: TextStyle(
                      color: Color.fromRGBO(236, 56, 56, 1), fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//  默认楼层数据
  var example = [1, 2, 3];

  Widget _getFlootGoodsExample(content, index) {
    return Container(
      width: 120.0,
      height: 142.0,
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.black12,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 20.0,
              color: Colors.black12,
              padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 18.0,
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }

//  楼层标题
  Widget _myListTile(var text) {
//    return Row(
//      children: <Widget>[
//        Expanded(
//            child: Image.network(
//          'https://panda36.com/static/panda36/assets/img/m/zuanshi.png',
//          width: 38.0,
//          height: 40.0,
//        )),
//        Expanded(
//            flex: 6,
//            child: Container(
//              height: 40.0,
//              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//              child: Column(
//                children: <Widget>[
//                  Container(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                      text["ad_name"],
//                      overflow: TextOverflow.ellipsis,
//                      maxLines: 1,
//                      style: TextStyle(
//                          color: Color.fromRGBO(48, 49, 51, 1), fontSize: 18.0),
//                    ),
//                  ),
//                  Container(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                      'Competitive Products For You',
//                      maxLines: 1,
//                      style: TextStyle(
//                          color: Color.fromRGBO(144, 147, 153, 1),
//                          fontSize: 16.0),
//                      textAlign: TextAlign.left,
//                    ),
//                  ),
//                ],
//              ),
//            )),
//        Expanded(
//          child: Container(
//              width: 30.0,
//              height: 40.0,
//              alignment: Alignment.centerRight,
//              child: Icon(Icons.arrow_forward_ios,
//                  size: 22.0, color: Color.fromRGBO(144, 147, 153, 1))),
//        ),
//      ],
//    );
    return ListTile(
      leading: Image.network(
        'https://panda36.com/static/panda36/assets/img/m/zuanshi.png',
        width: 38.0,
        height: 40.0,
      ),
      title: Text(
        text["ad_name"] != null ? text["ad_name"] : '加载中',
        style: TextStyle(color: Color.fromRGBO(48, 49, 51, 1), fontSize: 18.0),
      ),
      subtitle: Text(
        'Competitive Products For You',
        maxLines: 1,
        style:
            TextStyle(color: Color.fromRGBO(144, 147, 153, 1), fontSize: 16.0),
        textAlign: TextAlign.left,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 22.0,
        color: Color.fromRGBO(144, 147, 153, 1),
      ),
    );
  }

  //一楼商品
  Widget FloorOneContent() {
    return Container(
      height: 320.0,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 80.0,
            padding: EdgeInsets.fromLTRB(15, 6, 15, 0),
            child:
                this.text01 != null ? _myListTile(this.text01) : Text('nihao'),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new NetworkImage(
                    'https://panda36.com/static/panda36/assets/img/m/bg2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              height: 180.0,
              margin: EdgeInsets.fromLTRB(20, 60, 0, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      blurRadius: 5.0,
                    )
                  ]),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this.good_list1.length,
                itemBuilder: this.good_list1.length > 0
                    ? this._getFlootGoods
                    : _getFlootGoodsExample,
              ),
            ),
          ),
        ],
      ),
    );
  }

//商品遍历
  List<Widget> _getFloorGoods(
      {double widths,
      String goods,
      double heights = 166,
      BuildContext context}) {
    var list1 = [];
    var name = "";
    if (goods == 'goods2') {
      name = 'locale_goods_name';
      list1 = this.good_list2;
    } else if (goods == 'goods3') {
      list1 = this.good_list3;
      name = 'locale_goods_name';
    } else {
      list1 = this.list;
      name = 'goods_name';
    }
    var list = list1.map((val) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/product', arguments: {
            "goodsId": val['goods_series_id'],
          });
        },
        child: Container(
          height: heights,
          width: ScreenUtil().setWidth(widths),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  blurRadius: 5.0,
                )
              ]),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  width: 380.0,
                  height: 390.0,
                  child: ClipRRect(
                    borderRadius:
                        new BorderRadius.vertical(top: Radius.elliptical(8, 8)),
                    child: Image.network(
                      url + val['goods_image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    val[name],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color.fromRGBO(48, 49, 51, 1), fontSize: 15.0),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tranFrom(val["goods_price"]),
                    style: TextStyle(
                        color: Color.fromRGBO(236, 56, 56, 1), fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
    return list.toList();
  }

  List<Widget> _getFloorGoodsExample({double widths,  double heights = 166}) {
    var list1 = [1,2,3,4,5,6];
    var name = "";
    var list = list1.map((val) {
      return
         Container(
          height: heights,
          width: ScreenUtil().setWidth(widths),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  blurRadius: 5.0,
                )
              ]),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  width: 380.0,
                  height: 390.0,
                  color: Colors.black12,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  color: Colors.black12,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  color: Colors.black12,
                ),
              ),
            ],
          ),
      );
    },
    );
    return list.toList();
  }



  //二楼商品
  Widget FloorTwoContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 80.0,
            padding: EdgeInsets.fromLTRB(15, 6, 15, 0),
            child: text02 != null ? _myListTile(this.text02) : Text('nihao'),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            color: Colors.white,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: this.good_list2.length > 0
                  ? this._getFloorGoods(widths: 216, goods: 'goods2', context: context)
                  : this._getFloorGoodsExample(widths: 216),
            ),
          ),
        ],
      ),
    );
  }

//三楼商品
  Widget FloorThreeContent(BuildContext context) {
    return Container(
//      height: 415.0,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
      color: Colors.white,
      child: Column(children: <Widget>[
        Container(
          height: 80.0,
          padding: EdgeInsets.fromLTRB(15, 6, 15, 0),
          child: text03 != null ? _myListTile(this.text03) : Text('nihao'),
        ),
        Container(
//          height: 330.0,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          color: Colors.white,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: this.good_list2.length > 0?_getFloorGoods(widths: 216, goods: 'goods3', context: context)
                  : this._getFloorGoodsExample(widths: 216),
          ),
        ),
      ]),
    );
  }

  //四楼商品
  Widget FloorFourContent(BuildContext context) {
    return Container(
//      height: 415.0,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Column(children: <Widget>[
        Container(
          height: 60.0,
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                'https://panda36.com/static/panda36/assets/img/m/love.png',
                width: 28.0,
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(3, 0,0,0),
                child:  Text(
                  'Рекомендации',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(48, 49, 51, 1), fontSize: 17.0),
                ),
              ),

            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: this.list.length > 0
                ? this._getFloorGoods(
                    widths: 330, goods: 'list', heights: 225, context: context)
                : this._getFloorGoodsExample(widths: 330,heights: 225),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            AppContent(),
            BannerContent(),
            NavContent(context),
            FloorOneContent(),
            FloorTwoContent(context),
            FloorThreeContent(context),
            FloorFourContent(context),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getIndex();
    _getGoodsList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(MainContent oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
