import 'dart:io';

import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ozimiz_project/features/ar_list_pages/view/ar_list_pages.dart';
import 'package:ozimiz_project/features/ar_page/view/androidArCorePage.dart';
import 'package:ozimiz_project/features/home_page/bloc/home_bloc.dart';
import 'package:ozimiz_project/features/home_page/view/nav_model.dart';
import 'package:ozimiz_project/features/home_page/widgets/nav_bar.dart';
import 'package:ozimiz_project/service/local_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();

  final profileNavKey = GlobalKey<NavigatorState>();
  final arPageNavKey = GlobalKey<NavigatorState>();

  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = [
      NavModel(page: HomePage(), navKey: profileNavKey),
      NavModel(page: TabPage(tab: 1), navKey: homeNavKey),
    ];
  }

  final homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc..add(LoadHomeEvent()),
      child: WillPopScope(
          child: Scaffold(
            body: IndexedStack(
              index: selectedTab,
              children: items
                  .map((page) => Navigator(
                        key: page.navKey,
                        onGenerateInitialRoutes: (navigator, initialRoute) {
                          return [
                            MaterialPageRoute(builder: (context) => page.page)
                          ];
                        },
                      ))
                  .toList(),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              height: 74.h,
              width: 74.w,
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r)),
                elevation: 0,
                onPressed: () {
                  if (Platform.isIOS) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ArListPages()));
                  } else if (Platform.isAndroid) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ArListPages()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ArListPages()));
                  }
                },
                child: Image.asset('images/scanner.png'),
              ),
            ),
            bottomNavigationBar: NavBar(
                pageIndex: selectedTab,
                onTap: (index) {
                  if (index == selectedTab) {
                    items[index]
                        .navKey
                        .currentState
                        ?.popUntil((route) => route.isFirst);
                  } else {
                    setState(() {
                      selectedTab = index;
                    });
                  }
                }),
          ),
          onWillPop: () {
            if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
              items[selectedTab].navKey.currentState?.pop();
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          }),
    );
  }
}

class TabPage extends StatefulWidget {
  final int tab;

  TabPage({Key? key, required this.tab}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSelectedImage();
  }

  getSelectedImage() async {
    final selectedImagePath = await EventService.getImagePath();
    if (selectedImagePath != null) {
      selectedImage = File(selectedImagePath);
    }
  }

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isSuccess) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SizedBox(
              width: double.infinity,
              child: Column(children: [
                SizedBox(
                  height: 51.h,
                ),
                Text(
                  'Мой профиль',
                  style: TextStyle(color: Colors.white, fontSize: 24.sp),
                ),
                SizedBox(
                  height: 19.h,
                ),
                selectedImage != null
                    ? GestureDetector(
                        onTap: () {
                          _pickImageFromGallery();
                        },
                        child: Image.file(
                          selectedImage!,
                          width: 171.w,
                          height: 171.h,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _pickImageFromGallery();
                        },
                        child: Container(
                          width: 171.w,
                          height: 171.h,
                          color: Colors.grey,
                        ),
                      ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  state.name,
                  style: TextStyle(color: Colors.white, fontSize: 24.sp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      state.phoneNumber,
                      style:
                          TextStyle(color: Color(0xFFABABAB), fontSize: 12.sp),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Image.asset(
                      'images/edit.png',
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 52.h,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(top: 25.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.r),
                          topRight: Radius.circular(60.r))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 57.w),
                          child: Text(
                            'Ваш Id:',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 272.w,
                              height: 59.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFFF0505)),
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Center(
                                child: Text(
                                  state.id,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 57.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Регистрация на розыгрыш',
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 7.h),
                              width: 305.w,
                              height: 85.32.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFF88336)),
                                  borderRadius: BorderRadius.circular(16.r),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFF8888).withOpacity(0.1),
                                        Color(0xFFFF0505).withOpacity(0.1)
                                      ])),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.r),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFF8888),
                                        Color(0xFFFF0505)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )),
                                child: Row(
                                  children: [
                                    Image.asset('images/gift.png'),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Text(
                                      'УЧАСТВУЮ',
                                      style: TextStyle(
                                          fontSize: 20.sp, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ]),
                ))
              ]),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    EventService.storeImage(returnedImage!.path);

    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // print('object');
    // final name = EventService.getName();
    // name.then((value) {
    //   print(value);
    // });
    // print(name);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isSuccess) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 152.w,
                          child: Text(
                            'LUXARY WEEKEND',
                            style:
                                TextStyle(fontSize: 26.sp, color: Colors.white),
                          )),
                      SizedBox(
                        height: 14.h,
                      ),
                      Text(
                        'Осталось до начало:',
                        style: TextStyle(
                            color: Color(0xFFFF0505), fontSize: 21.sp),
                      ),
                      CountDownText(
                        due: DateTime.utc(
                          2024,
                        ),
                        finishedText: "Done",
                        showLabel: true,
                        longDateName: true,
                        daysTextLong: "D ",
                        hoursTextLong: "H ",
                        minutesTextLong: "M ",
                        secondsTextLong: "S ",
                        style: TextStyle(color: Colors.white, fontSize: 30.sp),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 63.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 52.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ваш Id:',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 272.w,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFFFF0505)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.r)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 52.w, vertical: 15.h),
                                child: Text(
                                  state.id,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Color(0xFFFF0505)),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 30.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 29.h, vertical: 23.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.black),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 6.h),
                                    child: Text(
                                      '04.03.2024',
                                      style: TextStyle(),
                                    )),
                                SizedBox(
                                  height: 13.h,
                                ),
                                Text(
                                  'Программа',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 23.h,
                                ),
                                ListEvents(
                                  title:
                                      '''18:00 -сбор гостей, welcome drink's, фуршет, DJ, фотосет на площадке. ''',
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                  title:
                                      '19:00 - начало вечера, анонс программы ведущим.',
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                    title:
                                        '19:10 - приветственная речь генерального партнера Blue Star of Kazakhstan. '),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                    title:
                                        '19:15-  приветственнаяречьгенеральногоспонсора'),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                    title:
                                        '19.20 -приветственная речь  организатора ивент агенства Concierge show'),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                    title:
                                        '19.25 - презентация трека Екатерины Михель «Физика»'),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                    title:
                                        '19:35 -Показ брендов МахМага и Fendi от компании G&G Гламур. '),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                    title:
                                        '19.50-Показ одежды от MoskvaDepartmentStore. РЕГИСТРАЦИЯ НА МЕРОПРИЯТИЕ 20:00 -Презентация автомобилей модели GLE coupe &GLS 600'),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(title: '20:15- выступление артиста'),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                    title:
                                        '20:20 - показ верхней одежды мехового салона Dormani'),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                    title:
                                        '20: 30 - розыгрыш ценных призов от партнеров среди гостей вечера. '),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                    title: '21.00 - вручение благодарственных'),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListEvents(
                                    title:
                                        '21:30 Завершение вечера, торжественный фейерверк'),
                              ]),
                        ),
                        SizedBox(
                          height: 50.h,
                        )
                      ]),
                )
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class ListEvents extends StatelessWidget {
  final String title;
  const ListEvents({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 200.w,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final int tab;
  const Page({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page2 Tab $tab')),
      body: Center(
        child: Text('Tab $tab'),
      ),
    );
  }
}
