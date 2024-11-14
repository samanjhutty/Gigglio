import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gigglio/model/utils/app_constants.dart';
import 'package:gigglio/services/auth_services.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/utils/string.dart';
import '../../view/widgets/top_widgets.dart';
import '../routes/routes.dart';

class ProfileController extends GetxController {
  AuthServices authServices = Get.find();
  final _user = FirebaseAuth.instance.currentUser;
  final _storage = FirebaseStorage.instance.ref();
  final posts = FirebaseFirestore.instance.collection(FB.post);

  final nameController = TextEditingController();
  final bioContr = TextEditingController();
  final editFormKey = GlobalKey<FormState>();

  RxBool isProfileLoading = RxBool(false);
  RxBool isImageLoading = RxBool(false);
  RxnString imageUrl = RxnString();

  void toSettings() => Get.toNamed(Routes.settings);
  void toMyPosts() {}

  void toEditProfile() {
    final user = authServices.user.value;
    nameController.text = user?.displayName ?? '';

    bioContr.text = user?.bio ?? '';
    imageUrl.value = authServices.user.value?.image;
    Get.toNamed(Routes.editProfile);
  }

  void fromEditProfile(bool canPop, result) =>
      editFormKey.currentState?.reset();

  void imagePicker(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
              actions: const [],
              actionPadding: EdgeInsets.zero,
              title: 'Pick from',
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () => _pickImage(ImageSource.gallery),
                    leading: const Icon(Icons.photo_library_outlined),
                    title: const Text('Gallary'),
                  ),
                  ListTile(
                    onTap: () => _pickImage(ImageSource.camera),
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text('Camera'),
                  ),
                ],
              ));
        });
  }

  void _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    Get.back();
    isImageLoading.value = true;
    try {
      XFile? file = await picker.pickImage(source: source, imageQuality: 15);
      if (file == null) throw StringRes.cancelled;

      String? url = await _savetoFB(file);
      isImageLoading.value = false;
      imageUrl.value = url;
    } catch (e) {
      isImageLoading.value = false;
      logPrint('ImagePicker: $e');
    }
  }

  Future<String?> _savetoFB(XFile xfile) async {
    try {
      File file = File(xfile.path);
      String ext = xfile.path.split('.').last;
      final ref = _storage.child(
        AppConstants.profileImage(ext),
      );

      await ref.putFile(file);
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      logPrint('FBstorage: $e');
      return null;
    }
  }

  void editProfile() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(editFormKey.currentState?.validate() ?? false)) return;
    if (isImageLoading.value) return;
    isProfileLoading.value = true;
    final user = authServices.user.value;
    try {
      final modifiedUrl = imageUrl.value != user?.image;
      if (modifiedUrl) {
        await _user!.updatePhotoURL(imageUrl.value);
      }
      final modifiedName = nameController.text != user?.displayName;
      if (modifiedName) {
        await _user!.updateDisplayName(nameController.text);
      }
      await authServices.saveProfile(bioContr.text.trim());
      isProfileLoading.value = false;
      Get.back();
    } catch (e) {
      isProfileLoading.value = false;
      logPrint('EditProfile: $e');
      authServices.logout();
    }
  }
}
