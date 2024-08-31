// lib/image_generator.dart

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

/// Function to add text to an image
/// 
/// [name] - The text to be added to the image.
/// Returns the file path of the modified image.
Future<String> addTextToImage(String name) async {
  // Load an image from the assets folder.
  final ByteData data = await rootBundle.load('assets/sample_image.png');
  final Uint8List bytes = data.buffer.asUint8List();

  // Decode the image into an img.Image object.
  final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;

  // Resize the image if needed (here resizing to a width of 600).
  final img.Image resizedImage = img.copyResize(image, width: 600);

  // Draw the text on the image at the specified position with the selected color.
  img.drawString(
    resizedImage,
    img.arial_24, // Use a built-in font provided by the package.
    50, // X position of the text.
    50, // Y position of the text.
    name, // The text to draw (user's name).
    color: img.getColor(255, 0, 0), // Text color (red).
  );

  // Save the modified image to the device's local file storage.
  final outputFile = await _localFile;
  await outputFile.writeAsBytes(img.encodePng(resizedImage));

  // Return the path to the saved file.
  return outputFile.path;
}

/// Helper function to get the local file path for saving the image.
Future<File> get _localFile async {
  // Get the directory for storing the file (application documents directory).
  final directory = await getApplicationDocumentsDirectory();
  
  // Create and return a File object pointing to the path where the image will be saved.
  return File('${directory.path}/name_image.png');
}
