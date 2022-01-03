import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _bodyUI(size),
    );
  }

  Widget _bodyUI(Size size)=>Center(
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('LiveSerial').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                return Column(
                  children: [
                    Container(
                      height:size.height,
                      width: size.width,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: doc['is_live']
                          ?Text(doc['serial_number'].toString(),
                          style: TextStyle(color: Color(0xff004865),fontSize: size.height*.65,fontWeight: FontWeight.bold))
                          :Text('লাইভ বন্ধ',
                          style: TextStyle(color: Colors.red,fontSize: size.height*.35,fontWeight: FontWeight.bold)),
                    ),
                  ],
                );
              });
        } else {
          return Container(
            height:size.height,
            width: size.width,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text('Loading...',style: TextStyle(color: Color(0xff004865),fontSize: size.height*.3)),
          );
        }
      },
    ),
  );
}
