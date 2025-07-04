import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/speech_controller.dart';

class TTSControlsWidget extends StatelessWidget {
  final SpeechController controller = Get.find<SpeechController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => ElevatedButton(
              onPressed: controller.isTextEmpty
                  ? null
                  : controller.isTTSPlaying
                  ? controller.stopSpeaking
                  : controller.speakText,
              child: Icon(
                controller.isTTSPlaying ? Icons.stop : Icons.play_arrow,
                semanticLabel: controller.isTTSPlaying ? 'Stop speaking' : 'Start speaking',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.isTTSPlaying
                    ? Colors.red
                    : Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
            )),
            Obx(() => ElevatedButton(
              onPressed: controller.isTTSPlaying ? controller.pauseSpeaking : null,
              child: const Icon(Icons.pause, semanticLabel: 'Pause speaking'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            )),
            ElevatedButton(
              onPressed: controller.clearText,
              child: const Icon(Icons.clear, semanticLabel: 'Clear text'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}