import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget child = DottedBorder(
    color: Colors.black,
    strokeWidth: 1,
    borderType: BorderType.RRect,
    radius: Radius.circular(8),
    child: SampleShape(color: Colors.transparent),
  );

  Widget placeHolder = SampleShape(color: Colors.grey);

  Widget dataWidget = SampleShape(color: Colors.green.withOpacity(0.5));

  Widget baseWidget = SampleShape(color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable<Widget>(
              data: dataWidget,
              child: baseWidget,
              childWhenDragging: placeHolder,
              feedback: dataWidget,
            ),
            DragTarget<Widget>(
              onWillAccept: (Widget data) => true,
              onAccept: (data) {
                child = baseWidget;
                setState(() {});
              },
              builder: (context, candidateData, rejectedData) => child,
            )
          ],
        ),
      ),
    );
  }
}

class SampleShape extends StatelessWidget {
  const SampleShape({
    Key key,
    this.boxSize = 128,
    this.color = Colors.grey,
  }) : super(key: key);

  final double boxSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
