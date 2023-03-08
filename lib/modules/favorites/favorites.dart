import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit_homelayout.dart';
import 'package:shop_app/layout/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/component/component.dart';

import '../../shared/component/constants.dart';

class FavorietsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeLayout, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CubitHomeLayout.get(context);
        return ConditionalBuilder(
          condition: state is! GetFavoritesLoadingState,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: ((context, index) => buildFavoiteItems(
                  CubitHomeLayout.get(context)
                      .favoritesModel!
                      .data!
                      .data[index]
                      .product,
                  context)),
              separatorBuilder: ((context, index) => myDivider()),
              itemCount: cubit.favoritesModel!.data!.data.length),
        );
      },
    );
  }
}

Widget buildFavoiteItems(model, context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      height: 100.0,
      child: Row(children: [
        Container(
          width: 100.0,
          height: 100.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(height: 200.0, image: NetworkImage(model!.image)),
              if (model.discount != 0)
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.pink,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(50.0))),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${model.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                  color: Colors.black,
                )),
            Spacer(),
            Row(
              children: [
                Text(
                  "${model.price}}",
                  style: TextStyle(color: defeaultColor),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                if (true)
                  Text(
                    "${model.oldPrice}",
                    style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                CircleAvatar(
                  radius: 15.0,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      CubitHomeLayout.get(context).changeFavorItes(model.id!);
                    },
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      size: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor:
                      CubitHomeLayout.get(context).favoriets[model.id]!
                          ? defeaultColor
                          : Colors.grey,
                )
              ],
            ),
          ],
        )),
      ]),
    ),
  );
}
