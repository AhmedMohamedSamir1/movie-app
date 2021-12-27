import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:movie_app/models/list_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/movie_layout/cubit.dart';
import 'package:movie_app/movie_layout/states.dart';
import 'package:movie_app/shared/components/basics.dart';
import 'package:movie_app/shared/components/components.dart';
import 'package:movie_app/shared/styles/colors.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:movie_app/test.dart';
import 'package:overlay_support/overlay_support.dart';

class MovieDetailsScreen extends StatelessWidget {
  MovieModel movieData;
  String movieGenres;
  var rateController = TextEditingController();
  var listTitleController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double rate = 3;
  String? lstId;
  dynamic lstName;

  MovieDetailsScreen({
    Key? key,
    required this.movieData,
    required this.movieGenres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieLayoutCubit, MovieLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // if(MovieLayoutCubit.get(context).userList.length>0){
        //   lstName = MovieLayoutCubit.get(context).userList[0];
        // }
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: defaultColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Movie Details',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.40,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.35,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              movieData.moviePoster != null
                                  ? 'https://image.tmdb.org/t/p/w500${movieData
                                  .moviePoster}'
                                  : 'https://cdn.staticcrate.com/stock-hd/effects/footagecrate-red-error-icon-prev-full.png',
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${movieData.movieTitle}',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 22, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              movieGenres,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rate,
                                  color: Colors.yellow,
                                  size: 22,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${movieData.voteAverage}',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                      fontSize: 18, color: Colors.white),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${movieData.movieReleaseDate}',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  myDivider(height: 2.5),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              child: IconButton(
                                iconSize: 32,
                                onPressed: () {
                                  displayListDialog(context);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              'add to list',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              child: IconButton(
                                iconSize: 32,
                                onPressed: () {
                                  displayRateDialog(context);
                                },
                                icon: const Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              'rate',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  myDivider(height: 2.5),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Movie Overview',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${movieData.movieOverview}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void displayRateDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(

                title: Center(
                  child: Text(
                    'Rate Movie',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 22),
                  ),
                ),
                actions: [
                  Center(
                    child: RatingBar.builder(
                      initialRating: rate,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      maxRating: 5,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, index) =>
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        rate = rating;
                        rateController.text = rate.toString();
                        print('tate-->' + rating.toString());
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: formKey,
                    child: defaultTextFormField(
                        fieldController: rateController,
                        inputType: TextInputType.number,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "rate can't be empty";
                          } else if (double.parse(val.toString()) < 0.5 ||
                              double.parse(val.toString()) > 5) {
                            return "rate must be between 0.5 and 5 ";
                          }
                        },
                        labelText: 'Enter your rate',
                        borderRadius: 8,
                        prefixIcon: Icons.star_rate,
                        onChange: (String? value) {
                          if (value.toString() != '') {
                            rate = double.parse(value.toString());
                          } else {
                            rate = 0;
                            print('null');
                          }
                          setState(() {});
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: defaultMaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  MovieLayoutCubit.get(context).rateMovie(
                                      movieId: movieData.movieId!,
                                      rate: rate * 2);
                                  Navigator.pop(context);
                                }
                              },
                              btnColor: Colors.green,
                              text: 'submit')),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: defaultMaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: 'cancel'))
                    ],
                  )
                ],
              );
            },
          );
        });
  }

  void displayListDialog(context) {
    var cubit = MovieLayoutCubit.get(context);

    Dialogs.bottomMaterialDialog(
        title: 'Create List',
        msg: 'Are you sure? you want to add \n ${movieData.movieTitle} to list',
        context: context,
        isScrollControlled: true,
        actions: [
          Column(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.25,
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        buildListItem(context, cubit.userLists[index]),
                    separatorBuilder: (context, index) =>
                    const SizedBox(
                      height: 5,
                    ),
                    itemCount: cubit.userLists.length),
              ),

              IconsButton(
                onPressed: () async {
                  if (lstName == null) {
                    showSimpleNotification(
                      const Text(
                        "choose list first",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      position: NotificationPosition.bottom,
                      background: Colors.green,
                    );
                  }
                  else {
                    bool exist = await cubit.isMovieExist(
                        listId: lstId!, movieId: movieData.movieId!);
                    if (exist) {
                      cubit.addMovieToList(
                          listId: lstId!, mediaId: movieData.movieId!);
                      Navigator.pop(scaffoldKey.currentContext!);
                    } else {
                      simpleNotificationMessage(
                          msgText: 'Movie Already exist in list');
                    }
                  }
                },
                text: 'Add to list',
                iconData: Icons.save_alt_rounded,
                color: Colors.deepOrange,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              myDivider(),
              const SizedBox(
                height: 10,
              ),
              IconsButton(
                onPressed: () {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) =>
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.35,
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                            child: Form(
                              key: formKey2,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  defaultTextFormField(
                                    fieldController: listTitleController,
                                    inputType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'List Can Not Be Empty ';
                                      }
                                    },
                                    labelText: 'List Title',
                                    prefixIcon: Icons.title,
                                    borderRadius: 15.0,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  IconsButton(
                                    text: 'Add List',
                                    iconData: Icons.add_box,
                                    color: Colors.deepOrange,
                                    textStyle: const TextStyle(
                                        color: Colors.white),
                                    iconColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    onPressed: () {
                                      if(formKey2.currentState!.validate()){
                                        MovieLayoutCubit.get(context)
                                            .createNewList(listTitle: listTitleController.text,movieId: movieData.movieId!);
                                        Navigator.pop(scaffoldKey.currentContext!);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  )
                      .closed
                      .then((value) {
                    listTitleController.text = '';
                  });
                  Navigator.pop(context);
                },
                text: 'Create new list',
                iconData: Icons.add_box,
                color: Colors.deepOrange,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
              IconsOutlineButton(
                onPressed: () {
                  Navigator.pop(scaffoldKey.currentContext!);
                },
                text: 'Cancel',
                iconData: Icons.cancel_outlined,
                textStyle: const TextStyle(color: Colors.black),
                iconColor: Colors.black,
              ),
            ],
          )
        ]);
  }

  Widget buildListItem(context, ListModel movieList) {
    return InkWell(
      onTap: () {
        print(movieList.listName + ' ' + movieList.listId);
      },
      child: Row(
        children: [
          Transform.scale(
            scale: 1.4,
            child: Radio(
                value: movieList.listName,
                groupValue: lstName,
                onChanged: (value) {
                  //print(value);
                  lstName = value;
                  lstId = movieList.listId;
                  Navigator.pop(context);
                  displayListDialog(context);
                  //MovieLayoutCubit.get(context).radioBtnChanged();
                }),
          ),
          Text(
            movieList.listName,
          )
        ],
      ),
    );
  }


}
