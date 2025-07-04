import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/speech_controller.dart';
import '../widgets/tts_tab_widget.dart';
import '../widgets/stt_tab_widget.dart';
import '../widgets/custom_app_bar.dart';

class SpeechHomeScreen extends StatelessWidget {
  final SpeechController controller = Get.find<SpeechController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: Obx(() => IndexedStack(
                index: controller.currentTabIndex,
                children: [
                  TTSTabWidget(),
                  STTTabWidget(),
                ],
              )),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentTabIndex,
        onTap: controller.setTabIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedItemColor: Theme.of(Get.context!).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.record_voice_over),
            label: 'Text to Speech',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Speech to Text',
          ),
        ],
      )),
    );
  }
}
