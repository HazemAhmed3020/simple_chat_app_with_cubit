import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Messages> messageList = [];
  CollectionReference messages = FirebaseFirestore.instance.collection('messages',);
  void senMessages({required String email , required String message}){
    messages.add({
      'message': message,
      'id': email,
      'time': DateTime.now(),
    });

  }
  void showMessages(){
    messages.orderBy('time', descending: true).snapshots().listen((value){
      messageList.add(Messages.fromJson(value.docs));

    });
    emit(ChatSuccess(messageList: messageList));
  }



}
