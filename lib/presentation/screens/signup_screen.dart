import 'package:final_exam_app/Bloc/crud_bloc.dart';
import 'package:final_exam_app/presentation/screens/home_screen.dart';
import 'package:final_exam_app/presentation/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                  try{
                    context.read<CrudBloc>().add(Adduser(name.text,email.text));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(),));
                  } catch (e){
                    Fluttertoast.showToast(
                      msg: "Error: $e",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }

                }, child: Text('Signup')),
              ),
              TextButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signinscreen(),));
              }, child: Text('Already in app Signin'))
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}