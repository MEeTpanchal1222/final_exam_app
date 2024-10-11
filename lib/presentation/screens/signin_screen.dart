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
        create: (context) => CrudBloc()..add(Loaduser()),
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
        if (state is UserAuthenticated) {
          // Navigate to HomeScreen when the user is authenticated
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
          });
        } else if (state is UserError) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
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
                  try {
                    context.read<CrudBloc>().add(compareuser(name.text, email.text));
                  } catch (e) {
                    if(e == 'Bad state:No element') {
                      Fluttertoast.showToast(
                        msg: "Error: No User found ,Go to Signup",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                  }

                }, child: Text('Signin')),
              ),
              TextButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signupscreen(),));
              }, child: Text('New to App signup'))
            ],
          );
      },
    );
  }
}