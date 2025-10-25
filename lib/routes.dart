import 'package:flutter/material.dart';
import 'package:name_badge/pages/set_information/set_information_page.dart';
import 'package:name_badge/pages/show_information/user_information_widget.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case UserInformationWidget.route:
      return MaterialPageRoute(
        builder: (_) => UserInformationWidget(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => SetInformationPage(),
        settings: settings,
      );
  }
}
