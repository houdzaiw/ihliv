import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ihliv/base/custom_style.dart';
import 'package:ihliv/base/utils/hex_color.dart';
import 'package:ihliv/sections/main/controllers/oauth_edit_controller.dart';
import 'package:ihliv/sections/main/widgets/common_widgets.dart';

class OauthEditPage extends StatelessWidget {
  final controller = Get.put(OauthEditController());

  OauthEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#DEE6FF'),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
        child: GetBuilder<OauthEditController>(builder: (controller) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            _buildAvatar(context),
                            _buildNickname(context),
                            const SizedBox(height: 10),
                            _buildGender(context),
                            const SizedBox(height: 10),
                            _buildBirthday(context),
                            const SizedBox(height: 10),
                            _buildCountry(context),
                            const SizedBox(height: 10),
                            _buildLanguage(context),
                            const SizedBox(height: 10),
                            _buildCode(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    height: 44,
                    child: GFButton(
                      shape: GFButtonShape.pills,
                      text: "Submit",
                      textStyle: Theme.of(context).textTheme.whiteBold(16),
                      fullWidthButton: true,
                      color: Theme.of(context).colorScheme.themeBlue,
                      onPressed: controller.submit,
                    ),
                  ),
                  GFButton(
                    shape: GFButtonShape.pills,
                    type: GFButtonType.transparent,
                    text: "Skip",
                    textStyle: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.themeBlue, fontWeight: FontWeight.bold),
                    onPressed: controller.skip,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _buildCountry(BuildContext context) {
    return Column(
      children: [
        GFListTile(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.zero,
          avatar: Text('Country', style: Theme.of(context).textTheme.black33(14)),
          icon: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Theme.of(context).colorScheme.greyCC),
          title: Container(alignment: Alignment.centerRight, child: Text(controller.country ?? 'Select', style: Theme.of(context).textTheme.black33(14))),
          onTap: () {
            showCupertinoModalPopup(
              context: Get.context!,
              builder: (BuildContext context) {
                return CountryPicker(
                  'Country',
                  country: controller.country,
                  onValuePicked: (country) {
                    controller.choiceValue(country: country);
                  },
                );
              },
            );
          },
        ),
        Divider(height: 1, color: Theme.of(context).colorScheme.dividing, indent: 10, endIndent: 10),
      ],
    );
  }

  _buildLanguage(BuildContext context) {
    return Column(
      children: [
        GFListTile(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.zero,
          avatar: Text('Language', style: Theme.of(context).textTheme.black33(14)),
          icon: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Theme.of(context).colorScheme.greyCC),
          title: Container(alignment: Alignment.centerRight, child: Text(controller.language ?? 'Select', style: Theme.of(context).textTheme.black33(14))),
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return LanguagePicker(
                  'Language',
                  language: controller.language,
                  onValuePicked: (language) {
                    controller.choiceValue(language: language);
                  },
                );
              },
            );
          },
        ),
        Divider(height: 1, color: Theme.of(context).colorScheme.dividing, indent: 10, endIndent: 10),
      ],
    );
  }

  _buildBirthday(BuildContext context) {
    return Column(
      children: [
        GFListTile(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.zero,
          avatar: Text('Birthday', style: Theme.of(context).textTheme.black33(14)),
          icon: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Theme.of(context).colorScheme.greyCC),
          title: Container(alignment: Alignment.centerRight, child: Text(controller.birthday ?? 'Select', style: Theme.of(context).textTheme.black33(14))),
          onTap: () {
            showCupertinoModalPopup(
              context: Get.context!,
              builder: (BuildContext context) {
                return DatePicker(
                  'Birthday',
                  initDate: DateTime.parse(controller.birthday ?? ''),
                  minimumDate: DateTime(DateTime.now().year - 80),
                  maximumDate: DateTime.now(),
                  onValuePicked: (datetime) {
                    controller.choiceValue(birthday: formatDate(datetime, [yyyy, '-', mm, '-', dd]));
                  },
                );
              },
            );
          },
        ),
        Divider(height: 1, color: Theme.of(context).colorScheme.dividing, indent: 10, endIndent: 10),
      ],
    );
  }

  _buildGender(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GFListTile(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: EdgeInsets.zero,
          avatar: Text('Gender', style: Theme.of(context).textTheme.black33(14)),
          icon: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Theme.of(context).colorScheme.greyCC),
          title: Container(alignment: Alignment.centerRight, child: Text(controller.gender, style: Theme.of(context).textTheme.black33(14))),
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return GenderPicker(
                  'Gender',
                  onValuePicked: (gender) {
                    controller.choiceValue(gender: gender);
                  },
                );
              },
            );
          },
        ),
        Divider(height: 1, color: Theme.of(context).colorScheme.dividing, indent: 10, endIndent: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            'You can’t change your gender afterwards.\nPlease confirm your choice ',
            style: TextStyle(color: HexColor.fromHex('#FF7F7F'), fontSize: 12),
          ),
        )
      ],
    );
  }

  _buildNickname(BuildContext context) {
    return Column(
      children: [
        GFListTile(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          margin: EdgeInsets.zero,
          avatar: Text('Nickname', style: Theme.of(context).textTheme.black33(14)),
          title: Container(
            alignment: Alignment.centerRight,
            child: TextField(
              controller: controller.nicknameController,
              maxLines: 1,
              maxLength: 20,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "Input your nickname",
                hintStyle: Theme.of(context).textTheme.black99(14),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                counter: Container(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.themeBlue, width: 1.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.dividing, width: 1.0),
                ),
              ),
              style: Theme.of(context).textTheme.black33(14),
            ),
          ),
          onTap: () {},
        ),
        Divider(height: 1, color: Theme.of(context).colorScheme.dividing, indent: 10, endIndent: 10),
      ],
    );
  }

  _buildCode(BuildContext context) {
    return Column(
      children: [
        GFListTile(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          margin: EdgeInsets.zero,
          avatar: Text('Invitation code', style: Theme.of(context).textTheme.black33(14)),
          title: Container(
            alignment: Alignment.centerRight,
            child: TextField(
              controller: controller.codeController,
              maxLines: 1,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: "Optional",
                hintStyle: Theme.of(context).textTheme.black99(14),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                counter: null,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.themeBlue, width: 1.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.dividing, width: 1.0),
                ),
              ),
              style: Theme.of(context).textTheme.black33(14),
            ),
          ),
          onTap: () {},
        ),
        Divider(height: 1, color: Theme.of(context).colorScheme.dividing, indent: 10, endIndent: 10),
      ],
    );
  }

  _buildAvatar(BuildContext context) {
    final itemWidth = (MediaQuery.of(context).size.width - 60 - 45) / 4;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Container(
            width: itemWidth,
            height: itemWidth,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.greyCC,
              elevation: 0,
              // highlightElevation: 1,
              onPressed: () => controller.choiceImage(),
              child: Builder(builder: (context) {
                if (controller.choiceAvatarFile != null) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(itemWidth / 2),
                    child: Image.file(controller.choiceAvatarFile!, fit: BoxFit.cover),
                  );
                }
                return const Icon(Icons.camera_alt, size: 40);
              }),
            ),
          ),
          const SizedBox(width: 10),
          Wrap(
            spacing: 15,
            children: List.generate(3, (index) {
              final avatars = controller.genderAvatars;
              final avatarAsset = avatars[index];
              return ChoiceChip(
                onSelected: (value) {
                  controller.choiceAssets(avatarAsset, value);
                },
                selected: avatarAsset == controller.choiceAssetsAvatar,
                selectedColor: Theme.of(context).colorScheme.themeBlue,
                labelPadding: EdgeInsets.zero,
                label: Image.asset(avatarAsset, width: itemWidth - 8, fit: BoxFit.cover),
              );
            }),
          ),
        ],
      ),
    );
  }
}
