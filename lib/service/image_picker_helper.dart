import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker _imagePicker = ImagePicker();

  void imagePickerFromGallery(Function(String?) callback) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      callback(pickedFile?.path);
    } catch (e) {
      print("Image Picker Error");
    }
  }

  void imagePickerFromCamera(Function(String?) callback) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );
      callback(pickedFile?.path);
    } catch (e) {
      print("Image Picker Error");
    }
  }
}