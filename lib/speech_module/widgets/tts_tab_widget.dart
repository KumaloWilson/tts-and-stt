import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/speech_controller.dart';
import 'text_input_widget.dart';
import 'tts_controls_widget.dart';
import 'tts_settings_widget.dart';

class TTSTabWidget extends StatelessWidget {
  final SpeechController controller = Get.find<SpeechController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: TextInputWidget(),
          ),
          const SizedBox(height: 16),
          TTSControlsWidget(),
          const SizedBox(height: 16),
          Expanded(
            flex: 1,
            child: TTSSettingsWidget(),
          ),
        ],
      ),
    );
  }
}
