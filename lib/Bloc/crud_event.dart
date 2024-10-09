part of 'crud_bloc.dart';

@immutable
sealed class CrudEvent {}

class Loaduser extends CrudEvent {}

class Adduser extends CrudEvent {
  final String name;
  final String Email;

  Adduser(this.name, this.Email);
}
class compareuser extends CrudEvent {
  final String name;
  final String Email;

  compareuser(this.name, this.Email);
}

class Deleteuser extends CrudEvent {
  final int id;
  Deleteuser(this.id);
}

class Getfavoriteuser extends CrudEvent {
  Getfavoriteuser();
}

class addfavoriteuser extends CrudEvent {
  final String name;
  final String email;
  addfavoriteuser(this.name, this.email);
}

class Deleatefavoriteuser extends CrudEvent {
  final String id;
  Deleatefavoriteuser(this.id);
}
