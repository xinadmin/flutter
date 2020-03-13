import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/cart.dart';
import 'package:flutter_app/page/cart_page/cart_item.dart';
import 'package:flutter_app/page/cart_page/cart_bottom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/utils/global.dart';
class CartPage extends StatelessWidget {
  Map arguments;

  CartPage({this.arguments});


  @override
  Widget build(BuildContext context) {
    return CartContent();
  }
}

class CartContent extends StatefulWidget {
  @override
  CartContentState createState() => new CartContentState();
}

class CartContentState extends State<CartContent> {
  @override
  List cartList = [];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body:
      FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          List cartList=Provide.value<CartProvide>(context).cartList;
          if(snapshot.hasData && cartList!=null){
            return Stack(
              children: <Widget>[
                Provide<CartProvide>(
                    builder: (context,child,childCategory){
                      cartList= Provide.value<CartProvide>(context).cartList;
                      if(cartList.length==0){
                        return NullCarts();
                      }
                      return Container(
                        margin: EdgeInsets.only(bottom:ScreenUtil().setHeight(200)),
                        child: ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (context,index){
                            return CartItem(cartList[index]);
                          },
                        ),
                      );
                    }
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  width: ScreenUtil().setWidth(750),
                  child: CartBottom(),
                )
              ],
            );
          } else {
            return NullCarts();
          }
        },
      ),
    );
  }
  Widget NullCarts(){
    return Center(
      child: Container(
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(2200),
          color: Colors.white,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network('https://panda36.com/static/panda36/assets/img/m/emptyCart.jpg',),
              Text('Ничего нет',
                style: TextStyle(
                    color: hex('#c0c4cc'),
                    fontSize: ScreenUtil().setSp(40)
                ),)
            ],
          )
      ),
    );
  }
  Future<String> _getCartInfo(BuildContext context) async {
      await Provide.value<CartProvide>(context).getCartInfo();
      return 'end';
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
  void didUpdateWidget(CartContent oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
