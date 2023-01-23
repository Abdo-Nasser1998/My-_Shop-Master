// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/login_cubit/states.dart';
import '../../../shared/cubit/login_cubit/cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var authCubit = AuthCubit.get(context);
          var formKey = GlobalKey<FormState>();
          var emailController = TextEditingController();
          var passwordController = TextEditingController();
          var nameController = TextEditingController();
          var phoneController = TextEditingController();

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/fristcover.jpg')),
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Text(""),
                systemOverlayStyle: SystemUiOverlayStyle(
                    systemNavigationBarColor: Colors.black,
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarBrightness: Brightness.dark),
              ),
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.values[0],
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.asset(
                            'assets/images/icons&logos/BrandLogo.svg'),
                        Text(
                          "إنشاء حساب",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#1E55A2"),
                          ),
                          textScaleFactor: 1,
                        ),
                        Text(
                          "يرجى ملء التفاصيل لإنشاء حساب",
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //Name
                        SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: text(
                            controller: nameController,
                            input: TextInputType.emailAddress,
                            hint: "الأسم",
                            label: "الأسم",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "this field is required";
                              }
                              return null;
                            },
                            prefix: SvgPicture.asset(
                                "assets/images/icons&logos/Person Profile.svg"),
                            // Image.asset("assets/images/icons&logo/Mail.png")
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: text(
                            controller: phoneController,
                            input: TextInputType.phone,
                            hint: "رقم الهاتف",
                            label: "رقم الهاتف",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "this field is required";
                              }
                              return null;
                            },
                            prefix: SvgPicture.asset(
                                "assets/images/icons&logos/Lock.svg"),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        //Email
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: text(
                            controller: emailController,
                            input: TextInputType.emailAddress,
                            hint: "البريد الإلكترونى",
                            label: " البريد الإلكترونى",
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'email must be not empty';
                              } else if (!value.toString().contains('@') ||
                                  !value.toString().contains('.com')) {
                                return 'ex: example@mail.com';
                              } else {
                                return null;
                              }
                            },
                            prefix: SvgPicture.asset(
                                "assets/images/icons&logos/Mail.svg"),
                            // Image.asset("assets/images/icons&logo/Mail.png")
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //Password
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: text(
                              controller: passwordController,
                              input: TextInputType.visiblePassword,
                              hint: "كلمة المرور",
                              label: " كلمة المرور",
                              onSubmit: (value) async {
                                if (formKey.currentState!.validate()) {
                                  authCubit.signUP(context,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              validate: (value) {
                                // return"هذا الحقل مطلوب";
                                RegExp regEx =
                                    RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");
                                if (value!.isEmpty) {
                                  return "Password must not be empty";
                                } else if (value != passwordController.text) {
                                  return "Password must be same";
                                } else if (value.length < 8) {
                                  return 'Should be more than 8 Characters';
                                } else if (!value.toString().contains(regEx)) {
                                  return 'Use Numbers and Capital and Small Characters at least 1';
                                } else {
                                  return null;
                                }
                              },
                              prefix: SvgPicture.asset(
                                  "assets/images/icons&logos/Lock.svg"),
                              suffix: Icon(Icons.remove_red_eye_outlined)),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        // "ابدا"

                        ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => startButton(
                                text: "سجل",
                                ontap: () async {
                                  if (formKey.currentState!.validate()) {
                                    authCubit.signUP(context,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                }),
                            fallback: (context) => Center(
                                  child: CircularProgressIndicator(),
                                )),

                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "قم بالتسجيل عبر",
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                          width: 200,
                          height: 61,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  "assets/images/icons&logos/Facebook logo.svg",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  "assets/images/icons&logos/Twitter logo.svg",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  "assets/images/icons&logos/Google logo.svg",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
