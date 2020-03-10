import 'package:flutter/material.dart';
import 'package:flutter_app/page/index_page.dart';
import 'package:flutter_app/page/cart_page.dart';
import 'package:flutter_app/page/logins/login_page.dart';
import 'package:flutter_app/page/logins/sigin_page.dart';
import 'package:flutter_app/page/logins/forget_page.dart';
import 'package:flutter_app/page/product/product_page.dart';
import 'package:flutter_app/page/upset.dart';
import 'package:flutter_app/page/search.dart';
import 'package:flutter_app/page/message/person.dart';
import 'package:flutter_app/page/message/address.dart';
import 'package:flutter_app/page/message/updateLoginPassword.dart';
import 'package:flutter_app/page/message/updatSecurityPassword.dart';
import 'package:flutter_app/page/order/createdOrder.dart';

final routers = {
  '/login': (context, {arguments}) => LoginPage(arguments: arguments),
  '/sigin': (context, {arguments}) => SiginPage(arguments: arguments),
  '/forget': (context, {arguments}) => ForgetPage(arguments: arguments),
  '/sigin': (context, {arguments}) => SiginPage(arguments: arguments),
  '/search': (context, {arguments}) => SearchPage(arguments: arguments),
  '/product': (context, {arguments}) => ProductPage(arguments: arguments),
  '/cart': (context) => CartPage(),
  '/upset': (context) => UpsetPage(),
  '/person':(context) =>PersonPage(),
  '/address':(context) =>AddressPage(),
  '/updateLoginPassword':(context) =>UpdateLoginPassword(),
  '/createdOrderPage': (context) => CreatedOrderPage(),
  '/updateSecurityPassword':(context) =>UpdateSecurityPassword(),

  '/': (context) => IndexPage(),
};

var  onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routers[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context));
      return route;
    }
  }
};
