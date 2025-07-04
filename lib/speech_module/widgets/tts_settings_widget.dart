import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/speech_controller.dart';

class TTSSettingsWidget extends StatelessWidget {
  final SpeechController controller = Get.find<SpeechController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Speech Settings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSlider(
                      'Speech Rate',
                          () => controller.speechRate,
                      0.1,
                      1.0,
                      controller.setSpeechRate,
                      Icons.speed,
                    ),
                    const SizedBox(height: 12),
                    _buildSlider(
                      'Pitch',
                          () => controller.speechPitch,
                      0.5,
                      2.0,
                      controller.setSpeechPitch,
                      Icons.tune,
                    ),
                    const SizedBox(height: 12),
                    _buildSlider(
                      'Volume',
                          () => controller.speechVolume,
                      0.0,
                      1.0,
                      controller.setSpeechVolume,
                      Icons.volume_up,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(
      String label,
      double Function() getValue,
      double min,
      double max,
      Function(double) onChanged,
      IconData icon,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Row(
          children: [
            Icon(icon, size: 20, color: Get.theme.primaryColor),
            const SizedBox(width: 8),
            Text(label, style: Get.textTheme.bodyMedium),
            const Spacer(),
            Text(
              getValue().toStringAsFixed(2),
              style: Get.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )),
        Obx(() => Slider(
          value: getValue(),
          min: min,
          max: max,
          divisions: 20,
          onChanged: onChanged,
          activeColor: Get.theme.primaryColor,
        )),
      ],
    );
  }
}