import 'package:flutter/material.dart';

class FuQiangPage extends StatefulWidget {

    @override
      State<StatefulWidget> createState() {

        return FuQiangState();
      }
}

class FuQiangState extends State<FuQiangPage> {
final myTabs = [Tab(text: "体育",), Tab(text: "财经",)];
  @override
  Widget build(BuildContext context) {
      
      return Scaffold(
        appBar:AppBar( title:Text('富强'),centerTitle: true,backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: Text(
                    '富强',
                    style:TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 33.0,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                      letterSpacing: 5.0,
                     wordSpacing: 11.0,
//                  height: 6.0,
//                    decoration: TextDecoration.overline,
//                    decorationColor: Color.fromARGB(255, 22, 33, 88),
                    ) ,
                maxLines: 3,
                textAlign: TextAlign.center,
              )
        ),
        
      );
    }
}

// 导航条按钮
List<Widget> getNavigationBarItem (BuildContext context) {
  List<Widget> items = new List();
  Widget firstItem = new IconButton(icon: new Icon(Icons.ac_unit),
              onPressed: (){
                 Navigator.pushNamed(context, '/listviewPage');
              },
              color: Colors.blue,
            );
  Widget secondItem = new IconButton( icon: new Icon(Icons.access_alarm),
              onPressed: (){
                Navigator.pushNamed(context, '/listviewPage');
              },
              color: Colors.orangeAccent,
            );
  items.add(firstItem);
  items.add(secondItem);
  return items;
}