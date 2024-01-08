import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osteriamadonna/src/pages/singleExam.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EsamiPage extends StatelessWidget {
  const EsamiPage({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);
    List<String> esami = [
      'Diritto privato',
      'Filosofia del diritto',
      'Procedura penale',
      'Procedura civile',
      'Procedura civile',
      'Procedura civile',
      'Procedura civile',
      'Procedura civile',
      'Procedura civile',
      'Procedura civile',
      'Procedura civile',
      'Procedura civile',
      'Procedura civile',
      'Procedura civile',
      'Procedura civile',
    ];

    return (Container(
      decoration: const BoxDecoration(),
      padding: EdgeInsets.symmetric(
          horizontal: device.size.width * 0.05,
          vertical: device.size.height * 0.0),
      child: ListView(
          children: esami
              .map(
                (e) => ExamButton(nome: e),
              )
              .toList()),
    ));
  }
}

class ExamButton extends StatelessWidget {
  final String nome;

  const ExamButton({super.key, required this.nome});
  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);

    return Column(
      children: [
        SizedBox(
          height: device.size.height * 0.04,
        ),
        ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                    horizontal: device.size.width * 0.05,
                    vertical: device.size.width * 0.04)),
                backgroundColor: const MaterialStatePropertyAll(Colors.white),
                elevation: const MaterialStatePropertyAll(10),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => singleExam(
                          name: nome,
                        )),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircularPercentIndicator(
                    progressColor: Colors.green,
                    radius: device.size.width / 100 * 8,
                    percent: 18 * 0.01 * 3.33,
                    animation: true,
                    lineWidth: device.size.width * 0.03,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      '18',
                      style: TextStyle(
                          fontSize: device.size.width * 0.05,
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    nome,
                    style: TextStyle(
                        fontSize: device.size.width * 0.05,
                        color: Colors.black),
                  ),
                ),
                Container(
                  child: const Icon(
                    CupertinoIcons.forward,
                    color: Colors.black,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
