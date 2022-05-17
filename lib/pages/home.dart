import 'package:flutter/material.dart';
import 'package:untitled/pages/details.dart';
import 'package:untitled/pages/loading.dart';

class Home extends StatefulWidget {
  Home({Key? key,Map? data}) : data=data,super(key: key);
  Map? data={};
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map data;
  @override
  void initState()
  {
    data=widget.data!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List l=data["message"]["body"]["track_list"];
    return Scaffold(
      appBar:AppBar(
        title: Text("Music"),
      ),
      body: ListView(
        children:[
          for(int i=0;i<l.length;i++)
            GestureDetector(
              onTap: (){
                int id=(l[i]["track"]["track_id"]);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Details(id:id)));
              },
                child: ListTile(
                    leading: Icon(Icons.music_note),
                    hoverColor: Colors.lightBlue,
                    trailing: Text("${l[i]["track"]["artist_name"]}"),
                    subtitle: Text("${l[i]["track"]["album_name"]}"),
                    title: Text("${l[i]["track"]["track_name"]}")
                )),
        ]
      )
    );
  }
}
