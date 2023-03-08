import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/cubit_login.dart';
import 'package:shop_app/modules/login_screen/states.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/sheredpref_helper.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitLogin, StatesLogin>(
      listener: ((context, state) {
        if (state is ShopLoginSucceessState) {
         // print("ya mahmaded ShopLoginSucceessState");
          if (state.loginModel.status) {
           

            SharedHelper.saveTheToken(
                    key: 'token', value: state.loginModel.data!.token)
                .then((value) {
              TOKEN = state.loginModel.data!.token;

              navigateAndFinish(context, HomeLayout());
              
            }).catchError((e) {
              print(e.toString());
            });

            defeaulttoast(
                message: state.loginModel.messsage!, state: ToastState.SUCESS);
          } else {
            defeaulttoast(
                message: state.loginModel.messsage!, state: ToastState.ERROE);
          }
        }
      }),
      builder: ((context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.black)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text("Login now to browse our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: Colors.grey)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defeaultTextFormFiel(
                          textEditingController: email,
                          label: "Email",
                          prefix: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Email must be entered";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defeaultTextFormFiel(
                          suffixPressed: () {
                            CubitLogin.get(context).changeVisiblity();
                          },
                          textEditingController: password,
                          isPassword: CubitLogin.get(context).ispassword,
                          label: "Password",
                          onSubmit: (v) {
                            CubitLogin.get(context).userLogin(
                                email: email.text, password: password.text);
                          },
                          suffix: CubitLogin.get(context).suffix,
                          prefix: Icons.lock_clock_outlined,
                          type: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "password must be entered";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          fallback: (context) => const Center(
                            child:  CircularProgressIndicator(),
                          ),
                          builder: (context) => defeaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                CubitLogin.get(context).userLogin(
                                    email: email.text, password: password.text);
                              }
                            },
                            text: "LOGIN",
                            isUperCase: true,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have account?"),
                              defeaultTextButton(
                                  function: () {
                                    buildGoTo(
                                        context: context,
                                        Widget: RegisterScreen());
                                  },
                                  text: "Register")
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        );
      }),
    );
  }
}
