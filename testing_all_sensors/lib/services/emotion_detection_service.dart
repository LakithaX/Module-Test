import 'package:camera/camera.dart';
import 'package:opencv_dart/opencv_dart.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class EmotionDetectionService {
  Interpreter? _interpreter;
  bool _isInitialized = false;

  static const emotions = [
    'Angry',
    'Disgust',
    'Fear',
    'Happy',
    'Sad',
    'Surprise',
    'Neutral',
  ];

  Future<void> initialize() async {
    try {
      _interpreter = await Interpreter.fromAsset(
        'assets/models/emotion_detection_model.tflite', // Add proper path
      );
      _isInitialized = true;
    } catch (e) {
      print('Could not load emotion detection model: $e');
      _isInitialized = false;
    }
  }

  String detectEmotion(CameraImage image) {
    if (!_isInitialized) return 'Neutral';

    // Convert CameraImage to OpenCV Mat
    // Preprocess image for model
    // Run inference
    // Return detected emotion

    return 'Happy'; // Placeholder
  }
}

// Replace the current detectEmotion method with:
String detectEmotion(CameraImage image) {
  if (!_isInitialized || _interpreter == null) return 'Neutral';

  try {
    // Convert YUV420 to RGB using OpenCV
    final bytes = image.planes[0].bytes;
    final Mat src = Mat.create(
      cols: image.width,
      rows: image.height,
      type: MatType.CV_8UC1,
    );
    src.data.setAll(0, bytes);

    // Convert to RGB
    final Mat rgb = Mat.empty();
    cvtColor(src, rgb, COLOR_YUV2RGB_NV21);

    // Resize to model input size (48x48 for most emotion models)
    final Mat resized = Mat.empty();
    resize(rgb, resized, (48, 48));

    // Preprocess for model (normalize, etc.)
    // Run inference with _interpreter
    // Process output

    return 'Happy'; // Replace with actual inference result
  } catch (e) {
    return 'Neutral';
  }
}
