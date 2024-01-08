import '../../firestore.dart';

class Data {
  void incrementa() {
    if (true) {
      sessione['current'] += 1;
    }
  }

  Map sessione = {
    'current': 0,
    "id": 1,
    "nome": "Nicola",
    "risposte": <bool?>[
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    ],
    "domande": null
  };

  void cleanSession() {
    sessione['current'] = 0;
    for (int i = 0; i < 10; i++) {
      sessione['risposte'][i] = null;
    }
    if (sessione['domande'] != null) {
      sessione['domande'] = null;
    }
  }

  Future getSession() async {
    if (sessione['domande'] == null) {
      sessione['domande'] = await Database()
          .getData('diritto privato', 'contratti')
          .then((value) {
        if (value['domande'] != []) {
          return value['domande'];
        } else {
          return null;
        }
      });
    }
    for (int i = 0; i < 10; i++) {
      sessione['domande'][i]['risposte'].shuffle();
    }

    return sessione;
  }
}
