import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectchat/Providers/loginprovider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextFieldCard extends StatefulWidget {
  final AnimationController controller;
  final String type;

  const TextFieldCard({
    Key? key,
    required this.type,
    required this.controller,
  }) : super(key: key);

  @override
  State<TextFieldCard> createState() => _TextFieldCardState();
}

class _TextFieldCardState extends State<TextFieldCard> {
  late String title;
  late String hint;
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    late final selected;
    late final updateSelected;
    late final setCreds;
    if (widget.type == 'email') {
      title = 'EMAIL ADDRESS';
      hint = 'saif@jumainah.com';
      selected = loginProvider.selectedEmail;
      updateSelected = (bool value) => loginProvider.setSelectedEmail(value);
      setCreds = (String value) => loginProvider.setEmail(value);
    } else if (widget.type == 'pwd') {
      title = 'PASSWORD';
      hint = '| | | | | | | | | | | ';
      obscureText = true;
      selected = loginProvider.selectedPwd;
      updateSelected = (bool value) => loginProvider.setSelectedPwd(value);
      setCreds = (String value) => loginProvider.setPwd(value);
    }

    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: selected ? 5 : 0,
      color: selected ? Colors.white : Colors.white38,
      child: GestureDetector(
        onTap: (() {
          widget.controller.forward();

          //loginProvider.requestfocus();
          updateSelected(true);
        }),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              //color: selected ? Colors.white : Colors.white38,
              borderRadius: BorderRadius.circular(10)),
          height: 10.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? const Color(0xFFdfe1e0)
                      : const Color(0xFF8a7d82),
                ),
              ),
              TextField(
                obscureText: obscureText,
                //  obscuringCharacter: '|',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                onSubmitted: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      updateSelected(true);
                      //loginProvider.setSelectedEmail(true);
                      //loginProvider.setEmail(value);
                      setCreds(value);
                    } else {
                      updateSelected(false);
                      // loginProvider.setSelectedEmail(false);
                    }
                  });
                },
                onChanged: (value) {
                  setCreds(value);
                  //loginProvider.setEmail(value);
                },
                onTap: () {
                  setState(() {
                    widget.controller.forward();
                    updateSelected(true);
                    //loginProvider.setSelectedEmail(true);
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: hint,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
