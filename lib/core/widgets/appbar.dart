import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/widgets/custom_textfield.dart';
import 'package:graduation/features/home/pres/views/widget/app_filter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(45.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: abarcolor,
      elevation: 1,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              height: 36,
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.search,
                      size: 20,
                      color: Colors.orange,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                                child: CustomAlertDialog());
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.orange,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    hintText: 'home.search'.tr(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 107, 99, 99),
                    ),
                  ),
                  onChanged: (value) {
                    // Handle search text changes
                  },
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.language, color: Colors.white),
            onPressed: () {
              if (EasyLocalization.of(context)!.currentLocale ==
                  const Locale('en')) {
                EasyLocalization.of(context)!.setLocale(const Locale('ar'));
              } else {
                EasyLocalization.of(context)!.setLocale(const Locale('en'));
              }
              // Add your world icon functionality here
            },
          ),
        ],
      ),
    );
  }
}
