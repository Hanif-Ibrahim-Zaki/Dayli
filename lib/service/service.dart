import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get currentUser => _auth.currentUser;
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (kDebugMode) {
        print("User: ${userCredential.user}");
      }
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print("User: ${userCredential.user}");
      }
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print("Signup error: $e");
        print(e);
      }
      return null;
    }
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();

    return userDoc.data() as Map<String, dynamic>;
  }

  Future<void> addTodo(String title, bool isImportant) async {
    String userId = _auth.currentUser!.uid;
    if (userId != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection('todo')
          .add({
        "title": title,
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
        'isImportant': isImportant
      });
    }
  }

  Stream<QuerySnapshot> getTodo() {
    String? userId = _auth.currentUser!.uid;
    if (userId != null) {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection('todo')
          .orderBy('createdAt', descending: true)
          .snapshots();
    }
    return Stream.empty();
  }

  Future<void> deleteTodo(String todoId) async {
    String userId = _auth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('todo')
        .doc(todoId)
        .delete();
  }

  Future<void> updateTodo(String todoId, String title, bool isImportant) async {
    String userId = _auth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('todo')
        .doc(todoId)
        .update(
      {
        'title' : title,
        'isImportant' : isImportant,
      }
    );
  }
}
