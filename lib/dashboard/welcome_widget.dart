// welcome_banner_widget.dart
import 'package:flutter/material.dart';

class WelcomeBannerWidget extends StatelessWidget {
  const WelcomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 32.0 : 16.0,
        vertical: isWeb ? 24.0 : 16.0,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: isWeb ? 16.0 : 8.0,
        vertical: isWeb ? 16.0 : 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image:  DecorationImage(
          image: AssetImage('assets/images/welcome.jpeg'), // Assume this is a dark blue wavy pattern image matching the screenshot
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Color(0xFF0A3A75).withOpacity(0.85), // Deep navy overlay
            BlendMode.srcATop, // Keeps wave pattern visible
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to the CEF Online Academy Ali Test 53',
            style: TextStyle(
              color: Colors.white,
              fontSize: isWeb ? 28.0 : 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Start Your Journey of Faith, Knowledge, and Character',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isWeb ? 18.0 : 14.0,
            ),
          ),
        ],
      ),
    );
  }
}