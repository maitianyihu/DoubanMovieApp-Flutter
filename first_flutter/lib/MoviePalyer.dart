import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class MoviewPlayerPage extends StatefulWidget {
  var movieURL;
  //重构方法接收参数
  MoviewPlayerPage({Key key, @required this.movieURL}) : super(key: key);

  @override
  _MoviewPlayerPageState createState() => _MoviewPlayerPageState();
}

class _MoviewPlayerPageState extends State<MoviewPlayerPage> {
  var palyer;
  @override
  void initState() {

     var vc = VideoPlayerController.network(widget.movieURL);
     palyer =  ChewieController(
      videoPlayerController: vc,
      aspectRatio: 1,
      autoPlay: true,
      looping: true,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.movieURL);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
          elevation: 3/2, //去掉导航条下面的阴影横线
          title: Text('预告')
      ),
      body: 
      Container(
        color: Colors.black87,
        child: Chewie(
      controller: palyer
    ),
      )
      
  
      
    );
  }

  @override
  void dispose() {
    super.dispose();
    palyer.videoPlayerController.dispose();
  }
}
