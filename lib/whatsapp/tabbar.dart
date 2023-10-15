import 'package:all_implementations/whatsapp/status.dart';
import 'package:all_implementations/whatsapp/tabs/chat3.dart';
import 'package:flutter/material.dart';


import 'Groupchat.dart';



class TabbarScreen extends StatefulWidget {
  const TabbarScreen({super.key});

  @override
  State<TabbarScreen> createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen>with SingleTickerProviderStateMixin{
  TabController? controller;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    controller=TabController(length: 3, vsync: this, initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,

      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Whatsapp",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 17,color: Colors.white),),
        actions: [
          Icon(Icons.search),
          Icon(Icons.camera_alt_outlined),

          InkWell(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
              },
              child: Icon(Icons.more_vert_rounded)),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: [
            Text("Chats"),
            Text("Groups"),
            Text("STatus"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          Chats(),
          Groupschats(),
          Status()

        ],
      ),
    );
  }
}
