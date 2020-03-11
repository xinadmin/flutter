import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:color_dart/color_dart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/config/common.dart';
import 'package:flutter_app/utils/global.dart';

class HomePage extends StatelessWidget {
  @override
//  double hh = MediaQueryData.fromWindow(window).padding.top;

  Widget build(BuildContext context) {
    return Scaffold(
      body: MainContent(),
    );
  }
}

class MainContent extends StatefulWidget {
  @override
  MainContentState createState() => new MainContentState();
}

class MainContentState extends State<MainContent>
    with TickerProviderStateMixin {
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
  int page = 1;
  String bgcolor = "#ffffff";
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

//  首页轮播图，导航栏，广告位，楼层数据
  void _getIndex() async {
    var result = await G.req.index.index();
    Map val = result.data;
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
        this.bgcolor = this.adver[0]['ad_name'];
      });
    }
  }
//  底部商品列表
  void _getGoodsList()  async {
    var formData = {
      'id': "",
      'page': this.page,
      'limit': 20,
      'where_by': 'all',
      'order_by': 'default',
      'sort_asc': ""
    };

      var result = await fakeRequest(formData);
      Map val = result.data;
      if (val['status'] == 0) {
        setState(() {
          this.list = val['data']['list'];
          ++this.page;
        });
      }else {
        G.toast(val['messages']);
      }
  }
  fakeRequest(formData) async{
    var result = await G.req.goods.goodsList(formData);
    return result;
  }
// 头部导航栏
  Widget TextFileWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            //修饰黑色背景与圆角
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(72),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0.0, 0.0, 0.0),
            child: Text(
              '请输入商品关键词',
              style: TextStyle(
                color: Colors.black12,
              ),
            ),
          ),
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Icon(
            Icons.camera,
            color: Colors.white,
            size: ScreenUtil().setSp(54),
          ),
        )
      ],
    );
  }


//  轮播图数据遍历
  List<Widget> _getAdv() {
    var list = adver.map((value) {
      return new Builder(
        builder: (BuildContext context) {
          return  Container(
            width: MediaQuery.of(context).size.width,

            margin:  EdgeInsets.symmetric(horizontal: 10.0),
            decoration:  BoxDecoration(
              color: hex(value["ad_name"].toString()),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: Image.network(
                G.url + value["ad_image"],
                fit: BoxFit.cover,
              ),
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
                  G.url + value["ad_image"],
                  height: ScreenUtil().setHeight(88),
                  width: ScreenUtil().setWidth(88),
                ),
              ),
              Text(
                value["ad_name"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: hex('#303133'),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/search');
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
                  height: ScreenUtil().setHeight(88),
                  width: ScreenUtil().setWidth(88),
                  decoration: BoxDecoration(color: Colors.black12),
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(48),
                width: ScreenUtil().setWidth(166),
                margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                decoration: BoxDecoration(color: Colors.black12),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/search');
        },
      );
    });
    return list.toList();
  }

//  轮播图
  Widget BannerContent() {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              height: ScreenUtil().setHeight(320),
              color: hex(bgcolor),
            ),
          ),
          Positioned(
            child: new CarouselSlider(
              items: this.adver.length > 0
                  ? this._getAdv()
                  : this._getAdvExample(),
              height: ScreenUtil().setHeight(400),
              autoPlay: true,
//              aspectRatio: 2.0,
              viewportFraction:1.0,
              onPageChanged: (index) {
                setState(() {
                  bgcolor =adver.length>0? adver[index]['ad_name']:"#ec3838";
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget advcontent() {
    if (this.adver1['ad_image'] == "") {
      return Container(
        height: ScreenUtil().setHeight(165.0),
        margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
        color: Colors.black12,
      );
    }
    return InkWell(
        onTap: () {},
        child: AspectRatio(
          aspectRatio: 12 / 4,
          child: Image.network(
            G.url + this.adver1['ad_image'],
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ));
  }

//  导航栏
  Widget NavContent(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(405),
      padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0, 0),
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
        width: ScreenUtil().setWidth(240),
        height: ScreenUtil().setHeight(284.0),
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), 0, 0, 0),
        decoration: BoxDecoration(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setHeight(10.0)),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                child: ClipRRect(
                  child: Image.network(
                    G.url + this.good_list1[index]['goods_image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: ScreenUtil().setHeight(40.0),
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(6.0), 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  this.good_list1[index]["locale_goods_name"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Color.fromRGBO(48, 49, 51, 1), fontSize: ScreenUtil().setSp(28)),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: ScreenUtil().setHeight(36.0),
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(6.0), 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  tranFrom(this.good_list1[index]["goods_price"]),
                  maxLines: 1,
                  style: TextStyle(
                      color: Color.fromRGBO(236, 56, 56, 1), fontSize: ScreenUtil().setSp(32)),
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
      width: ScreenUtil().setWidth(240),
      height: ScreenUtil().setHeight(284.0),
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
    return ListTile(
      leading: Image.network(
        'https://panda36.com/static/panda36/assets/img/m/zuanshi.png',
        width: ScreenUtil().setWidth(76.0),
        height: ScreenUtil().setHeight(80.0),
      ),
      title: Text(
        text["ad_name"] != null ? text["ad_name"] : '加载中',
        style: TextStyle(color: Color.fromRGBO(48, 49, 51, 1), fontSize: ScreenUtil().setSp(36)),
      ),
      subtitle: Text(
        'Competitive Products For You',
        maxLines: 1,
        style:
            TextStyle(color: Color.fromRGBO(144, 147, 153, 1), fontSize: ScreenUtil().setSp(30)),
        textAlign: TextAlign.left,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: ScreenUtil().setSp(40),
        color: Color.fromRGBO(144, 147, 153, 1),
      ),
    );
  }

  //一楼商品
  Widget FloorOneContent() {
    return Container(
      height: ScreenUtil().setHeight(640.0),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(16.0), 0, 0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(160.0),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10.0), ScreenUtil().setHeight(12.0), ScreenUtil().setWidth(10.0), 0),
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
              height: ScreenUtil().setHeight(360.0),
              margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40.0), ScreenUtil().setHeight(120.0), 0, 0),
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setHeight(10)),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  height: ScreenUtil().setHeight(780.0),
                  width: ScreenUtil().setWidth(760),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.vertical(
                      top: Radius.elliptical(8, 8),
                    ),
                    child: Image.network(
                      G.url + val['goods_image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(8), 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    val[name],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color.fromRGBO(48, 49, 51, 1), fontSize:ScreenUtil().setSp(28)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(8), 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tranFrom(val["goods_price"]),
                    style: TextStyle(
                        color: Color.fromRGBO(236, 56, 56, 1), fontSize: ScreenUtil().setSp(32)),
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

  List<Widget> _getFloorGoodsExample({double widths, double heights = 166}) {
    var list1 = [1, 2, 3, 4, 5, 6];
    var name = "";
    var list = list1.map(
      (val) {
        return Container(
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setWidth(10)),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  height: ScreenUtil().setHeight(780.0),
                  width: ScreenUtil().setWidth(760),
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
      margin: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(16.0), 0, 0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(160),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setWidth(12), ScreenUtil().setWidth(30), 0),
            child: text02 != null ? _myListTile(this.text02) : Text('nihao'),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0, ScreenUtil().setWidth(20), ScreenUtil().setHeight(20)),
            color: Colors.white,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: this.good_list2.length > 0
                  ? this._getFloorGoods(
                      widths: 216, goods: 'goods2', context: context)
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
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
      color: Colors.white,
      child: Column(children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(160),
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setWidth(12), ScreenUtil().setWidth(30), 0),
          child: text03 != null ? _myListTile(this.text03) : Text('nihao'),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0, ScreenUtil().setWidth(20), ScreenUtil().setHeight(20)),
          color: Colors.white,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: this.good_list2.length > 0
                ? _getFloorGoods(widths: 216, goods: 'goods3', context: context)
                : this._getFloorGoodsExample(widths: 216),
          ),
        ),
      ]),
    );
  }

  //四楼商品
  Widget FloorFourContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(10), 0, 0),
      child: Column(children: <Widget>[
        Container(
          height:ScreenUtil().setHeight(120),
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                'https://panda36.com/static/panda36/assets/img/m/love.png',
                width: ScreenUtil().setWidth(60),
                height: ScreenUtil().setHeight(60),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), 0, 0, 0),
                child: Text(
                  'Рекомендации',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(48, 49, 51, 1), fontSize: ScreenUtil().setSp(32)),
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
                : this._getFloorGoodsExample(widths: 330, heights: 225),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: hex(bgcolor),
        title: TextFileWidget(),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            BannerContent(),
            NavContent(context),
            FloorOneContent(),
            FloorTwoContent(context),
            FloorThreeContent(context),
            FloorFourContent(context),

          ],
          controller: _scrollController,
        ),
      ),
    );
  }



//  Future<List<int>> fakeRequest(int from, int to) async {
//    return Future.delayed(Duration(seconds: 2), () {
//      return List.generate(to - from, (i) => i + from);
//    });
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getIndex();
    _getGoodsList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }
  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      var formData = {
        'id': "",
        'page': this.page,
        'limit': 20,
        'where_by': 'all',
        'order_by': 'default',
        'sort_asc': ""
      };

      var result = await fakeRequest(formData);
      Map val = result.data;
      if (val['status'] == 0) {
        setState(() {
          this.list.addAll(val['data']['list']);
          isPerformingRequest = false;
          ++this.page;
        });
      }else {
        G.toast(val['messages']);
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
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
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
