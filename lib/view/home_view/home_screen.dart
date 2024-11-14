import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gigglio/model/models/post_model.dart';
import 'package:gigglio/model/utils/string.dart';
import 'package:gigglio/view/widgets/base_widget.dart';
import '../../services/theme_services.dart';
import '../../view_models/controller/home_controller.dart';
import 'post_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.find();

  Future<void> reload() async => setState(() {});

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeServices.of(context);

    return BaseWidget(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        backgroundColor: scheme.background,
        automaticallyImplyLeading: false,
        title: TextButton.icon(
          onPressed: controller.toPost,
          label: const Text(StringRes.addPost),
          icon: const Icon(Icons.add),
        ),
        centerTitle: false,
        // actions: [
        //   IconButton(
        //       onPressed: controller.toNotifications,
        //       icon: Stack(
        //         alignment: Alignment.topRight,
        //         children: [
        //           const Icon(Icons.favorite_border_rounded),
        //           Container(
        //             decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               color: scheme.background,
        //             ),
        //             padding: const EdgeInsets.all(2),
        //             child: CircleAvatar(
        //               radius: Dimens.sizeExtraSmall,
        //               backgroundColor: scheme.primary,
        //             ),
        //           )
        //         ],
        //       )),
        //   const SizedBox(width: Dimens.sizeDefault),
        // ],
      ),
      child: RefreshIndicator(
        onRefresh: reload,
        child: FutureBuilder(
            future:
                controller.posts.orderBy('date_time', descending: true).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return NoData(reload);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: context.height * .1,
                      width: double.infinity,
                    ),
                    SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(color: scheme.primary),
                    )
                  ],
                );
              }

              return ListView.builder(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  padding: EdgeInsets.only(bottom: context.height * .1),
                  itemBuilder: (context, index) {
                    bool last = snapshot.data?.docs.length == index + 1;

                    final doc = snapshot.data?.docs[index];
                    final post = PostModel.fromJson(doc!.data());
                    return PostTile(id: doc.id, post: post, last: last);
                  });
            }),
      ),
    );
  }
}

class NoData extends GetView<HomeController> {
  final VoidCallback onReload;
  const NoData(this.onReload, {super.key, required});

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeServices.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: context.height * .2,
          width: double.infinity,
        ),
        Text(
          StringRes.errorUnknown,
          style: TextStyle(color: scheme.textColorLight),
        ),
        TextButton.icon(
          onPressed: onReload,
          label: const Text(StringRes.refresh),
          icon: const Icon(Icons.refresh_outlined),
        )
      ],
    );
  }
}
