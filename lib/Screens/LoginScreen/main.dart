import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projectchat/Api/authenticate.dart';
import 'package:projectchat/Providers/loginprovider.dart';
import 'package:projectchat/Screens/HomeScreen/main.dart';

import 'package:projectchat/Screens/LoginScreen/textfieldcard.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Animation _animationLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _animation = Tween(begin: 100.h, end: 0.h).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _animationLogin = Tween(begin: 48.h, end: 10.h).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();

        // loginProvider.focusnode.unfocus();

        _controller.reverse();
        if (loginProvider.email == null || loginProvider.email!.isEmpty) {
          setState(() {
            loginProvider.setSelectedEmail(false);
          });
        }
        if (loginProvider.pwd == null || loginProvider.pwd!.isEmpty) {
          setState(() {
            loginProvider.setSelectedPwd(false);
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xFFe2b1c4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: _animation.value == 0,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                  child: Icon(Icons.arrow_back_ios_new_sharp,
                      color: Colors.white, size: 25),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    // visible:
                    //     loginProvider.selectedEmail || loginProvider.selectedPwd
                    //         ? false
                    //         : true,
                    child: SizedBox(
                      height: _animationLogin.value,
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        children: [
                          Positioned(
                            top: 2.8.h,
                            left: 2.8.h,
                            child: Text(
                              "projectchat",
                              style: GoogleFonts.poppins(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF3969b9),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: _animation.value,
                          //   child: Lottie.network(
                          //       'https://assets5.lottiefiles.com/packages/lf20_zjy5a523.json'),
                          // ),
                          SizedBox(
                            width: _animation.value,
                            child: Lottie.asset(
                                'assets/loginpage/2-persons-chatting-animation.json'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Let's make this your most productive \nexperience ever.",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldCard(
                      type: 'email',
                      controller: _controller,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldCard(type: 'pwd', controller: _controller),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Material(
                        elevation: 5,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 6.h,
                          width: 16.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                loginProvider.pwd == null ||
                                        loginProvider.pwd!.isEmpty
                                    ? Icons.lock_open
                                    : Icons.lock_outline,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  var success = Authenticate.authenticateUser(
                                      loginProvider.email, loginProvider.pwd);
                                  if (success) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(loginProvider.email ==
                                                    null ||
                                                loginProvider.pwd == null
                                            ? 'Please enter your username and password'
                                            : 'Incorrect Username/Password'),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 6.h,
                                  width: 9.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xFF242436),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
