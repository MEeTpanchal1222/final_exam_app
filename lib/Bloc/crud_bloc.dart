import 'package:bloc/bloc.dart';
import 'package:final_exam_app/data/helpers/sqfilte_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    on<Getfavoriteuser>((event, emit){

    });

    on<addfavoriteuser>((event, emit){

    });

    on<Deleatefavoriteuser>((event, emit){

    });

    on<compareuser>((event, emit) async {
     try{
       await _dbService.compareuser(name: event.name,email: event.Email);
     List<Map<String, dynamic>> users = await _dbService.getuser();
     emit(UserLoaded(users));
     }  catch (e) {

     }

    });
  }
}