import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import './quiz.dart';
import 'esami.dart';
import 'imp.dart';

import '../utils/mysession.dart';

class Myhome extends StatelessWidget {
  const Myhome({super.key});

  @override
  Widget build(BuildContext context) {
    return (ListView(
      children: [
        const SizedBox(
          height: 50,
        ),
        const Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Showdata(
                  avg: 17,
                  best: 23,
                )),
            Exams(),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: const ButtonGroup(),
        ),
      ],
    ));
  }
}

class Showdata extends StatelessWidget {
  final int best;
  final int avg;

  const Showdata({super.key, required this.best, required this.avg});

  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);
    return (Container(
      height: device.size.height * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 50),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: device.size.width * 0.2,
                    child: CircularPercentIndicator(
                      progressColor: best >= 18
                          ? best < 30
                              ? Colors.green
                              : Colors.amber
                          : Colors.red,
                      radius: device.size.width / 100 * 13,
                      percent: best * 0.01 * 3.33,
                      animation: true,
                      lineWidth: device.size.width * 0.05,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        best.toString(),
                        style: TextStyle(fontSize: device.size.width * 0.1),
                      ),
                      footer: const Text(
                        'Best',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                      width: device.size.width * 0.2,
                      child: CircularPercentIndicator(
                        progressColor: avg >= 18 ? Colors.green : Colors.red,
                        radius: device.size.width / 100 * 13,
                        percent: 18 * 0.01 * 3.33,
                        animation: true,
                        lineWidth: device.size.width * 0.05,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          avg.toString(),
                          style: TextStyle(fontSize: device.size.width * 0.1),
                        ),
                        footer: const Text(
                          'Avg',
                          style: TextStyle(fontSize: 25),
                        ),
                      )),
                ],
              ))
        ],
      ),
    ));
  }
}

class Exams extends StatefulWidget {
  const Exams({super.key});

  @override
  State<Exams> createState() => _Exams();
}

class _Exams extends State<Exams> {
  int Currentexam = 0;
  final List<String> esami = [
    'Diritto privato',
    'Procedura civile',
    'Filosofia del diritto',
    'Procedura penale'
  ];

  @override
  Widget build(BuildContext context) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                Currentexam =
                    Currentexam == 0 ? esami.length - 1 : Currentexam - 1;
              });
            },
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
                backgroundColor: MaterialStatePropertyAll(Colors.deepOrange),
                shape: MaterialStatePropertyAll(CircleBorder())),
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
              size: 35,
            )),
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.deepOrangeAccent,
            ),
            height: 70,
            width: 230,
            child:
                Text(esami[Currentexam], style: const TextStyle(fontSize: 25))),
        ElevatedButton(
            onPressed: () {
              setState(() {
                Currentexam =
                    Currentexam == (esami.length - 1) ? 0 : Currentexam + 1;
              });
            },
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
                backgroundColor: MaterialStatePropertyAll(Colors.deepOrange),
                shape: MaterialStatePropertyAll(CircleBorder())),
            child: const Icon(
              CupertinoIcons.forward,
              color: Colors.white,
              size: 35,
            )),
      ],
    ));
  }
}

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            color: Colors.transparent,
            width: device.size.width / 2,
            child: ElevatedButton(
              onPressed: () {
                mySession.cleanSession();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Quizpage()),
                );
              },
              style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.deepPurple),
                  elevation: const MaterialStatePropertyAll(0),
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 20)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)))),
              child: Text(
                'Quiz',
                style: TextStyle(fontSize: device.size.width / 10),
              ),
            )),
        Container(
            color: Colors.transparent,
            width: device.size.width / 2 - 30,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.redAccent),
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 20)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)))),
              child: Text(
                'Esame',
                style: TextStyle(fontSize: device.size.width / 10),
              ),
            )),
      ],
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
            shadowColor: Colors.black,
            toolbarHeight: device.size.height * 0.12,
            backgroundColor: Colors.deepPurpleAccent,
            elevation: 6,
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: device.size.height * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(CircleBorder()),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        elevation: MaterialStatePropertyAll(0)),
                    child: Icon(
                      Icons.settings,
                      size: device.size.width * 0.07,
                      color: Colors.black,
                    ),
                  ),
                  Image(
                    alignment: Alignment.bottomCenter,
                    image: const AssetImage('assets/logo.png'),
                    width: device.size.width * 0.6,
                    height: device.size.height * 0.07,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(CircleBorder()),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        elevation: MaterialStatePropertyAll(0)),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.black,
                      size: device.size.width * 0.07,
                    ),
                  ),
                ],
              ),
            )),
        backgroundColor: Colors.deepPurpleAccent,
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(500)),
                color: Colors.transparent),
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavButton(
                      myindex: 0,
                      currentIndex: currIndex,
                      icona: const Icon(
                        Icons.home_rounded,
                        color: Colors.black,
                      ),
                      testo: 'Home',
                      state: () {
                        setState(() {
                          currIndex = 0;
                        });
                      }),
                  BottomNavButton(
                      myindex: 1,
                      currentIndex: currIndex,
                      icona: const Icon(
                        CupertinoIcons.book_fill,
                        color: Colors.black,
                      ),
                      testo: 'Esami',
                      state: () {
                        setState(() {
                          currIndex = 1;
                        });
                      }),
                  BottomNavButton(
                      myindex: 2,
                      currentIndex: currIndex,
                      icona: const Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.black,
                      ),
                      testo: 'Profilo',
                      state: () {
                        setState(() {
                          currIndex = 2;
                        });
                      })
                ],
              ),
            )),
        body: const <Widget>[
          Myhome(),
          EsamiPage(),
          ImpPage(),
        ][currIndex]);
  }
}

class BottomNavButton extends StatelessWidget {
  final Icon icona;
  final String testo;
  final int currentIndex;
  final Function state;
  final int myindex;

  const BottomNavButton(
      {super.key,
      required this.currentIndex,
      required this.icona,
      required this.testo,
      required this.state,
      required this.myindex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: currentIndex == myindex
            ? Colors.deepOrangeAccent
            : Colors.transparent,
      ),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0)),
          onPressed: () {
            state();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: icona,
              ),
              Visibility(
                  visible: currentIndex == myindex ? true : false,
                  child: Text(
                    testo,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ))
            ],
          )),
    );
  }
}
