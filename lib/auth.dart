import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String getDisplayName() {
    String? displayname = currentUser?.displayName;
    if (displayname == null) {
      return '';
    } else {
      return '@$displayname';
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String nickname}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await currentUser?.updateDisplayName(nickname);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> checkIfEmailInUse(String? emailAddress) async {
    if (emailAddress == null) {
      emailAddress = '';
    }
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (error) {
      // Handle error
      // ...
      return true;
    }
  }
}
