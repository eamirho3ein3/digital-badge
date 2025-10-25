import 'package:equatable/equatable.dart';
import 'package:name_badge/models/user.dart';

class SetInformationState extends Equatable {
  @override
  List<Object> get props => [];
}

class SetInformationUninitialized extends SetInformationState {}

class SetInformationLoading extends SetInformationState {}

class SelectPhotoLoading extends SetInformationState {}

class UserReady extends SetInformationState {
  final User user;
  UserReady(this.user);
  User get getResult => user;
}

class NoData extends SetInformationState {}

class ErrorState extends SetInformationState {
  final String error;
  ErrorState(this.error);
  String get getResult => error;
}

class PhotoSelected extends SetInformationState {}

class SetInformationReset extends SetInformationState {}
