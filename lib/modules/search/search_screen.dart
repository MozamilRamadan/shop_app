
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/search_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubits.dart';
import '../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        defaultTextFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validate: (vlaue) {
                            if (vlaue != null && vlaue.isEmpty) {
                              return 'Enter text to search';
                            } else {
                              return null;
                            }
                          },
                          label: 'Search',
                          prefix: Icons.search,
                          onTap: () {},
                          onChange: (String value) {
                            if (formKey.currentState!.validate()) {
                              SearchCubit.get(context).searching(value);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is SearchLoadingState)
                          LinearProgressIndicator(
                            color: defaultColor,
                            backgroundColor: defaultColor.withOpacity(0.3),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is SearchSuccessState)
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                              const SizedBox(
                                height: 1,
                              ),
                              itemBuilder: (context, index) => buildSearchItem(
                                  SearchCubit.get(context)
                                      .model!
                                      .data!
                                      .data![index],
                                  context),
                              itemCount: SearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data!
                                  .length,
                            ),
                          ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }

  Widget buildSearchItem(ProductData model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: 120,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: defaultColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorite(model.id!);
                      },
                      icon: (ShopCubit.get(context).favorite![model.id]!)
                          ? const Icon(
                        Icons.favorite,
                        color: defaultColor,
                      )
                          : const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}