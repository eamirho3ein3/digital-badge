import 'dart:math';

import 'package:flutter/material.dart';
import 'package:name_badge/models/user.dart';
import 'package:name_badge/pages/show_information/widgets/background_widget/background_widget.dart';
import 'package:name_badge/pages/show_information/widgets/photo_widget/photo_widget.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class UserInformationWidget extends StatelessWidget {
  static const String route = "/show_information";

  const UserInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: pi,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            StarsContainer(),

            Align(
              alignment: Alignment.bottomCenter,
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }

  _buildContent(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    late User user = args['user'];
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.77,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Animated dash gif
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/dash.gif',
              width: MediaQuery.of(context).size.width * 2,
              height: 260,
              fit: BoxFit.fitHeight,
            ),
          ),
          // Profile photo
          Positioned(
            top: -75,
            left: 0,
            right: 0,
            child: PhotoWidget(showAddPhoto: false, user: user),
          ),
          // User name & qr code
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // User name
                Text(
                  user.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 32),
                // QR Code
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: PrettyQrView.data(
                    data: user.linkedinUrl,
                    decoration: const PrettyQrDecoration(
                      quietZone: PrettyQrQuietZone.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
