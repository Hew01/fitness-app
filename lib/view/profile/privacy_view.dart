import 'package:flutter/material.dart';
import '../../common/colo_extension.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/black_btn.png",
            width: 25,
            height: 25,
          ),
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                "Information We Collect",
                "We collect information you provide directly to us, including: name, email address, physical characteristics (height, weight, age), and workout preferences.",
              ),
              _buildSection(
                "How We Use Your Information",
                "Your information helps us to:\n"
                "• Personalize your workout experience\n"
                "• Track your fitness progress\n"
                "• Send you relevant notifications\n"
                "• Improve our services",
              ),
              _buildSection(
                "Data Security",
                "We implement appropriate security measures to protect your personal information. However, no method of transmission over the internet is 100% secure.",
              ),
              _buildSection(
                "Third-Party Services",
                "We may use third-party services that collect, monitor and analyze this type of information in order to increase our Service's functionality.",
              ),
              _buildSection(
                "Your Rights",
                "You have the right to:\n"
                "• Access your personal data\n"
                "• Correct inaccurate data\n"
                "• Request data deletion\n"
                "• Opt-out of communications",
              ),
              _buildSection(
                "Your Rights",
                "You have the right to:\n"
                "• Access your personal data\n"
                "• Correct inaccurate data\n"
                "• Request data deletion\n"
                "• Opt-out of communications",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: TColor.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            color: TColor.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
