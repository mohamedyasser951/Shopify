import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit_homelayout.dart';
import 'package:shop_app/layout/states.dart';
import 'package:shop_app/shared/component/component.dart';

class settingsScreen extends StatelessWidget {
  const settingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var phone = TextEditingController();
    var name = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<CubitHomeLayout, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CubitHomeLayout.get(context).userModel!;

          email.text = cubit.data!.email!;
          phone.text = cubit.data!.phone!;
          name.text = cubit.data!.name!;

          return ConditionalBuilder(
              condition: cubit.data != null,
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
              builder: (context) => SingleChildScrollView(
                child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                              if (state is UpdateProfileLoadingState)
                               const LinearProgressIndicator(),
                             const  SizedBox(height: 20.0,),
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
                            height: 20.0,
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
                            height: 20.0,
                          ),
                          defeaultButton(
                              function: () {
                                if (formkey.currentState!.validate()){
                                     CubitHomeLayout.get(context).updateProfile(
                                    name: name.text,
                                    email: email.text,
                                    phone: phone.text);
                                }
                               
                              },
                              text: "UPDATE"),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defeaultButton(
                              function: () {
                                logOut(context);
                              },
                              text: "Logout")
                        ]),
                      ),
                    ),
              ));
        });
  }
}
