import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit_homelayout.dart';
import 'package:shop_app/models/searchmodel.dart';
import 'package:shop_app/modules/search/cubitsearch.dart';
import 'package:shop_app/modules/search/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var SearchController = TextEditingController();

    return BlocProvider(
       create: (context) => CubitSearch(),
    child: BlocConsumer<CubitSearch, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: formkey,
              child: Column(
                children: [
                
                  defeaultTextFormFiel(
                      onSubmit: (val) {
                        if(formkey.currentState!.validate())
                        CubitSearch.get(context)
                            .getSearch(text: val);
                      },
                      textEditingController: SearchController,
                      label: "Search",
                      prefix: Icons.search,
                      type: TextInputType.text,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Search must not bo empty";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                    if (state is SearchLoadingState)
                     LinearProgressIndicator(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  if (state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: ((context, index) => buildListItems(context: context,model: CubitSearch.get(context).searchModel!.data.data[index])),
                    separatorBuilder: ((context, index) => myDivider()),
                    itemCount: CubitSearch.get(context).searchModel!.data.data.length),
                  ),
        
                ],
              )),
        ),
      ),
    )
    );
  }
}



Widget buildListItems({ProductData? model, context,}) {
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
                  "${model.price}",
                  style: TextStyle(color: defeaultColor),
                ),
                const SizedBox(
                  width: 5.0,
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