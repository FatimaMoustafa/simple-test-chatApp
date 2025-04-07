import 'package:app_chat/constants/collections.dart';
import 'package:app_chat/constants/colors.dart';
import 'package:app_chat/constants/images.dart';
import 'package:app_chat/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
   ChatPage({super.key});

  static String id = "chatPage";
  final _controller = ScrollController();

   CollectionReference messages = FirebaseFirestore.instance.collection(MessagesCollections);
   TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("createdAt", descending: true).snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          List<MessageModel> messageList = [];
          for(int i =0; i < snapshot.data!.docs.length; i++){
            messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: PrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Logo,
                    height: 60,
                  ),
                  Text("chat", style: TextStyle(color: Colors.white, fontSize: 24),),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller:  _controller,
                    itemCount: messageList.length,
                      itemBuilder: (context, index){
                        return messageList[index].id == email?
                            ChatBubble(message: messageList[index]):
                            ChatBubbleForFriend(message: messageList[index]);
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data){
                      messages.add({
                        'message' : data,
                        'createdAt': DateTime.now(),
                        'id' : email
                      });
                      controller.clear();
                      _controller.animateTo(
                      0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn
                      );
                    },
                    decoration: InputDecoration(
                        hintText: "Send Message",
                        suffixIcon: Icon(
                          Icons.send,
                          color: PrimaryColor,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: PrimaryColor,
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: PrimaryColor,
                            )
                        )
                    ),
                  ),
                ),
              ],
            ),
          );
        }else{
          return Text("Loading...");
        }
      },
    );
  }
}
