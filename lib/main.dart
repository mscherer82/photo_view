import 'package:flutter/material.dart';
import 'package:photo_view/image_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void showPhotoListDlg(BuildContext context) {

    List<String> photoList = [
      "https://cdn.pixabay.com/photo/2017/05/12/11/47/buy-sarees-online-in-india-2306851_960_720.jpg",
      "https://cdn.pixabay.com/photo/2020/07/24/11/21/mobile-phone-5433726_960_720.jpg",
      "https://cdn.pixabay.com/photo/2014/12/16/11/06/online-dating-570216_960_720.jpg",
      "https://cdn.pixabay.com/photo/2018/01/15/07/21/man-3083341_960_720.jpg",
      "https://cdn.pixabay.com/photo/2018/04/07/00/17/the-body-of-water-3297466_960_720.jpg"
    ];

    Navigator.of(context).push(ImageDialog(photoList));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Flutter Demo"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FloatingActionButton(
          onPressed: () => showPhotoListDlg(context),
          child: Icon(Icons.photo),
        )
      ),
    );
  }
}
