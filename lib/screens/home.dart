import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Home extends StatelessWidget {
  final socket = IO.io('http://172.16.42.142:3030/', <String, dynamic>{
    'transports': ['websocket'],
    // 'extraHeaders': {'foo': 'bar'} // optional
  });
    
  @override
  Widget build(BuildContext context) {
    socket.connect();
    socket.on("connect", (_) {
      socket.on("messages created", (msg)=>print(msg));
    });

    return Scaffold(
      appBar: AppBar(title: Text("Testing"), centerTitle: true,),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    color: Colors.blue,
                    child: Text("Find"),
                    onPressed: () {
                      socket.emitWithAck("find", ["messages"], ack: (a){
                        print(a);
                      });
                    },
                  ),
                  MaterialButton(
                    color: Colors.purple,
                    child: Text("Create"),
                    onPressed: (){                   
                      socket.emitWithAck("create", ["messages", {"text": "nossa"}], ack: (a){
                        print(a);
                      });
                    },
                  ),
                  MaterialButton(
                    color: Colors.green,
                    child: Text("onCreated"),
                    onPressed: (){
                      socket.on("messages created", (msg)=>print(msg));
                    },
                  ),
                  MaterialButton(
                    color: Colors.red,
                    child: Text("onRemoved"),
                    onPressed: (){
                      socket.on("messages removed", (msg)=>print(msg));
                    },
                  )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}