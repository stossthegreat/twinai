import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../constants/app_colors.dart';

class TwinBubble extends StatelessWidget {
  final TwinMessage message;
  
  const TwinBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case TwinMessageType.user:
        return _buildUserMessage();
      case TwinMessageType.twin:
        return _buildTwinMessage();
      case TwinMessageType.echo:
        return _buildEchoMessage();
      case TwinMessageType.warning:
        return _buildWarningMessage();
      case TwinMessageType.revelation:
        return _buildRevelationMessage();
    }
  }

  Widget _buildUserMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 340), // 85% max width equivalent
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white10,
                border: Border.all(
                  color: AppColors.white30,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwinMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 340), // 85% max width equivalent
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.emerald500.withOpacity(0.25),
                    AppColors.cyan500.withOpacity(0.25),
                  ],
                ),
                border: Border.all(
                  color: AppColors.emerald400.withOpacity(0.5),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '◈ TWIN CONSCIOUSNESS',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.emerald300,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message.text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                  if (message.emotionalWeight != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'EMOTIONAL WEIGHT',
                          style: TextStyle(
                            fontSize: 8,
                            color: AppColors.white40,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.white20,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: message.emotionalWeight!,
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [AppColors.emerald400, AppColors.cyan400],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEchoMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 32), // pl-8 equivalent
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 320), // 80% max width equivalent
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.black70,
                border: Border.all(
                  color: AppColors.purple400.withOpacity(0.6),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '◈ SUBCONSCIOUS LAYER',
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.purple300,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.purple200,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 340), // 85% max width equivalent
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.rose500.withOpacity(0.2),
                    AppColors.amber500.withOpacity(0.2),
                  ],
                ),
                border: Border.all(
                  color: AppColors.rose400.withOpacity(0.6),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚠ CRITICAL ALERT',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.rose400,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message.text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevelationMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 340), // 85% max width equivalent
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.purple500.withOpacity(0.3),
                    AppColors.pink500.withOpacity(0.2),
                  ],
                ),
                border: Border.all(
                  color: AppColors.purple400.withOpacity(0.7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.purple500.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '✦ REVELATION',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.purple200,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white95,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
