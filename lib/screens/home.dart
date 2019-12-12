import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Home extends StatelessWidget {
  IO.Socket socket = IO.io('http://172.16.42.142:3030/', <String, dynamic>{
    'transports': ['websocket'],
  });
    
  @override
  Widget build(BuildContext context) {
    socket.on("find", (ca){
      print(ca);
    });
    socket.emit("find messages", "");
    print(socket.connected);
    return Scaffold(
      appBar: AppBar(title: Text("LabControl"), centerTitle: true,),
      body: Container(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                MaterialButton(
                  color: Colors.blue,
                  child: Text("Login"),
                  onPressed: () {
                    print(socket.connected);
                    socket.emit("find messages", "");
                  },
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}