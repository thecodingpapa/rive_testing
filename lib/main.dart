import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:rive_testing/model/menu_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;

  int selectedItem = 0;
  double itemSize;

  List items = [
    MenuItem(x: 0, name: 'rive_tutorial_phone', color: Colors.blueAccent),
    MenuItem(x: 1, name: 'rive_one', color: Colors.cyanAccent),
    MenuItem(x: 2, name: 'rive_tutorial_phone', color: Colors.pinkAccent),
    MenuItem(x: 3, name: 'rive_one', color: Colors.amberAccent),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    itemSize = size.width / items.length;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: PageView(
                controller: _pageController,
                children: items.map((item) {
                  return _page(item);
                }).toList(),
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: itemSize / 2,
            child: Container(
              color: Colors.black,
            ),
          ),
          AnimatedPositioned(
            left: itemSize * selectedItem,
            right: (items.length - 1 - selectedItem) * itemSize,
            bottom: 0,
            height: itemSize,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 450),
            child: Image.asset('assets/rounded_background_black.png'),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: itemSize,
            child: Row(
              children: items.map((item) {
                return _iconAnim(item);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _page(MenuItem item) => Container(
        color: item.color,
      );

  Widget _iconAnim(MenuItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item.x;
        });
        _pageController.animateToPage(item.x,
            duration: Duration(milliseconds: 450), curve: Curves.easeInOut);
      },
      child: Container(
        height: itemSize,
        width: itemSize,
        child: FlareActor(
          'assets/${item.name}.flr',
          color: item.color,
          animation: item.x == selectedItem ? 'go' : 'idle',
        ),
      ),
    );
  }
}
