import 'package:flutter/material.dart';

import 'el_tooltip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = 'Temporary Coverage';
  String subTitle =
      'For specific details about this coverage, please contact your agent';
  ScrollController controller = ScrollController();
  ElTooltip? eltoolTipVar;


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: NotificationListener<ScrollNotification>(
            onNotification: (val) {
              print(controller.position.pixels);
              if (controller.position.pixels == controller.position.minScrollExtent) {
                eltoolTipVar!.elToolTipState?.hideOverlay();
              }
              return true;
              },
              // Return true to cancel the notification bubbling. Return false (or null) to
              // allow the notification to continue to be dispatched to further ancestors.
              //return true;
            child: ListView.builder(
              controller: controller,
              itemBuilder: (context, int) {
                return buildInfo(context);
              },
              itemCount: 20,
            ),
          )),
    );
  }

  buildInfo(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildElToolTip(context,longTailPosition: "Left"),
              buildElToolTip(context, position: ElTooltipPosition.bottomCenter),
              buildElToolTip(context,
                  position: ElTooltipPosition.bottomEnd,
                  longTailPosition: 'Right'),

            ],
          ),
        ),
        const SizedBox(height: 300),
      ],
    );
  }


  buildElToolTip(context,{position, longTailPosition}) {

    return eltoolTipVar =  ElTooltip(
      distance: 30,
      // showModal: false,
      longTailPosition: longTailPosition ?? 'Center',
      position: position ?? ElTooltipPosition.bottomStart,
      content: SizedBox(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(subTitle),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                     // Navigator.pop(context);
                      eltoolTipVar!.elToolTipState?.hideOverlay();
                    },
                    child: const Text('Got it',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue))))
          ],
        ),
      ),
      child: const Icon(Icons.info),
      // position: ElTooltipPosition.bottomStart,
    );
  }
}
