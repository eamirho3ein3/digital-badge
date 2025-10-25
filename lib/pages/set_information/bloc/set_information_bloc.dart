import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:name_badge/models/user.dart';
import 'package:name_badge/pages/set_information/bloc/set_information_events.dart';
import 'package:name_badge/pages/set_information/bloc/set_information_repository.dart';
import 'package:name_badge/pages/set_information/bloc/set_information_states.dart';

export 'package:name_badge/pages/set_information/bloc/set_information_repository.dart';
export 'package:name_badge/pages/set_information/bloc/set_information_events.dart';
export 'package:name_badge/pages/set_information/bloc/set_information_states.dart';

class SetInformationBloc
    extends Bloc<SetInformationEvent, SetInformationState> {
  bool isLoading = false;
  bool isSearching = false;
  bool haveMoreData = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  String selectedPhoto = '';

  User? user;

  final SetInformationRepository setInformationRepository;
  SetInformationBloc(this.setInformationRepository)
    : super(SetInformationUninitialized()) {
    on<GetUser>(_onGetUser);
    on<SelectPhoto>(_onSelectPhoto);
    on<SaveUser>(_onSaveUser);
    on<Reset>(_onReset);
  }

  void _onGetUser(GetUser event, Emitter<SetInformationState> emit) async {
    emit(SetInformationLoading());

    try {
      var result = await setInformationRepository.getUser();
      if (result != null) {
        user = result;
        emit(UserReady(result));
      } else {
        emit(NoData());
      }
    } catch (err) {
      print("Error in GetUser = $err");
      emit(ErrorState(err.toString()));
    }
  }

  void _onSaveUser(SaveUser event, Emitter<SetInformationState> emit) async {
    emit(SetInformationLoading());

    try {
      await setInformationRepository.saveUser(event.user);
      emit(UserReady(event.user));
    } catch (err) {
      print("Error in SaveUser = $err");
      emit(ErrorState(err.toString()));
    }
  }

  void _onSelectPhoto(
    SelectPhoto event,
    Emitter<SetInformationState> emit,
  ) async {
    emit(SetInformationReset());

    try {
      final response = await setInformationRepository.getImage();
      if (response != null) {
        selectedPhoto = response.path;
      }
      emit(PhotoSelected());
    } catch (err) {
      print("Error in SelectPhoto = $err");
      emit(ErrorState(err.toString()));
    }
  }

  void _onReset(Reset event, Emitter<SetInformationState> emit) async {
    emit(SetInformationReset());
  }
}
