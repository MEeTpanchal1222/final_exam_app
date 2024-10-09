import 'package:final_exam_app/Bloc/crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication App')),
      body: BlocProvider(
        create: (context) => CrudBloc()..add(Loaduser()),
        child: UserList(),
      ),

    );
  }
}

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrudBloc, CrudState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return ListView.builder(
            itemCount: state.Users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.Users[index]['name'],style: TextStyle(color: Colors.blue),),
                subtitle: Text(state.Users[index]['email'],style: TextStyle(color: Colors.blue)),
                trailing: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context.read<CrudBloc>().add(Deleteuser(state.Users[index]['id']));
                      },
                    ),
                    SizedBox(width: 5.h,),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context.read<CrudBloc>().add((state.Users[index]['id']));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}