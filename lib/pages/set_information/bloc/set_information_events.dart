import 'package:equatable/equatable.dart';
import 'package:name_badge/models/user.dart';

class SetInformationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUser extends SetInformationEvent {}

class SelectPhoto extends SetInformationEvent {}

class SaveUser extends SetInformationEvent {
  final User user;
  SaveUser(this.user);
}

class Reset extends SetInformationEvent {}
