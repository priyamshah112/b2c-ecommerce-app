import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class Carousel extends StatefulWidget {
  var images;
  Carousel({Key key, this.images}): super(key: key);
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();

  List<Widget> _list = [

  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
    // print("haramchor");
    print(widget.images);
    for(int i=0;i<widget.images.length;i++){
      _list.add(
          SliderBox(
              child: Image.network(
                'http://huzefam.sg-host.com/'+widget.images[i],
              )
          )
      );
    }
  }

  void _animateSlider() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      int nextPage = _controller.page.round() + 1;

      if (nextPage == _list.length) {
        nextPage = 0;
      }

      /*_controller
          .animateToPage(nextPage, duration: Duration(seconds: 1), curve: Curves.linear)
          .then((_) => _animateSlider());*/
    });
  }

  @override
  Widget build(BuildContext context) {
    PageIndicatorContainer container = new PageIndicatorContainer(
      pageView: new PageView(
        children: _list,
        controller: _controller,
      ),
      length: _list.length,
      padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
      indicatorSpace: 6,
      size: 7,
      indicatorColor: Colors.grey[350],
      indicatorSelectorColor: Colors.black87,
    );

    return Stack(
      children: <Widget>[
        Container(
           // color: Colors.grey[100],
            height: double.infinity
        ),
        Container(
            color: Colors.white,
            child: container,
            margin: EdgeInsets.only(bottom: 40)
        ),
      ],
    );
  }
}

class SliderBox extends StatelessWidget {
  final Widget child;
  const SliderBox({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: child
    );
  }
}
