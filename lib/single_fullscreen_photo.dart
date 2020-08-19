import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/zoomable.dart';

class SingeFullscreenPhoto extends StatefulWidget {
  const SingeFullscreenPhoto(
      {Key key,
        this.showMenu,
        @required this.photo,
        @required this.onShowMenu,
        @required this.onZoomChanged})
      : super(key: key);

  final bool showMenu;
  final Function(bool shown) onShowMenu;
  final String photo;
  final Function(double value) onZoomChanged;

  @override
  _SingeFullscreenPhotoState createState() => _SingeFullscreenPhotoState();
}

class _SingeFullscreenPhotoState extends State<SingeFullscreenPhoto>
    with TickerProviderStateMixin {
  bool showMenu = true;
  AnimationController opacityController;
  Animation<double> opacity;

  @override
  void initState() {
    super.initState();
    opacityController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    opacity =
        CurvedAnimation(parent: opacityController, curve: Curves.easeInOut);
    opacityController.forward();
    showMenu = widget.showMenu;
  }

  @override
  void didUpdateWidget(SingeFullscreenPhoto oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      showMenu = widget.showMenu;
    });
  }

  @override
  void dispose() {
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 20) {
            Navigator.of(context).pop();
          }
        },
        onTap: () {
          setState(() => showMenu = !showMenu);
          widget.onShowMenu(showMenu);
        },
        child: Stack(children: <Widget>[
          Center(
              child: ZoomableWidget(
                minScale: 1.0,
                maxScale: 3.25,
                onZoomChanged: widget.onZoomChanged,
                singleFingerPan: true,
                multiFingersPan: true,
                enableFling: false,
                enableRotate: false,
                child: Container(
                  child: Image.network(
                      widget.photo
                  ),
                ),
              )),
          showMenu
              ? buildOverlayMenu(context)
              : Container()
        ]));
  }

  Widget buildOverlayMenu(BuildContext context) {
    return FadeTransition(
            opacity: opacity,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.only(
                        bottom: 5, top: 5, left: 15, right: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () => Navigator.of(context).pop()),
                        IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.only(
                        bottom: 5, top: 5, left: 15, right: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.favorite,
                                  color:
                                  Colors.red
                              ),
                              Text("12"),
                              SizedBox(width: 5),
                              Icon(Icons.sms,
                                  color: Colors.white),
                              Text("23"),
                              SizedBox(width: 5),
                            ]),
                        FlatButton.icon(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            onPressed: () {},
                            icon: Icon(Icons.crop_free,
                                color: Colors.white),
                            label: Text(
                              "user 123",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  )
                ]));
  }
}
