import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit_homelayout.dart';
import 'package:shop_app/layout/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/changefavoritesmodel.dart';
import 'package:shop_app/models/homemodel.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitHomeLayout, HomeLayoutStates>(
      listener: (context, state) {
        if (state is FavoritesDataSuccessState) {
          if (!state.model.status!) {
            defeaulttoast(
                message: state.model.message!,
                state: ToastState.ERROE);
          }
        }
      },
      builder: (context, state) {
        var cubit = CubitHomeLayout.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoryModel != null,
          builder: (context) => buildProductsItem(
              cubit.homeModel!, cubit.categoryModel!, context),
          fallback: ((context) => const Center(
                child: CircularProgressIndicator(),
              )),
        );
      },
    );
  }

  Widget buildProductsItem(
      HomeModel model, CategoryModel categoryModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data?.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          const SizedBox(
            height: 10.0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) =>
                          buildCategoryItems(categoryModel.data.data[index])),
                      separatorBuilder: ((context, index) => const SizedBox(
                            width: 10.0,
                          )),
                      itemCount: categoryModel.data.data.length),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.grey,
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.85,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildGridItems(model.data!.products[index], context))),
          ),
        ],
      ),
    );
  }

  Widget buildGridItems(ProductData? model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 18.0,
          ),
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(height: 200.0, image: NetworkImage("${model!.image}")),
              if (model.oldPrice != 0)
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.pinkAccent,
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
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10.5,
                ),
                Row(
                  children: [
                    Text(
                      "${model.price}",
                      style: TextStyle(color: defeaultColor),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.oldPrice != 0)
                      Text(
                        "${model.oldPrice}",
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                          CubitHomeLayout.get(context).favoriets[model.id]!
                              ? defeaultColor
                              : Colors.grey,
                      child: IconButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          CubitHomeLayout.get(context)
                              .changeFavorItes(model.id);

                          print(TOKEN);
                        },
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItems(DataModel model) =>
      Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        Image(
          height: 100.0,
          width: 100.0,
          image: NetworkImage(
            '${model.image}',
          ),
          fit: BoxFit.cover,
        ),
        Container(
          width: 100,
          height: 20.0,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            ' ${model.name}',
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ]);
}
