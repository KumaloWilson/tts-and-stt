import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/speech_controller.dart';

class CustomAppBar extends StatelessWidget {
  final SpeechController controller = Get.find<SpeechController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.voice_chat,
            color: Colors.white,
            size: 32,
            semanticLabel: 'Speech App Icon',
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Speech Assistant',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() => Text(
                  controller.currentTabIndex == 0 
                    ? 'Convert text to speech'
                    : 'Convert speech to text',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                )),
              ],
            ),
          ),
          IconButton(
            onPressed: controller.clearText,
            icon: const Icon(Icons.clear_all, color: Colors.white),
            tooltip: 'Clear all text',
          ),
        ],
      ),
    );
  }
}
