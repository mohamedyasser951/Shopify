import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit_homelayout.dart';
import 'package:shop_app/layout/states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/component/component.dart';


class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeLayout, HomeLayoutStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = CubitHomeLayout.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text("Salla"),
            actions: [
              IconButton(
                  onPressed: () {
                    buildGoTo(context: context, Widget: SearchScreen());
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    logOut(context);
                  },
                  icon: const Icon(Icons.logout)),
              IconButton(
                  onPressed: () {
                    CubitHomeLayout.get(context).changeMode();
                  },
                  icon: const Icon(Icons.dark_mode))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (value) => cubit.changeNavBarState(value),
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: "Categories"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: "Favorite"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
              ]),
        );
      },
    );
  }
}
