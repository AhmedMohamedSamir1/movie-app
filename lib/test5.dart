import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Test6 extends StatelessWidget {
  const Test6 ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Container(
              height: MediaQuery.of(context).size.height*0.41,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children:  [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(10),
                          topStart: Radius.circular(10),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: const Image(
                          image: NetworkImage(
                            'https://free4kwallpapers.com/uploads/originals/2015/10/04/eiffel-beautiful-view-at-night.jpg',
                        )
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 5,
                        color: Colors.white,
                      )
                    ),
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width*0.16,
                      backgroundImage: const NetworkImage(
                        'https://kittyinpink.co.uk/wp-content/uploads/2016/12/facebook-default-photo-male_1-1.jpg',
                      )

                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
