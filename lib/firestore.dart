import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final db = FirebaseFirestore.instance;

  Future getData(esame, argomento) async {
    final docRef = db
        .collection('esami')
        .doc(esame)
        .collection('argomenti')
        .doc(argomento);
    final data = docRef.get().then((doc) {
      final data = doc.data() as Map<String, dynamic>;

      return data;
    }, onError: (e) => print('ciao'));
    return data;
  }
}
