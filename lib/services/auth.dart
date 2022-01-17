import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  late FirebaseAuth auth;

  Auth({required this.auth});

  // checks for auth changes
  Stream<User?> get user => auth.authStateChanges();

  // creates user
  Future<String?> createUser(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  // signs in user
  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }

  // signs out user
  Future<String?> signOut() async {
    try {
      await auth.signOut();
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
  }
}
