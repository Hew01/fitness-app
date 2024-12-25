import 'package:flutter/material.dart';
import '../../common/colo_extension.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool notificationEnabled = true;
  bool darkMode = false;
  String selectedLanguage = 'English';
  double soundVolume = 0.8;

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
          "Settings",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                "General Settings",
                [
                  _buildToggleRow(
                    "Notifications",
                    "assets/img/p_notification.png",
                    notificationEnabled,
                    (value) => setState(() => notificationEnabled = value),
                  ),
                  _buildToggleRow(
                    "Dark Mode",
                    "assets/img/p_setting.png",
                    darkMode,
                    (value) => setState(() => darkMode = value),
                  ),
                ],
              ),
              // const SizedBox(height: 25),
              // _buildSection(
              //   "App Settings",
              //   [
              //     _buildLanguageSelector(),
              //     _buildVolumeSlider(),
              //   ],
              // ),
              const SizedBox(height: 25),
              _buildSection(
                "About",
                [
                  // _buildInfoRow("Version", "1.0.0"),
                  _buildInfoRow("Terms of Service", showArrow: true),
                  _buildInfoRow("Privacy Policy", showArrow: true),
                  _buildInfoRow("Licenses", showArrow: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Column(
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
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildToggleRow(
      String title, String iconPath, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.1),
      child: Row(
        children: [
          Image.asset(iconPath, height: 20, width: 20, fit: BoxFit.contain),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: TColor.black,
                fontSize: 14,
              ),
            ),
          ),
          CustomAnimatedToggleSwitch<bool>(
            current: value,
            values: [false, true],
            dif: 0.0,
            indicatorSize: const Size.square(30.0),
            animationDuration: const Duration(milliseconds: 200),
            animationCurve: Curves.linear,
            onChanged: onChanged,
            iconBuilder: (context, local, global) => const SizedBox(),
            defaultCursor: SystemMouseCursors.click,
            onTap: () => onChanged(!value),
            iconsTappable: false,
            wrapperBuilder: (context, global, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 10.0,
                    right: 10.0,
                    height: 30.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: value
                            ? LinearGradient(colors: TColor.secondaryG)
                            : LinearGradient(colors: [
                                Colors.grey,
                                Colors.grey
                              ]), // Change to grey when toggle is off
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                      ),
                    ),
                  ),
                  child,
                ],
              );
            },
            foregroundIndicatorBuilder: (context, global) {
              return SizedBox.fromSize(
                size: const Size(10, 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: TColor.white, // Change to grey when toggle is off
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 0.05,
                        blurRadius: 1.1,
                        offset: Offset(0.0, 0.8),
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  // Widget _buildLanguageSelector() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       children: [
  //         Image.asset("assets/img/p_setting.png",
  //             height: 20, width: 20, fit: BoxFit.contain),
  //         const SizedBox(width: 15),
  //         Expanded(
  //           child: Text(
  //             "Language",
  //             style: TextStyle(
  //               color: TColor.black,
  //               fontSize: 14,
  //             ),
  //           ),
  //         ),
  //         DropdownButton<String>(
  //           value: selectedLanguage,
  //           items: ["English", "Spanish", "French", "German"]
  //               .map((String value) => DropdownMenuItem<String>(
  //                     value: value,
  //                     child: Text(
  //                       value,
  //                       style: TextStyle(
  //                         color: TColor.gray,
  //                         fontSize: 14,
  //                       ),
  //                     ),
  //                   ))
  //               .toList(),
  //           onChanged: (newValue) {
  //             if (newValue != null) {
  //               setState(() => selectedLanguage = newValue);
  //             }
  //           },
  //           underline: const SizedBox(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildVolumeSlider() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       children: [
  //         Image.asset("assets/img/p_setting.png",
  //             height: 20, width: 20, fit: BoxFit.contain),
  //         const SizedBox(width: 15),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "Sound Volume",
  //                 style: TextStyle(
  //                   color: TColor.black,
  //                   fontSize: 14,
  //                 ),
  //               ),
  //               Slider(
  //                 value: soundVolume,
  //                 onChanged: (value) => setState(() => soundVolume = value),
  //                 activeColor: TColor.primaryColor1,
  //                 inactiveColor: TColor.gray.withOpacity(0.3),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildInfoRow(String title, {String? value, bool showArrow = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset("assets/img/p_setting.png",
              height: 20, width: 20, fit: BoxFit.contain),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: TColor.black,
                fontSize: 14,
              ),
            ),
          ),
          if (value != null)
            Text(
              value,
              style: TextStyle(
                color: TColor.gray,
                fontSize: 14,
              ),
            ),
          if (showArrow)
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: TColor.gray,
            ),
        ],
      ),
    );
  }
}
