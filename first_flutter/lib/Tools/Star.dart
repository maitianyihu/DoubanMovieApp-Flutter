import 'package:flutter/material.dart';
class Scorestar extends StatefulWidget {

  final double score;

  @override
  // 构造函数
  Scorestar({
    Key key,
    this.score

  }):super(key:key);


  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Scorestarstate();
  }
}

class Scorestarstate extends State<Scorestar>{
  Color starColor = Colors.orange;
  double starSize = 15;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double score = widget.score;
    if (score == 0){
        return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star,color: starColor,size: starSize,),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
            ],
        );
    }
    if (score == 5){
        return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star_half,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
            ],
        );
    }
    if (score == 10){
        return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star,color: starColor,size: starSize,),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
            ],
        );
    }

    if (score == 15){
        return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star,color: starColor,),
              Icon(Icons.star_half,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
            ],
        );
    }

    if (score == 20){
        return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
            ],
        );
    }

    if (score == 25){
        return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star_half,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
            ],
        );
    }

    if (score == 30){
        return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
            ],
        );
    }

    if (score == 35){
        return Row(children: <Widget>[
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star_half,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
            ],
        );
    }

    if (score == 40){
        return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star_border,color: starColor,size: starSize),
            ],
        );
    }

    if (score == 45){
        return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star_half,color: starColor,size: starSize),
            ],
        );
    }

    if (score == 50){
        return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
              Icon(Icons.star,color: starColor,size: starSize),
            ],
        );
    }
  }

}