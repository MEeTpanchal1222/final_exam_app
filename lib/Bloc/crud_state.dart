part of 'crud_bloc.dart';

@immutable
sealed class CrudState {}

class UserLoaded extends CrudState {
  final List<Map<String, dynamic>> Users;

  UserLoaded(this.Users);
}

class UserError extends CrudState {
  final String error;

  UserError(this.error);
}
class UserAuthenticated extends CrudState {
  final Map<String, dynamic> user;
  UserAuthenticated(this.user);
}



