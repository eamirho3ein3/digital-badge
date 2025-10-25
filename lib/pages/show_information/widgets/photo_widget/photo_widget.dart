import 'dart:io';

import 'package:flutter/material.dart';
import 'package:name_badge/models/user.dart';
import 'package:name_badge/pages/set_information/bloc/set_information_bloc.dart';

class PhotoWidget extends StatelessWidget {
  final bool showAddPhoto;
  final User? user;
  final SetInformationBloc? bloc;
  const PhotoWidget({
    super.key,
    required this.showAddPhoto,
    this.bloc,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showAddPhoto
          ? () {
              bloc!.add(SelectPhoto());
            }
          : null,
      child: Container(
        width: 150,
        height: 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: !showAddPhoto ? Colors.white : Color(0xff180026),
            width: 4,
          ),
          color: Colors.white,
          image: _getImage(),
        ),
        child: (showAddPhoto && (bloc != null && bloc!.selectedPhoto.isEmpty))
            ? Center(child: Icon(Icons.add, size: 40, color: Colors.grey))
            : const SizedBox(),
      ),
    );
  }

  DecorationImage? _getImage() {
    if (showAddPhoto && bloc!.selectedPhoto.isEmpty) {
      return null;
    }
    if (bloc != null && bloc!.selectedPhoto.isNotEmpty) {
      return DecorationImage(
        image: FileImage(File(bloc!.selectedPhoto)),
        fit: BoxFit.contain,
      );
    } else if (user != null && user!.photo.isNotEmpty) {
      return DecorationImage(
        image: FileImage(File(user!.photo)),
        fit: BoxFit.contain,
      );
    } else {
      return DecorationImage(
        image: AssetImage('assets/user.png'),
        fit: BoxFit.contain,
      );
    }
  }
}
