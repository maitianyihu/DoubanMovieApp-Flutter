import 'package:flutter/material.dart';

class WenMingPage extends StatefulWidget{

  @override
    State<StatefulWidget> createState() {
      return WenMingPageState();
    }

}

class WenMingPageState extends State<WenMingPage> {

  @override

  Widget build(BuildContext context) {
     return Scaffold(
            appBar:AppBar( title:Text('文明'),centerTitle: true,actions: getNavigationBarItem(context),backgroundColor: Colors.greenAccent,),
            body:Center(
              child: Container(
                child: Text(
                    'SunShine',
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
              ),
//            color: Color.fromARGB(255, 22, 233, 3),
              alignment: Alignment.topCenter,
              margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
              decoration: new BoxDecoration(
                  gradient:new RadialGradient(
                    colors: [
                      Colors.deepOrange,
                      Colors.yellow,
                      Colors.greenAccent,
                    ]
                  )
              ),
            ),

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