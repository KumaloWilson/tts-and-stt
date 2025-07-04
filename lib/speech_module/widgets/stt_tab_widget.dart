import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/speech_controller.dart';
import 'text_display_widget.dart';
import 'stt_controls_widget.dart';

class STTTabWidget extends StatelessWidget {
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
            child: TextDisplayWidget(),
          ),
          const SizedBox(height: 16),
          STTControlsWidget(),
          const SizedBox(height: 16),
          _buildConfidenceIndicator(),
        ],
      ),
    );
  }

  Widget _buildConfidenceIndicator() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recognition Confidence',
              style: Get.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Obx(() => LinearProgressIndicator(
              value: controller.confidenceLevel,
              backgroundColor: Colors.grey.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(
                controller.confidenceLevel > 0.7
                    ? Colors.green
                    : controller.confidenceLevel > 0.4
                    ? Colors.orange
                    : Colors.red,
              ),
            )),
            const SizedBox(height: 4),
            Obx(() => Text(
              '${(controller.confidenceLevel * 100).toStringAsFixed(1)}%',
              style: Get.textTheme.bodySmall,
            )),
          ],
        ),
      ),
    );
  }
}