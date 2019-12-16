import 'package:flutter/material.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class Home extends StatelessWidget {
  SocketIOManager manager = SocketIOManager();
  SocketIO socket;
    
  @override
  Widget build(BuildContext context) {
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
                  onPressed: () async {
                    socket = await manager.createInstance(SocketOptions("http://172.16.42.142:3030/"));
                    socket.connect();
                    socket.onConnect((data) async {
                      var result = await socket.emitWithAck("find", ["messages"]);
                      print(result);
                      print(await socket.isConnected());
                      socket.on("messages created", (event){
                        print(event);
                      });
                    });
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