import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class singleExam extends StatelessWidget {
  final String name;
  const singleExam({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          name,
          style: TextStyle(fontSize: width * 0.06),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: ListView(
        children: [
          SizedBox(
            height: width * 0.1,
          ),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Domande salvate',
                    style:
                        TextStyle(fontSize: width * 0.06, color: Colors.white),
                  ),
                  Container(
                    width: double.infinity,
                    height: width * 0.6,
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.normal),
                      scrollDirection: Axis.horizontal,
                      children: const [
                        SavedQuestions(),
                        SavedQuestions(),
                        SavedQuestions(),
                        SavedQuestions(),
                        SavedQuestions(),
                      ],
                    ),
                  )
                ],
              )),
          SizedBox(
            height: width * 0.1,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            alignment: Alignment.topLeft,
            child: Text(
              'Statistiche',
              style: TextStyle(fontSize: width * 0.06, color: Colors.white),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.transparent,
            ),
            height: width * 0.8,
            child: BarChart(
              BarChartData(
                  borderData: FlBorderData(
                      show: true,
                      border: const Border(
                          bottom: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ))),
                  backgroundColor: Colors.transparent,
                  gridData: const FlGridData(show: false),
                  barGroups: [
                    myRod(0, 18),
                    myRod(1, 15),
                    myRod(2, 25),
                    myRod(3, 19),
                    myRod(4, 2),
                    myRod(5, 30),
                  ]),
              swapAnimationDuration:
                  const Duration(milliseconds: 1500), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            height: width * 0.25,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Summary(
                  colore: Colors.red,
                  numero: 2,
                ),
                Summary(
                  colore: Colors.green,
                  numero: 4,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

BarChartGroupData myRod(int ascissa, double value) {
  return BarChartGroupData(x: ascissa, barRods: [
    BarChartRodData(
        fromY: 0,
        toY: value,
        width: 5,
        color: value.round() >= 18 ? Colors.green : Colors.red)
  ]);
}

class SavedQuestions extends StatelessWidget {
  const SavedQuestions({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
              padding: MaterialStatePropertyAll(EdgeInsets.all(width * 0.05)),
              fixedSize: MaterialStatePropertyAll(Size(
                width * 0.7,
                width * 0.1,
              )),
              backgroundColor: const MaterialStatePropertyAll(Colors.white)),
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: width * 0.47,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vulputate sem sit amet tincidunt sagittis. Nunc nec sapien lectus. Aliquam nisl nisi, varius eget volutpat vitae, maximus at nunc.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vulputate sem sit amet tincidunt sagittis. Nunc nec sapien lectus. Aliquam nisl nisi, varius eget volutpat vitae, maximus at nunc. ",
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: width * 0.05, color: Colors.black),
                ),
              )
            ],
          )),
    ));
  }
}

class Summary extends StatelessWidget {
  final Color colore;
  final int numero;
  const Summary({super.key, required this.colore, required this.numero});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (Container(
      width: width * 0.12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.05,
            decoration: BoxDecoration(color: colore, shape: BoxShape.circle),
          ),
          Text(numero.toString())
        ],
      ),
    ));
  }
}
