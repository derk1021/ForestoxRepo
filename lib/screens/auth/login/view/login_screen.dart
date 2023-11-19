import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tonyyaooo/generated/assets.dart';
import 'package:tonyyaooo/reusable_widgets/buttons/custom_elevated_button.dart';
import 'package:tonyyaooo/service/firestore_service.dart';
import 'package:tonyyaooo/utils/alignment/widget_alignment.dart';
import 'package:tonyyaooo/utils/constants/constant_lists.dart';
import 'package:tonyyaooo/utils/gaps/gaps.dart';
import 'package:tonyyaooo/utils/text_styles/text_styles.dart';

import '../../../../service/authentication.dart';
import '../../../../reusable_widgets/text_field/auth_form_field.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../home/stocks/stocks_landing/view/stocks_landing_screen.dart';
import '../controller/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logInController = Get.find<LogInController>();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        FirestoreService.setUser(user);
        Get.off(
          () => const StocksLandingScreen(),
          transition: Transition.fadeIn,
        );
        //update user document on firestore
      }
    });

    return Scaffold(
      backgroundColor: CColors.whiteColor,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 375),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          context.isPortrait ? 80.ph : 50.ph,
                          Image.asset(
                            Assets.appLogoTonyyaoooAppLogo,
                            width: 85,
                            height: 110,
                          ),
                          15.ph,
                          const Text(
                            "Login",
                            style: CustomTextStyles.black525,
                          ),
                          10.ph,
                          Text(
                            "Professional Stock Analysis & Prediction",
                            style: CustomTextStyles.blackOpac412,
                          ),
                          40.ph,
                          AuthFormField(
                            validatorFunction: (val) {
                              return null;
                            },
                            width: context.width * 1,
                            textEditingController:
                                logInController.emailController,
                            isEmailField: true,
                          ),
                          10.ph,
                          Obx(() {
                            return AuthFormField(
                              validatorFunction: (val) {
                                return null;
                              },
                              width: context.width * 1,
                              textEditingController:
                                  logInController.passwordController,
                              isPasswordField: true,
                              obscureText:
                                  logInController.isPasswordNotVisible.value,
                              obscureTextFunction: () {
                                logInController.togglePasswordVisibility();
                              },
                            );
                          }),
                          10.ph,
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: CustomTextStyles.black510,
                            ),
                          ).alignWidget(alignment: Alignment.centerRight),
                          30.ph,
                          CustomElevatedButton(
                            onPressedFunction: () {
                              print(logInController.emailController.text);
                              AuthenticationHelper()
                                  .signIn(
                                      email:
                                          logInController.emailController.text,
                                      password: logInController
                                          .passwordController.text)
                                  .then((result) {
                                if (result == null) {
                                  Get.off(
                                    () => const StocksLandingScreen(),
                                    transition: Transition.fadeIn,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      result,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ));
                                }
                              });
                            },
                            buttonText: "Login",
                            width: context.width * 1,
                            isBlue: true,
                          ),
                          20.ph,
                          const Text(
                            "Or Login Using",
                            style: CustomTextStyles.black613,
                          ),
                          20.ph,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  onPressedFunction: () {
                                    signInWithGoogle();
                                  },
                                  width: context.width * 1,
                                  isSocialMediaButton: true,
                                  isGoogleLogIn: true,
                                ),
                              ),
                              20.pw,
                              Expanded(
                                child: CustomElevatedButton(
                                  onPressedFunction: () {
                                    print("apple signin");
                                    signInWithApple();
                                  },
                                  width: context.width * 1,
                                  isSocialMediaButton: true,
                                  isAppleLogIn: true,
                                ),
                              ),
                            ],
                          ),
                          20.ph,
                          100.ph,
                          const Text(
                            "Don’t have an account?",
                            style: CustomTextStyles.black513,
                          ),
                          10.ph,
                          InkWell(
                            onTap: () {
                              print("sign up");
                            },
                            child: const Text(
                              "Signup here",
                              style: CustomTextStyles.blue713,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      Get.off(
        () => const StocksLandingScreen(),
        transition: Transition.fadeIn,
      );
    } catch (e) {
      print(e);
      GoogleSignIn().signOut();
    }
  }

  signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    await FirebaseAuth.instance.signInWithProvider(appleProvider);
    Get.off(
      () => const StocksLandingScreen(),
      transition: Transition.fadeIn,
    );
  }
}
