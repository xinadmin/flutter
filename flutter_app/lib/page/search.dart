import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  Map arguments;

  SearchPage({Key key, this.arguments}) : super(key: key);

  SearchPageState createState() =>
      new SearchPageState(arguments: this.arguments);
}

class SearchPageState extends State<SearchPage> {
  @override
  Map arguments;

  SearchPageState({this.arguments});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        backgroundColor: Color.fromRGBO(236, 56, 56, 1),
      ),
      body: Container(
        child: FloatingActionButton(
          child: Text("${arguments != null ? arguments['id'] : ''}"),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
  void didUpdateWidget(SearchPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
