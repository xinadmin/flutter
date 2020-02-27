import 'package:flutter/material.dart';

class ForgetPage extends StatefulWidget {
  @override
  Map arguments;

  ForgetPage({Key key, this.arguments}) : super(key: key);

  ForgetPageState createState() =>
      new ForgetPageState(arguments: this.arguments);
}

class ForgetPageState extends State<ForgetPage> {
  @override
  Map arguments;

  ForgetPageState({this.arguments});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('找回密码'),
        backgroundColor: Color.fromRGBO(236, 56, 56, 1),
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
  void didUpdateWidget(ForgetPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
