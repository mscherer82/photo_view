import 'package:flutter/material.dart';
import 'package:photo_view/single_fullscreen_photo.dart';
import 'package:preload_page_view/preload_page_view.dart';

class FullscreenImageList extends StatefulWidget {
  List<String> photoList;

  FullscreenImageList({
    Key key,
    this.photoList,
  }) : super(key: key);

  @override
  _FullscreenImageListState createState() => _FullscreenImageListState();
}

class _FullscreenImageListState extends State<FullscreenImageList> {
  bool showMenu = false;
  bool zoomed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreloadPageView.builder(
        controller: PreloadPageController(initialPage: 0),
        physics: zoomed
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        preloadPagesCount: 3,
        itemCount: widget.photoList.length,
        itemBuilder: (BuildContext context, int index) {
          return SingeFullscreenPhoto(
              onZoomChanged: (value) => setState(() => zoomed = value != 1.0),
              showMenu: showMenu,
              photo: widget.photoList[index],
              onShowMenu: (bool shown) => setState(() => showMenu = shown));
        });
  }
}

