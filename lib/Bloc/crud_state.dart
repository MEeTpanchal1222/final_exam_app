part of 'crud_bloc.dart';

@immutable
sealed class CrudState {}

class UserLoaded extends CrudState {
  final List<Map<String, dynamic>> Users;

  UserLoaded(this.Users);
}





