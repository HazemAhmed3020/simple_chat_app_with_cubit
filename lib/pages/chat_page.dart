import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_app/constants.dart';
import 'package:scholar_chat_app/models/message_model.dart';
import 'package:scholar_chat_app/pages/cubits/chat/chat_cubit.dart';
import 'package:scholar_chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  static const route = '/ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // final Stream<QuerySnapshot> messages = FirebaseFirestore.instance
  //     .collection('messages')
  //     .snapshots();

  CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );
  final controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments.toString();
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/scholar.png',
                width: 50,
                height: 50,
              ),
              const Text(
                'Chat',
                style: TextStyle(
                  color: vPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  List<Messages> messageList = [];
                  messageList = BlocProvider.of<ChatCubit>(context).messageList;
                  return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBubble(txt: messageList[index].message)
                          : ChatBubbleForAnotherUser(
                        txt: messageList[index].message,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                onSubmitted: (data) {
                  BlocProvider.of<ChatCubit>(context).senMessages(email: email, message: data);
                  controller.clear();
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                  hintText: 'Send Message',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// WidgetsBinding.instance.addPostFrameCallback((_) {
// if (_controller.hasClients) {
// _controller.animateTo(
// 0.0,
// duration: const Duration(milliseconds: 300),
// curve: Curves.easeOut,
// );
// }
// });