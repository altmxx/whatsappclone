// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/common/utils/utils.dart';
import 'package:whatsappclone/features/chat/screens/mobile_chat_screen.dart';
import '../../../models/user_model.dart';

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      log(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll(' ', '');
        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(context, MobileChatScreen.routeName, arguments: {
            'name': userData.name,
            'uid': userData.uid,
          });
        }
      }
      if (!isFound) {
        showSnackBar(
            context: context, message: 'This number does not exist on the app');
      }
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
    }
  }
}
