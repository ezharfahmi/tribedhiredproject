import 'package:tribed_hired_assessment/model/comment_model.dart';
import 'package:tribed_hired_assessment/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/menu_bloc.dart';
import '../repo/repositories.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.post});

  final PostsList post;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final filterController = TextEditingController();
  String filterText = '';

  @override
  void dispose() {
    filterController.dispose();
    super.dispose();
  }

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
          title: const Text('Post Page'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.post.title}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text('${widget.post.body}'),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: filterController,
                onChanged: (value) => setState(() {
                  filterText = value;
                }),
                decoration: const InputDecoration(
                  hintText: 'Filter Comment',
                  suffixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
              Expanded(
                child: blocBody(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget blocBody() {
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => MenuBloc(
        PostRepository(),
      )..add(LoadCommentEvent(id: widget.post.id)),
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is GetCommentLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetCommentError) {
            return const Center(child: Text("Error"));
          }
          if (state is GetCommentLoadedState) {
            List<CommentList> commentList = state.comment;

            List newList = commentList
                .where((x) =>
                    (x.email!.toLowerCase().contains(filterText)) ||
                    x.body!.toLowerCase().contains(filterText) ||
                    x.name!.toLowerCase().contains(filterText))
                .toList();

            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: newList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.teal.shade200),
                              child: const Icon(Icons.person),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Card(
                              child: SizedBox(
                                  width: width / 1.5,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${newList[index].email}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal,
                                              fontSize: 16),
                                        ),
                                        Text('${newList[index].body}')
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        )
                      ]),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
