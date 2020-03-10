import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:color_dart/color_dart.dart';
import 'package:flutter_app/utils/global.dart';

class CreatedOrderPage extends StatefulWidget {
  @override
  _CreatedOrderPageState createState() => _CreatedOrderPageState();
}

class _CreatedOrderPageState extends State<CreatedOrderPage> {
  @override
  List goodsList = [];

  initorder(BuildContext context) async {
    try {
      var result = await G.req.order.step1();
      Map val = result.data;
      print(val);
      if (val['status'] == 0) {
        setState(() {
          goodsList = val['data']['goodsList'];
        });
        print(goodsList);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '确认订单',
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
        width: ScreenUtil().setWidth(750),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            address(),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Container(
              width: ScreenUtil().setWidth(750),
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(30),
                ScreenUtil().setWidth(20),
                ScreenUtil().setWidth(30),
                ScreenUtil().setWidth(20),
              ),
              child: Text(
                '商品信息',
                style: TextStyle(
                  color: hex('#606266'),
                  fontSize: ScreenUtil().setSp(34),
                ),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(750),
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: goodsContent(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> goodsContent() {
    print(goodsList.length);
    if (goodsList.length > 0) {
      var list = goodsList.map((val) {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                child: Image.network(
                  G.url + val['goods_image'],
                  width: ScreenUtil().setWidth(180),
                  height: ScreenUtil().setHeight(180),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(500),
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), 0, 0, 0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTitle(
                            val['localeGoodsName'],
                            ScreenUtil().setSp(34),
                            hex('#303133'),
                            EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(16),
                                0, ScreenUtil().setHeight(10))),
                        ListTitle(
                            'pv:' + val['goods_pv'],
                            ScreenUtil().setSp(30),
                            hex('#909399'),
                            EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(6), 0,
                                ScreenUtil().setHeight(10))),
                        ListTitle(
                            val['goods_price'] + '(' + val['goods_price'] + ")",
                            ScreenUtil().setSp(34),
                            hex('#303133'),
                            EdgeInsets.fromLTRB(0, 0, 0, 0)),
                        ListTitle(
                            val['goods_attr_value'],
                            ScreenUtil().setSp(34),
                            hex('#303133'),
                            EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      bottom: 20,
                      child: Text(
                        'x' + val['goods_number'],
                        style: TextStyle(
                            color: hex('#606266'),
                            fontSize: ScreenUtil().setSp(32)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
      return list.toList();
    } else {
      var list1 = [1, 2].map((val) {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(180),
                height: ScreenUtil().setHeight(180),
                color: Colors.black12,
              ),
              Container(
                width: ScreenUtil().setWidth(500),
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), 0, 0, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(500),
                        height: ScreenUtil().setHeight(60),
                        color: Colors.black12,
                        margin: EdgeInsets.fromLTRB(ScreenUtil().setHeight(10),
                            ScreenUtil().setHeight(10), 0, 0),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(500),
                        height: ScreenUtil().setHeight(60),
                        margin: EdgeInsets.fromLTRB(ScreenUtil().setHeight(10),
                            ScreenUtil().setHeight(10), 0, 0),
                        color: Colors.black12,
                      ),
                      Container(
                        width: ScreenUtil().setWidth(500),
                        height: ScreenUtil().setHeight(60),
                        color: Colors.black12,
                        margin: EdgeInsets.fromLTRB(ScreenUtil().setHeight(10),
                            ScreenUtil().setHeight(10), 0, 0),
                      )
                    ]),
              ),
            ],
          ),
        );
      });
      return list1.toList();
    }
  }

  Widget ListTitle(title, size, color, padding) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: size, color: color),
        maxLines: 1,
      ),
    );
  }

  Widget address() {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(
          Icons.edit_location,
          color: hex("#888888"),
          size: ScreenUtil().setSp(45),
        ),
        title: Text(
          '加载中',
          style:
              TextStyle(color: Color.fromRGBO(48, 49, 51, 1), fontSize: 18.0),
        ),
        subtitle: Text(
          'Competitive Products For YouCompetitive Products For YouCompetitive Products For YouCompetitive Products For YouCompetitive Products For You',
          maxLines: 1,
          style: TextStyle(color: hex("#888888"), fontSize: 16.0),
          textAlign: TextAlign.left,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 22.0,
          color: Color.fromRGBO(144, 147, 153, 1),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initorder(context);
  }
}
