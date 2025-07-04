import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/speech_controller.dart';

class STTControlsWidget extends StatelessWidget {
  final SpeechController controller = Get.find<SpeechController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => FloatingActionButton.large(
                  onPressed: controller.isSTTAvailable
                    ? (controller.isListening 
                        ? controller.stopListening 
                        : controller.startListening)
                    : null,
                  backgroundColor: controller.isListening 
                    ? Colors.red 
                    : Theme.of(context).primaryColor,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      controller.isListening ? Icons.mic_off : Icons.mic,
                      key: ValueKey(controller.isListening),
                      color: Colors.white,
                      size: 32,
                      semanticLabel: controller.isListening 
                        ? 'Stop listening' 
                        : 'Start listening',
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: controller.clearText,
                  icon: const Icon(Icons.clear, semanticLabel: 'Clear text'),
                  label: const Text('Clear'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: controller.recognizedText.isNotEmpty 
                    ? controller.copyTextToClipboard 
                    : null,
                  icon: const Icon(Icons.copy, semanticLabel: 'Copy text'),
                  label: const Text('Copy'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
