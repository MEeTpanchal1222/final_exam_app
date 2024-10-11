import 'package:final_exam_app/Bloc/crud_bloc.dart';
import 'package:final_exam_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserDialog extends StatelessWidget {
  final int userId; // The user ID you want to update
  final Map<String, dynamic> userData; // Existing user data

  UpdateUserDialog({required this.userId, required this.userData});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: userData['name']);
    final TextEditingController emailController = TextEditingController(text: userData['email']);

    return
      AlertDialog(
      title: Text('Update User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog box
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Collect updated user data
            final updatedUser = {
              'name': nameController.text,
              'email': emailController.text,
              // Add other user properties if needed
            };

            // Dispatch the Updateuser event with the new data
            context.read<CrudBloc>().add(Updateuser(userId, updatedUser));

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(),)); // Close the dialog box after updating
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
