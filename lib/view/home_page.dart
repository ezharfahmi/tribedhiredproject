import 'dart:convert';

import 'package:tribed_hired_assessment/view/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../bloc/menu_bloc.dart';
import '../model/post_model.dart';
import '../repo/endpoint.dart';
import '../repo/repositories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MenuBloc>(
          create: (BuildContext context) => MenuBloc(PostRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Posts List Page'),
        ),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => MenuBloc(
        PostRepository(),
      )..add(LoadMenuEvent()),
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MenuErrorState) {
            return const Center(child: Text("Error"));
          }
          if (state is MenuLoadedState) {
            List<PostsList> menuList = state.menus;
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      final id = menuList[index].id;

                      if (id != null) {
                        Response response =
                            await get(Uri.parse('$getPostEndpoint$id'));

                        if (response.statusCode == 200) {
                          final post =
                              PostsList.fromJson(jsonDecode(response.body));
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuPage(
                                post: post,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${menuList[index].title}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text('${menuList[index].body}')
                            ]),
                      ),
                    ));
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
