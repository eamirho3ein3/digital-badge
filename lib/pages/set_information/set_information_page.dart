import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:name_badge/models/user.dart';
import 'package:name_badge/pages/set_information/bloc/set_information_bloc.dart';
import 'package:name_badge/pages/show_information/widgets/background_widget/background_widget.dart';
import 'package:name_badge/pages/show_information/widgets/photo_widget/photo_widget.dart';
import 'package:name_badge/pages/show_information/user_information_widget.dart';

class SetInformationPage extends StatefulWidget {
  static const String route = "/set_information";

  const SetInformationPage({super.key});

  @override
  State<SetInformationPage> createState() => _SetInformationPageState();
}

class _SetInformationPageState extends State<SetInformationPage> {
  SetInformationBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SetInformationBloc>(
      create: (context) => SetInformationBloc(SetInformationRepository()),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(body: _manageState()),
      ),
    );
  }

  _manageState() {
    return BlocBuilder<SetInformationBloc, SetInformationState>(
      builder: (context, state) {
        _bloc = context.read<SetInformationBloc>();

        if (state is SetInformationUninitialized) {
          // initial the screen

          _bloc!.add(GetUser());
        } else if (state is SetInformationLoading) {
          // loading state
          return Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          );
        } else if (state is UserReady) {
          var result = state.getResult;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(
              context,
              UserInformationWidget.route,
              arguments: {'user': result},
            );
          });

          return Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          );
        } else if (state is ErrorState) {
          // get error
          return Center(
            child: Text(
              'Error: ${state.getResult}',
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }

        return _buildContent(context);
      },
    );
  }

  _buildContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        StarsContainer(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.77,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Profile photo
                Positioned(
                  top: -75,
                  left: 0,
                  right: 0,
                  child: PhotoWidget(showAddPhoto: true, bloc: _bloc),
                ),
                // User name
                Positioned(
                  top: 90,
                  left: 16,
                  right: 16,
                  child: Column(
                    children: [
                      // User name
                      TextFormField(
                        controller: _bloc?.nameController,
                        decoration: InputDecoration(
                          labelText: 'Enter your name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Linkedin
                      TextFormField(
                        controller: _bloc?.linkedinController,
                        decoration: InputDecoration(
                          labelText: 'Enter your Linkedin URL',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Confirm button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      _bloc!.add(
                        SaveUser(
                          User(
                            name: _bloc!.nameController.text,
                            linkedinUrl: _bloc!.linkedinController.text,
                            photo: _bloc!.selectedPhoto,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 32,
                        left: 16,
                        right: 16,
                      ),
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
