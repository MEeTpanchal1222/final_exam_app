import 'package:final_exam_app/Bloc/crud_bloc.dart';
import 'package:final_exam_app/presentation/screens/home_screen.dart';
import 'package:final_exam_app/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signinscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication App')),
      body: BlocProvider(
        create: (context) => CrudBloc(),
        child: Signin(),
      ),

    );
  }
}

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();

    return BlocBuilder<CrudBloc, CrudState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.all(20.0.h),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(20.0.h),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 50.h),
                child: ElevatedButton(onPressed: () {
                  // try{
                  //   context.read<CrudBloc>().add(compareuser(name.text,email.text));
                  //   () ?
                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(),)): Fluttertoast.showToast(
                  //     msg: "Error: fill the signup form",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.BOTTOM,
                  //   );;
                  // } catch (e){
                  //   Fluttertoast.showToast(
                  //     msg: "Error: $e",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.BOTTOM,
                  //   );
                  // }

                  try {
                    context.read<CrudBloc>().add(compareuser(name.text, email.text));
                    if (state is UserLoaded) {
                      // Assuming `compareuser` modifies state to UserLoaded with results
                      if (state.Users.isNotEmpty) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Error: User not found. Please fill the sign-up form.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                        );
                      }
                    }
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Error: $e",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                  if (state is UserAuthenticated) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                  }

                }, child: Text('Signin')),
              ),
              TextButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signupscreen(),));
              }, child: Text('New to App signup'))
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}