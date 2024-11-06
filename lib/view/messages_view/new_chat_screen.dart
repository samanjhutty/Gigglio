import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gigglio/model/models/user_details.dart';
import 'package:gigglio/model/utils/dimens.dart';
import 'package:gigglio/services/theme_services.dart';
import 'package:gigglio/view/widgets/base_widget.dart';
import 'package:gigglio/view/widgets/my_cached_image.dart';
import 'package:gigglio/view/widgets/top_widgets.dart';
import 'package:gigglio/view_models/controller/messages_controller/messages_controller.dart';
import '../../model/utils/string.dart';
import '../widgets/my_text_field_widget.dart';

class NewChatScreen extends GetView<MessagesController> {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeServices.of(context);
    final user = controller.authServices.user.value;
    final bodyTextStyle = context.textTheme.bodyMedium;

    return BaseWidget(
        padding: EdgeInsets.zero,
        appBar: AppBar(
          backgroundColor: scheme.background,
          title: SearchTextField(
            title: 'Search',
            focusNode: controller.newChatFocus,
            controller: controller.newChatContr,
            showClear: false,
          ),
          titleSpacing: 0,
          actions: const [SizedBox(width: Dimens.sizeDefault)],
        ),
        child: FutureBuilder(
            future: controller.users.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return const SnapshotError();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SnapshotLoading();
              }
              final docs = snapshot.data!.docs;
              docs.removeWhere((e) => e.id == user!.id);
              controller.allUsers.value = docs.map((e) {
                return UserDetails.fromJson(e.data());
              }).toList();

              controller.usersList.value = controller.allUsers;
              return Obx(() => ListView.builder(
                  padding: const EdgeInsets.only(top: Dimens.sizeLarge),
                  itemCount: controller.usersList.length,
                  itemBuilder: (context, index) {
                    final user = controller.usersList[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Dimens.sizeLarge,
                      ),
                      onTap: () => controller.toChatScreen(user),
                      leading: MyCachedImage(
                        user.image,
                        isAvatar: true,
                        avatarRadius: 24,
                      ),
                      title: Text(user.displayName),
                      subtitle: Text(user.bio ?? StringRes.defBio),
                      subtitleTextStyle: bodyTextStyle?.copyWith(
                        color: scheme.disabled,
                      ),
                    );
                  }));
            }));
  }
}