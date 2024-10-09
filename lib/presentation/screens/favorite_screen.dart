import 'package:final_exam_app/Bloc/crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favoritescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication App')),
      body: BlocProvider(
        create: (context) => CrudBloc(),
        child: FavoriteList(),
      ),

    );
  }
}

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();

    return BlocBuilder<CrudBloc, CrudState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Column(

          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}