import 'package:final_exam_app/Bloc/crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favoritescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Users')),
      body: BlocProvider(
        create: (context) => CrudBloc()..add(Getfavoriteuser()),
        child: FavoriteList(),
      ),

    );
  }
}

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrudBloc, CrudState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          final users = state.Users;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final String docId = user['id'].toString();

              return ListTile(
                title: Text(user['name'] ?? 'No Name'),  // Display user name
                subtitle: Text(user['email'] ?? 'No Email'),  // Display user email or other data
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {

                    context.read<CrudBloc>().add(Deleatefavoriteuser(docId.toString()));
                  },
                ),
              );
            },
          );
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.error}'));
        }

        // Show loading spinner while fetching data
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
