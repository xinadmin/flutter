import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:color_dart/color_dart.dart';
import 'package:flutter_app/utils/global.dart';
import 'package:flutter_app/config/common.dart';
import 'package:flutter/cupertino.dart';

class CreatedOrderPage extends StatefulWidget {
  @override
  _CreatedOrderPageState createState() => _CreatedOrderPageState();
}

class _CreatedOrderPageState extends State<CreatedOrderPage> {
  @override
  List goodsList = [];
  List idList = [];
  double goodsPrice = 0.00;
  double goods_pv = 0.00;
  Map allGoodsContent = {};
  Map pointAndFreight = {};
  String max_integral = "0.0";
  String freight_money = "0.0";
  String my_integral = "0.0";

  var use_integral = new TextEditingController();



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
        color: hex('#f8f8f8'),
        width: ScreenUtil().setWidth(750),
        child: Stack(
          children: <Widget>[
             ListView(
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                address(),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Container(
                  width: ScreenUtil().setWidth(730),
                  margin: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(10), 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(width: 1, color: hex("#e4e7ed")),
                    ),
                  ),
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
                  width: ScreenUtil().setWidth(730),
                  margin: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(10), 0),
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: goodsContent(),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Container(
                  width: ScreenUtil().setWidth(730),
                  margin: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(10), 0),
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(30),
                    0,
                    0,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      goodsOther('商品总价', goodsPrice.toString(), true),
                      goodsOther('pv', goods_pv.toString(), false),
                      goodsOther('运费', freight_money, true),
                      goodsPoint(),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child:bottomContent(context),
            )
          ],
        ),

      ),
    );
  }

//  使用奖励积分
  Widget goodsPoint() {
    bool is_award_integral = this.allGoodsContent['is_award_integral'];
//     if (is_award_integral) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: hex("#e4e7ed")))),
      height: ScreenUtil().setHeight(120),
      width: ScreenUtil().setWidth(720),
      padding: EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '奖励积分',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: hex("#000000"),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      tranFrom('200'),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        color: hex('#303133'),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Container(
                      width: ScreenUtil().setWidth(120),
                      height: ScreenUtil().setHeight(60),
                      child: TextField(
                        style:TextStyle(
                          color: Colors.black,
                        ),
                        controller: this.use_integral,
                        onChanged: (value) {
                          setState(() {
                            this.use_integral.text = value;
                          });
                        },
                        decoration: InputDecoration(

                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Text('最多可用'+
                    this.max_integral.toString() +
                    '剩余' +
                    this.my_integral.toString()),
              ],
            ),
          )
        ],
      ),
    );
//    }
  }

  //商品其他参数
  Widget goodsOther(String title, String price, bool isdefault) {
    if (isdefault) {
      return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: hex("#e4e7ed")))),
        height: ScreenUtil().setHeight(90),
        width: ScreenUtil().setWidth(720),
        padding: EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: hex("#000000"),
              ),
            ),
            Text(
              tranFrom(price) + '(' + price + ')',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: hex('#303133'),
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: hex("#e4e7ed")))),
      height: ScreenUtil().setHeight(90),
      width: ScreenUtil().setWidth(720),
      padding: EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: hex("#000000"),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: hex('#303133'),
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

//  商品信息
  List<Widget> goodsContent() {
    if (goodsList.length > 0) {
      var list = goodsList.map((val) {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                        spreadRadius: 1.0,
                        color: Color.fromRGBO(242, 242, 242, 1),
                        blurRadius: 5.0,
                      )
                    ]),
                child: Image.network(
                  G.url + val['goods_image'],
                  width: ScreenUtil().setWidth(180),
                  height: ScreenUtil().setHeight(180),
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(495),
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), 0, 0, 0),
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(8)),
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
                            tranFrom(val['goods_price']) +
                                '(' +
                                val['goods_price'] +
                                ")",
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

//  遍历商品参数
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

// 收货地址
  Widget address() {
    var defaultConsignee = this.allGoodsContent['defaultConsignee'];
    if (defaultConsignee == null) {
      return Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(160),
        width: ScreenUtil().setWidth(730),
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(10), 0),
        child:IconButton(
          icon: Icon(Icons.add),
          color: Color.fromRGBO(85, 85, 85, 1),
          padding: EdgeInsets.all(0),
          iconSize: ScreenUtil().setSp(100),
          onPressed: () {
            Navigator.pop(context);
          },
        ) ,
      );
    }
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(730),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(10), 0),
      child: ListTile(
        onTap:(){

        },
        leading: Icon(
          CupertinoIcons.location_solid,
          color: hex("#888888"),
          size: ScreenUtil().setSp(59),
        ),
        title: Text(
          defaultConsignee['consignee']+'  '+defaultConsignee['phone'] ,
          maxLines: 1,
          style:
              TextStyle(color: Color.fromRGBO(48, 49, 51, 1), fontSize: ScreenUtil().setSp(32)),
        ),
        subtitle: Text(
          defaultConsignee['country']+' '+defaultConsignee['province']+' '+defaultConsignee['address'] +' '+defaultConsignee['zip_code'],
          maxLines: 3,
          style: TextStyle(color: hex("#888888"), fontSize: 16.0),
          textAlign: TextAlign.left,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: ScreenUtil().setSp(28),
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
    setState(() {
      this.use_integral.text = "0.00";
    });
  }
  initorder(BuildContext context) async {
    try {
      var result = await G.req.order.step1();
      Map val = result.data;
      if (val['status'] == 0) {
        setState(() {
          allGoodsContent = val['data'];
          goodsList = val['data']['goodsList'];
        });
        double price = 0.00;
        double pv = 0.00;
        List idList = [];
        List numList = [];
        for (var i = 0; i < this.goodsList.length; i++) {
          price += double.parse(this.goodsList[i]['goods_price']);
          pv += double.parse(this.goodsList[i]['goods_pv']);
          idList.add(this.goodsList[i]['id']);
          numList.add(this.goodsList[i]['goods_number']);
        }
        var data = {
          'goods_id_list': idList,
          'goods_id_number_list': numList,
          'consignee_id': 576,
          'express_method': 'express_delivery',
        };
        var result2 = await G.req.order.getFreight(data);
        Map val1 = result2.data;
        if (val1['status'] == 0) {
          setState(() {
            this.idList = idList;
            this.goodsPrice = price;
            this.goods_pv = pv;
            this.pointAndFreight = val1['data'];
            this.max_integral = val1['data']['max_integral'].toString();
            this.freight_money = val1['data']['freight_money'].toString();
            this.my_integral = val1['data']['my_integral'].toString();
            this.use_integral.text = val1['data']['max_integral'].toString();
          });
          print(this.use_integral.text);
        }
      } else {
        G.toast(val['messages']);
      }
    } catch (e) {
      print(e);
      G.toast('错误');
    }
  }


 Widget bottomContent (BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 2.0), //阴影xy轴偏移量
              spreadRadius: 4.0,
              color: Color.fromRGBO(242, 242, 242, 1),
              blurRadius: 5.0,
            )
          ]),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          allPriceArea(context),
          goButton(context)
        ],
      ),
    );
 }
  // 合计区域
  Widget allPriceArea(context) {
  var  price =  this.goodsPrice+double.parse(this.freight_money)-double.parse(this.use_integral.text);
    return Container(
      width: ScreenUtil().setWidth(300),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  'Итоговая цена:',
                  style: TextStyle(
                    color: Color.fromRGBO(48, 49, 51, 1),
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Text(
              tranFrom(price.toString())+ '(' + price.toString() + ")",
              style: TextStyle(
                color: Color.fromRGBO(236, 56, 56, 1),
                fontSize: ScreenUtil().setSp(38),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //结算按钮
  Widget goButton(context) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(4), 0, ScreenUtil().setWidth(4), 0),
      child: InkWell(
        onTap: () async{
           var data = {
             'express_method': 'express_delivery',
             'consignee_id': '576',
             'goods_id_list': this.idList,
             'integral': '0',
             'is_integral': '0'
           };
           var result = await G.req.order.step2(data);
           Map val = result.data;
           if (val['status'] == 0) {
            Navigator.pushNamed(context, '/pay',arguments: {
              'order_sn':val['data']['order_sn']
            });
           }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(10),
              ScreenUtil().setWidth(18),
              ScreenUtil().setWidth(10),
              ScreenUtil().setWidth(18)),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(25.0)),
          child: Text(
            'Оплатить сейчас',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(31),
            ),
          ),
        ),
      ),
    );
  }
}

