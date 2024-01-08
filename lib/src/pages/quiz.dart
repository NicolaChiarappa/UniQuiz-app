import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osteriamadonna/src/pages/home.dart';
import 'package:osteriamadonna/src/utils/mysession.dart';

class Quizpage extends StatefulWidget {
  const Quizpage({
    super.key,
  });

  @override
  State<Quizpage> createState() => _Quizpage();
}

class _Quizpage extends State<Quizpage> {
  @override
  Widget build(BuildContext context) {
    if (mySession.sessione['domande'] != null) {
      return Page();
    } else {
      return FutureBuilder(
          future: mySession.getSession(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Page();
            } else {
              return const Center(
                child: Text('Loading...'),
              );
            }
          });
    }
  }
}

class AnswerButton extends StatefulWidget {
  final String answertext;
  final bool correct;
  final bool risposto;
  final Function funzione;
  final Map sessione;
  final int current;
  const AnswerButton({
    super.key,
    required this.answertext,
    required this.correct,
    required this.risposto,
    required this.funzione,
    required this.sessione,
    required this.current,
  });

  @override
  State<AnswerButton> createState() => _AnswerButton();
}

class _AnswerButton extends State<AnswerButton> {
  bool cliccato = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (Column(
      children: [
        SizedBox(
          height: width * 0.07,
        ),
        OutlinedButton(
          style: ButtonStyle(
              minimumSize: MaterialStatePropertyAll(Size(width, width * 0.1)),
              elevation: const MaterialStatePropertyAll(2),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: width * 0.02)),
              backgroundColor: MaterialStatePropertyAll(widget.risposto == false
                  ? Colors.white
                  : cliccato == true
                      ? (widget.correct == true
                          ? Colors.lightGreen
                          : Colors.red)
                      : Colors.grey)),
          onPressed: widget.risposto == true
              ? null
              : () {
                  widget.correct == true
                      ? {widget.sessione['risposte'][widget.current] = true}
                      : {widget.sessione['risposte'][widget.current] = false};

                  setState(() {
                    cliccato = true;
                  });

                  widget.funzione();

                  Future.delayed(const Duration(milliseconds: 1500), () {
                    mySession.incrementa();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => widget.sessione['current'] == 10
                              ? const MainPage()
                              : const Quizpage()),
                      (Route<dynamic> route) => false,
                    );
                  });
                },
          child: Text(
            widget.answertext,
            style: TextStyle(
                fontSize: width * 0.045,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        )
      ],
    ));
  }
}

class ButtonGroup extends StatefulWidget {
  final Function funzione;
  final List risposte;
  final Map sessione;
  final int current;

  const ButtonGroup({
    super.key,
    required this.funzione,
    required this.risposte,
    required this.sessione,
    required this.current,
  });
  @override
  State<ButtonGroup> createState() => _ButtonGroup();
}

class _ButtonGroup extends State<ButtonGroup> {
  bool rispostogroup = false;
  @override
  Widget build(BuildContext context) {
    return (Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.risposte
            .map((e) => AnswerButton(
                  current: widget.current,
                  sessione: widget.sessione,
                  answertext: e['testo'],
                  correct: e['corretta'],
                  risposto: rispostogroup,
                  funzione: () {
                    setState(() {
                      rispostogroup = true;
                    });
                    widget.funzione();
                  },
                ))
            .toList()));
  }
}

class CorrectIndicator extends StatefulWidget {
  final IconData icona;
  final Color colore;
  const CorrectIndicator(
      {super.key, required this.colore, required this.icona});
  @override
  State<CorrectIndicator> createState() => _CorrectIndicator();
}

class _CorrectIndicator extends State<CorrectIndicator> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return (Container(
      padding: const EdgeInsets.all(2),
      height: width * 0.1,
      decoration: BoxDecoration(shape: BoxShape.circle, color: widget.colore),
      child: Icon(
        color: Colors.white,
        widget.icona,
        size: width * 0.06,
      ),
    ));
  }
}

class Page extends StatefulWidget {
  const Page({super.key});
  @override
  State<Page> createState() => _Page();
}

class _Page extends State<Page> {
  Color colore = Colors.orangeAccent;
  bool risposto = false;

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 2,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.bookmark),
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            ),
            SizedBox(
              width: width * 0.5,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.transparent),
                    elevation: MaterialStatePropertyAll(0)),
                onPressed: risposto == true
                    ? null
                    : () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            title: const Text(
                              'Sei sicuro?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                                'Perderai tutti i dati di questa sessione di gioco'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Resta'),
                                child: const Text('Annulla'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const MainPage()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: const Text(
                                  'Si',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                child: Row(
                  children: [
                    Text(
                      'Esci',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05,
                          color: Colors.redAccent),
                    ),
                    Icon(
                      Icons.exit_to_app_rounded,
                      size: width * 0.08,
                      color: Colors.redAccent,
                    ),
                  ],
                )),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent,
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.deepPurpleAccent, Colors.black38])),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: width * 0.02),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: mySession.sessione['risposte']
                          .map<Widget>(
                            (e) => CorrectIndicator(
                                colore: e == null
                                    ? Colors.orange
                                    : e == false
                                        ? Colors.red
                                        : Colors.green,
                                icona: e == null
                                    ? Icons.remove
                                    : e == false
                                        ? Icons.close
                                        : Icons.done),
                          )
                          .toList()),
                ),
                SizedBox(
                  height: width * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: width * 0.02),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: width * 0.07),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white),
                    child: Text(
                      mySession.sessione['domande']
                          [mySession.sessione['current']]['testo'],
                      style: TextStyle(fontSize: width * 0.045),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.05, right: width * 0.05, top: width * 0),
                  child: ButtonGroup(
                    current: mySession.sessione['current'],
                    sessione: mySession.sessione,
                    risposte: mySession.sessione['domande']
                        [mySession.sessione['current']]['risposte'],
                    funzione: () {
                      setState(() {
                        risposto = true;
                        if (mySession.sessione['risposte']
                                [mySession.sessione['current']] ==
                            true) {
                          colore = Colors.green;
                        } else {
                          colore = Colors.red;
                        }
                      });
                    },
                  ),
                )
              ],
            )));
  }
}
