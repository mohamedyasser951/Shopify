import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit_homelayout.dart';
import 'package:shop_app/layout/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/component/component.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeLayout, HomeLayoutStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        var cubit = CubitHomeLayout.get(context);
        return ListView.separated(
          physics:const BouncingScrollPhysics(),
          itemBuilder: ((context, index) => buildCategoryItem(
              CubitHomeLayout.get(context).categoryModel!.data.data[index])),
          separatorBuilder: (context, index) => myDivider(),
          itemCount:
              CubitHomeLayout.get(context).categoryModel!.data.data.length,
        );
      }),
    );
  }

  Widget buildCategoryItem(DataModel model) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            width: 100.0,
            height: 100.0,
            image: NetworkImage("${model.image}"),
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            "${model.name}",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
