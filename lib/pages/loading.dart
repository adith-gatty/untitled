import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/bloc.dart';
import 'package:untitled/bloc/event.dart';
import 'package:untitled/bloc/state.dart';
import 'package:untitled/pages/home.dart';
import 'package:untitled/services/api.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}
Future<Map> load() async
{

  Map m= await Api().fetchDataA();
  print(m.toString());
  return m;
}
class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context)=>NetworkBloc()..add(ListenConnection()),
        child: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            if (state is ConnectionFailure) return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'NO INTERNET CONNECTION',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
              ),
            );
            if (state is ConnectionSuccess) {

              return FutureBuilder(
              future: load(),
    builder: (context,snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
            child: CircularProgressIndicator());
      }
      else if (snapshot.hasError) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Text(
              '${snapshot.error}',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
          ),
        );
      }
      return(Home(data: snapshot.data as Map));
    }
              );
            } else
              return Text("");
          },
        ),
      )
    );


  }
}
