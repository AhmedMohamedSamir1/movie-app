import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/list_movies/list_movies_screen.dart';
import 'package:movie_app/models/list_model.dart';
import 'package:movie_app/movie_layout/cubit.dart';
import 'package:movie_app/movie_layout/states.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/styles/icon_broken.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class UserListsScreen extends StatelessWidget {
  const UserListsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = MovieLayoutCubit.get(context);
    return BlocConsumer<MovieLayoutCubit, MovieLayoutStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              left: 10,
              right: 10.0,
            ),
            child: ListView.separated(
                itemBuilder: (context, index) =>
                    buildListItem(context, cubit.userLists[index], index),
                separatorBuilder: (context, index) => myDivider(
                  height: 2,
                ),
                itemCount: cubit.userLists.length),
          ),
        );
      },

    );
  }

  Widget buildListItem(context, ListModel listModel, int index) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text(
              listModel.listName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 22, color: Colors.white),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  clearList(context, listModel.listName, listModel.listId);
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 26,
                )),
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                  deleteList(context, listModel.listName, listModel.listId, index);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 26,
                )),
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                  MovieLayoutCubit.get(context).getListMovies(listId: listModel.listId);
                  navigateTo(context, ListMoviesScreen(listModel: listModel));
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                  size: 26,
                )),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  void clearList(context, String lstName, String lstId) {
    StylishDialog(
      context: context,
      alertType: StylishDialogType.INFO,
      titleText: 'Clear List',
      contentText: 'Are you sure that you want to clear $lstName list',
      confirmButton: MaterialButton(
        color: Colors.green,
        onPressed: () {
          MovieLayoutCubit.get(context).clearList(listId: lstId);
          Navigator.pop(context);
        },
        child: (const Text(
          'OK',
          style: TextStyle(color: Colors.white),
        )),
      ),
      cancelButton: MaterialButton(
        color: Colors.green,
        onPressed: () {
          Navigator.pop(context);
        },
        child: (const Text(
          'cancel',
          style: TextStyle(color: Colors.white),
        )),
      ),
    ).show();
  }
  void deleteList(context, String lstName, String lstId, int index) {
    StylishDialog(
      context: context,
      alertType: StylishDialogType.WARNING,
      titleText: 'delete List',
      contentText: 'Are you sure that you want to delete $lstName list',
      confirmButton: MaterialButton(
        color: Colors.green,
        onPressed: () {
         // MovieLayoutCubit.get(context).userLists.removeAt(index);
          MovieLayoutCubit.get(context).removeListFromFireStore(lstId);
          Navigator.pop(context);
        },
        child: (const Text(
          'OK',
          style: TextStyle(color: Colors.white),
        )),
      ),
      cancelButton: MaterialButton(
        color: Colors.green,
        onPressed: () {
          Navigator.pop(context);
        },
        child: (const Text(
          'cancel',
          style: TextStyle(color: Colors.white),
        )),
      ),
    ).show();
  }
}
