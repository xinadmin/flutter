import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/config/common.dart';
import 'package:flutter_app/provide/details_info.dart';
import 'package:flutter_app/provide/currentIndex.dart';
import 'package:flutter_app/provide/cart.dart';
import 'package:flutter_app/utils/global.dart';
class SureDialog extends StatefulWidget {
  @override
  int isSelectDiglog = 1;
  var goodsParam;
  int isSelectSpec = 0;
  var item;
  String isbuy= "";
  SureDialog({this.item, this.isSelectDiglog, this.goodsParam,this.isbuy});

  SureDialogState createState() => new SureDialogState(item:this.item, isSelectDiglog:this.isSelectDiglog, goodsParam:this.goodsParam,isbuy:this.isbuy);
}

class SureDialogState extends State<SureDialog> {
  @override
  Map series = {};
  int isSelectDiglog = 1;
  var goodsParam;
  String isbuy = 'buy';
  int isSelectSpec = 0;
  var item;
  var number = 1;
  var num=TextEditingController();
  SureDialogState({this.item, this.isSelectDiglog, this.goodsParam,this.isbuy});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Provide<DetailsInfoProvide>(builder: (context, child, val){
     return  DigContent(context);
    });
  }
//  规格组件
  Widget attrWidget(BuildContext context) {
    var goods_attr_key = Provide
        .value<DetailsInfoProvide>(context)
        .goodsInfo["goodsInfo"]['goods_attr_key'];
    if (goods_attr_key == "") {
      return Container(
        height: 0,
      );
    }
    var series = Provide.value<DetailsInfoProvide>(context).goodsInfo["series"];
    List<Widget> list = [];
    List<Widget> listattr = []; //先建一个数组用于存放循环生成的widget
    Widget content;
    series.forEach((key, value) {
      listattr = AttrInner(context,key, value);
      list.add(
          Container(
              child: Container(
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0, ScreenUtil().setWidth(20), 0),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(0,  ScreenUtil().setHeight(6), 0, ScreenUtil().setHeight(6)),
                      child: Text(
                        key,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(32),
                            color: Colors.black26),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                          children: listattr
                      ),
                    ),
                  ],
                ),
              ),
          )
      );
    });
    content = new Column(children: list);
    return content;
  }
//  选择规格值
  void selectSpec(var childrenindex,var parentindex) {
    Provide.value<DetailsInfoProvide>(context).changeSpecValue(childrenindex,parentindex);
  }
  //遍历规格值
  List<Widget> AttrInner(BuildContext context,var key, List attr) {
      List<Widget> list = [];
      for(var i = 0;i<attr.length;i++){
        list.add(
          Container(
            margin: EdgeInsets.fromLTRB(0, 0,  ScreenUtil().setWidth(8),  ScreenUtil().setHeight(8)),
            child: RaisedButton(
              elevation: 0,
              color:  attr[i]['selected']?Color.fromRGBO(251, 235, 238,1):Color.fromRGBO(238, 238, 238,1),
              child: Text(attr[i]['value'],
                style: TextStyle(
                  color: attr[i]['selected']?Color.fromRGBO(236, 56, 56, 1):Colors.black,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
              onPressed: () {
                selectSpec(i,key);
              },
            ),
          ));
      }
    return list.toList();
  }

//  输入框组件
  Widget NumWidget(BuildContext context, var attr) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(20),  ScreenUtil().setHeight(40),  ScreenUtil().setWidth(20), 0),
      height:   ScreenUtil().setHeight(180),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              'Число',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(34), color: Colors.black26),
            ),
          ),
          Positioned(
            right: 0,
            child: Wrap(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(80),
                  height:   ScreenUtil().setHeight(80),
                  alignment: Alignment.center,
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    padding: EdgeInsets.all(0),
                    color: Color.fromRGBO(85, 85, 85, 1),
                    onPressed: () {
                      setState(() {
                        if(number==1){
                          return;
                        }else {
                          --number;
                          this.num.text=number.toString();
                        }

                      });
                    },
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(100),
                  height:   ScreenUtil().setHeight(80),
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    controller: num,
                    textAlign: TextAlign.center,
                    onChanged: (value) {},
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(80),
                  height:   ScreenUtil().setHeight(80),
                  alignment: Alignment.center,
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Color.fromRGBO(85, 85, 85, 1),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        ++number;
                        this.num.text=number.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

// 商品参数
  Widget _getgoodsParam({BuildContext context, Map goodsParam}) {
    List<Widget> list = []; //先建一个数组用于存放循环生成的widget
    Widget content;
    goodsParam.forEach((key, value) {
      list.add(Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(242, 242, 242, 1)))),
        padding: EdgeInsets.fromLTRB(3, 7, 3, 7),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                key,
              ),
            ),
            Expanded(
              child: Text(
                value,
              ),
            )
          ],
        ),
      ));
    });
    content = new Column(children: list);
    return content;
  }

//  弹窗内部内容
  Widget DigContentInner(BuildContext context) {
//    判断显示商品参数弹窗内容
    if (isSelectDiglog == 0) {
      return  Container(
        height: ScreenUtil().setHeight(800),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          new BorderRadius.vertical(top: Radius.elliptical(10, 10)),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(110)),
              child: ListView(
              children: <Widget>[
              Container(
              alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(10), 0, ScreenUtil().setHeight(10)),
                child: Text(
                  'Параметры продукта',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1), fontSize: ScreenUtil().setSp(44)),
                ),
              ),
                Container(
                  width: ScreenUtil().setWidth(750),
                  padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(20), 0, ScreenUtil().setWidth(20), 0),
                  child: _getgoodsParam(context: context, goodsParam: goodsParam),
                ),
                ]
            )
          
        ),
            Positioned(
              bottom: ScreenUtil().setHeight(4),
              left: ScreenUtil().setWidth(15),
              child: DigButtonContent(context) //弹窗底部按钮,
            )
          ],
        ),
      );
    }
//    判断显示商品规格和数量
    var index = Provide.value<DetailsInfoProvide>(context).goodsInfo["specindex"];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.vertical(
            top: Radius.elliptical(10, 10)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.network(
                    G.url + item[index]['goods_image'],
                    height: ScreenUtil().setHeight(140),
                    width: ScreenUtil().setWidth(140),
                  ),
                  margin: EdgeInsets.fromLTRB( ScreenUtil().setWidth(30), 0,  ScreenUtil().setWidth(30),  ScreenUtil().setHeight(20)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tranFrom(item[index]['goods_price']),
                          style: TextStyle(
                            color: Color.fromRGBO(236, 56, 56, 1),
                            fontSize:  ScreenUtil().setSp(40),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                          child: Text(
                            'Запас:' + item[index]['inventory_quantity'],
                            style: TextStyle(
                              color: Color.fromRGBO(96, 98, 102, 1),
                              fontSize: ScreenUtil().setSp(32),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,  ScreenUtil().setHeight(8), 0, 0),
                          child: Text(
                            'Выбранные:' + item[index]['goods_attr_value'],
                            style: TextStyle(
                              color: Color.fromRGBO(96, 98, 102, 1),
                              fontSize: ScreenUtil().setSp(32),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ),
          attrWidget(context), //规格组件
          NumWidget(context, item), //输入框组件
          DigButtonContent(context) //弹窗底部按钮
        ],
      ),
    );
  }

//  弹窗内容
  Widget DigContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency, //设置透明的效果
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              bottom: 0,
              child: SizedBox(
                //比较常用的一个控件，设置具体尺寸
                  width: ScreenUtil().setWidth(750),
                  child: DigContentInner(context)),
            ),
          ], // 让子控件显示到中间
        ),
      ),
    );
  }

  //弹窗底部按钮
  Widget DigButtonContent(BuildContext context) {
    var attr = Provide.value<DetailsInfoProvide>(context).goodsInfo["goodsInfo"]['attr'];
    var index = Provide.value<DetailsInfoProvide>(context).goodsInfo["specindex"];
    var isLogin = Provide.value<CurrentIndexProvide>(context).isLogin;

    if (isbuy == "") {
      return Container(
        width: ScreenUtil().setWidth(720),
        child: ButtonContent(context, () {
          Navigator.pop(context);
        }, '确定'),
      );
    }else if (isbuy == "cart"){
        return Container(
          child: ButtonContent(context, () async {
            var formData = {
              'goods_id': attr[index]['id'],
              'goods_number': num.text,
            };
            G.loading.show(context);
            var result = await G.req.cart.join(formData);
            Map val = result.data;
            if (val['status'] == 0) {
                G.toast(val['messages']);
                await Provide.value<CartProvide>(context).save();
                await G.loading.hide(context);
                Navigator.pop(context);
            }else {
              await G.loading.hide(context);
              G.toast(val['messages']);
            }
          }, '加入购物车'),
        );
    }else {
      return Container(
          child: ButtonContent(context, () async {
            if(!isLogin){
              Navigator.pushNamed(context,'/login');
              return ;
            }
            var formData = {
              'goods_id': attr[index]['id'],
              'goods_number': num.text,
              'type': 'buyNow'
            };
            G.loading.show(context);
            var result = await G.req.cart.join(formData);
            Map val = result.data;
              if (val['status'] == 0) {
                await G.loading.hide(context);
                await Provide.value<CartProvide>(context).save();
                Navigator.pushNamed(context, '/createdOrderPage');
              }else {

                await G.loading.hide(context);
                G.toast(val['messages']);
              }
          }, '立即购买'),
      );
    }
  }

//  按钮生成
  Widget ButtonContent(BuildContext context, Function tap, String buttontext) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(85),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(65.0),
      ),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(40), top: ScreenUtil().setHeight(28), right: ScreenUtil().setWidth(40), bottom: ScreenUtil().setHeight(28)),
      child: RaisedButton(
        onPressed: () {
          tap();
        },
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Color.fromRGBO(236, 56, 56, 1),
        child: Text(
          buttontext,
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(36),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.num.text='1';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(SureDialog oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  void _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).save();
  }
}
