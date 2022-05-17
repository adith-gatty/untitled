import 'package:flutter/material.dart';
import 'package:untitled/services/api.dart';

class Details extends StatefulWidget {
  Details({Key? key,int? id}) :id=id, super(key: key);
  int? id=0;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late int id;
  void initState()
  {
    id=widget.id!;
    super.initState();
  }
  Future<Map> load(id) async
  {
    Map m1= await Api().fetchDataB(id);
    Map m2= await Api().fetchDataC(id);
    Map m= m1["message"]["body"];
    m["lyrics"]=m2["message"]["body"]["lyrics"];
    print(m2);
    return(m);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Details")),
      body: FutureBuilder(
        future: load(id),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(
                child: CircularProgressIndicator());
          }
          else if(snapshot.hasError)
          {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'NO INTERNET CONNECTION',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            );
          }
          Map m=(snapshot.data as Map)["track"];
          return Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Text("Track Name",style:TextStyle(fontWeight: FontWeight.bold)),
                Text("${m["track_name"]}"),
                SizedBox(height:10),
                Text("Album Name",style:TextStyle(fontWeight: FontWeight.bold)),

                Text("${m["album_name"]}"),
                SizedBox(height:10),
                Text("Artist Name",style:TextStyle(fontWeight: FontWeight.bold)),
                Text("${m["artist_name"]}"),
                SizedBox(height:10),
                Text("Track Rating",style:TextStyle(fontWeight: FontWeight.bold)),
                Text("${m["track_rating"]}"),
                SizedBox(height:10),
                Text("Lyrics",style:TextStyle(fontWeight: FontWeight.bold)),

                (Text("${(snapshot.data as Map)["lyrics"]["lyrics_body"]}")),
              ],
            ),
          );
        }
      ),
    );
  }
}
