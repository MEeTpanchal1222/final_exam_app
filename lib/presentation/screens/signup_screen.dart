import 'package:final_exam_app/Bloc/crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signupscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication App')),
      body: BlocProvider(
        create: (context) => CrudBloc(),
        child: Signup(),
      ),

    );
  }
}

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();

    return BlocBuilder<CrudBloc, CrudState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              ElevatedButton(onPressed: () {
                context.read<CrudBloc>().add(Adduser(name.text,email.text));
              }, child: Text('Signup'))
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}