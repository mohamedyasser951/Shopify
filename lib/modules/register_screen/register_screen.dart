import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register_screen/cubit_Register.dart';
import 'package:shop_app/modules/register_screen/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/sheredpref_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitRegister, StatesRegister>(
      listener: ((context, state) {
        if (state is ShopRegisterSucceessState) {
        
          if (state.model.status) {
           

            SharedHelper.saveTheToken(
                    key: 'token', value: state.model.data!.token)
                .then((value) {
              TOKEN = state.model.data!.token;

              navigateAndFinish(context, HomeLayout());
              
            }).catchError((e) {
              print(e.toString());
            });

            defeaulttoast(
                message: state.model.messsage!, state: ToastState.SUCESS);
          } else {
            defeaulttoast(
                message: state.model.messsage!, state: ToastState.ERROE);
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
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Register",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text("Register now to browse our hot offers",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.grey)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defeaultTextFormFiel(
                      textEditingController: name,
                      label: "Name",
                      prefix: Icons.person,
                      type: TextInputType.name,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Name must be entered";
                        }
                        return null;
                      },
                    ),
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
                        CubitRegister.get(context).changeVisiblity();
                      },
                  isPassword: CubitRegister.get(context).ispassword,
                      textEditingController: password,
                      label: "Password",
                      suffix: CubitRegister.get(context).suffix,
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
                      height: 20.0,
                    ),
                    defeaultTextFormFiel(
                      textEditingController: phone,
                      label: "Phone",
                      prefix: Icons.phone,
                      type: TextInputType.phone,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Phone must be entered";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    ConditionalBuilder(
                      condition: State is! ShopRegisterLoadingState,
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      builder: (context) => defeaultButton(
                        function: () {
                          if (formkey.currentState!.validate()){
                                 CubitRegister.get(context).userRegister(
                              email: email.text,
                              password: password.text,
                              phone: phone.text,
                              name: name.text);
                          }
                       
                        },
                        text: "Register",
                        isUperCase: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }));
}

}
