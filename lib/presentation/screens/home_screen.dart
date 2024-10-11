import 'package:final_exam_app/Bloc/crud_bloc.dart';
import 'package:final_exam_app/presentation/screens/favorite_screen.dart';
import 'package:final_exam_app/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_Dailogbox.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication App'),
      leading: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signupscreen(),));
        },
          child: Icon(Icons.logout_sharp)),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Favoritescreen(),));
              },
              child: Padding(
                padding:  EdgeInsets.only( right:20.h),
                child: Icon(Icons.bookmark),
              )),
        ],

      ),
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
          return ListView.separated(
            itemCount: state.Users.length,
            separatorBuilder: (context, index) => Divider(), // Adds a divider between items
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  state.Users[index]['name'],
                  style: TextStyle(color: Colors.blue),
                ),
                subtitle: Text(
                  state.Users[index]['email'],
                  style: TextStyle(color: Colors.blue),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min, // Minimize row size
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit), // Change to edit icon
                      onPressed: () {
                        //context.read<CrudBloc>().add(Updateuser(state.Users[index]['id'],state.Users[index]));
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return UpdateUserDialog(
                          userId: state.Users[index]['id'], // Pass the user ID
                          userData: state.Users[index],     // Pass existing user data
                        );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context.read<CrudBloc>().add(Deleteuser(state.Users[index]['id']));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        context.read<CrudBloc>().add(addfavoriteuser(state.Users[index]['name'],state.Users[index]['email']));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is UserError) { // Handle error state
          return Center(child: Text('Error loading users'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}


