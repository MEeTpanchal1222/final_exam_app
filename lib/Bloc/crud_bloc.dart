import 'package:bloc/bloc.dart';
import 'package:final_exam_app/data/helpers/sqfilte_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final SQLiteService _dbService = SQLiteService();
  final FirebaseFirestore  _favorite = FirebaseFirestore.instance;

  CrudBloc() : super(UserLoaded([])) {
    on<Loaduser>((event, emit) async {
      List<Map<String, dynamic>> users = await _dbService.getuser();
      emit(UserLoaded(users));
    });

    on<Adduser>((event, emit) async {
      await _dbService.adduser({'name': event.name, 'email': event.Email});
      List<Map<String, dynamic>> users = await _dbService.getuser();
      emit(UserLoaded(users));
    });

    on<Deleteuser>((event, emit) async {
      await _dbService.deleteuser(event.id);
      List<Map<String, dynamic>> users = await _dbService.getuser();
      emit(UserLoaded(users));
    });

    // on<Getfavoriteuser>((event, emit){
    //
    // });
    //
    // on<addfavoriteuser>((event, emit){
    //
    // });
    //
    // on<Deleatefavoriteuser>((event, emit){
    //
    // });

    // on<compareuser>((event, emit) async {
    //    await _dbService.compareuser(name: event.name,email: event.Email);
    //  List<Map<String, dynamic>> users = await _dbService.getuser();
    //  emit(UserLoaded(users));
    //
    // });
    on<compareuser>((event, emit) async {
      try {
        List<Map<String, dynamic>> users = await _dbService.getuser();
        // Check if a user with the same name and email exists
        final matchingUser = users.firstWhere(
              (user) => user['name'] == event.name && user['email'] == event.Email,
        );

        if (matchingUser != null) {
          emit(UserAuthenticated(matchingUser));
        } else {
          emit(UserLoaded(users));  // Keep the same state if no match found
        }
      } catch (e) {
        emit(UserError("Error: $e"));
      }
    });


    on<Getfavoriteuser>((event, emit) async {
      try {
        QuerySnapshot<Map<String, dynamic>> snapshot = await _favorite.collection('favorites').get();
        List<Map<String, dynamic>> favorites = snapshot.docs.map((doc) => doc.data()).toList();
        emit(UserLoaded(favorites));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<addfavoriteuser>((event, emit) async {
      try {
        await _favorite.collection('favorites').add({'name': event.name, 'email': event.email});
        List<Map<String, dynamic>> users = await _dbService.getuser();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<Deleatefavoriteuser>((event, emit) async {
      try {
        await _favorite.collection('favorites').doc(event.id).delete();
        List<Map<String, dynamic>> users = await _dbService.getuser();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}