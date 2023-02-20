// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/common/widgets/loader.dart';
import 'package:whatsappclone/features/auth/controller/auth_controller.dart';
import 'package:whatsappclone/models/user_model.dart';

import '../../../colors.dart';
// import '../info.dart';
import '../widgets/chat_list.dart';
import '../widgets/bottom_chat_field.dart';

class MobileChatScreen extends ConsumerWidget {
  static const routeName = '/mobileChatScreen';
  final String name;
  final String uid;

  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: StreamBuilder<UserModel>(
              stream: ref.read(AuthControllerProvider).userDataById(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return Column(
                  children: [
                    Text(name),
                    Text(
                      snapshot.data!.isOnline ? 'online' : 'offline',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.normal),
                    ),
                  ],
                );
              }),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              recieverUserId: uid,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: BottomChatField(
              recieverUserId: uid,
            ),
          )
        ],
      ),
    );
  }
}
