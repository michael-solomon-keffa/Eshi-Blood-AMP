import 'package:eshiblood/src/appointment/bloc/blocs.dart';
import 'package:eshiblood/src/appointment/screens/appointment_add.dart';
import 'package:eshiblood/src/auth/bloc/auth_bloc.dart';
import 'package:eshiblood/src/auth/bloc/auth_state.dart';
import 'package:eshiblood/src/request/screen/request_list_screen.dart';
import 'package:eshiblood/src/user/bloc/bottom_navigation_bloc.dart';
import 'package:eshiblood/src/user/bloc/bottom_navigation_event.dart';
import 'package:eshiblood/src/user/bloc/bottom_navigation_state.dart';
import 'package:eshiblood/src/user/screens/donation_card_screen.dart';
import 'package:eshiblood/src/user/screens/donation_history_screen.dart';
import 'package:eshiblood/src/user/screens/setting_screen.dart';
import 'package:eshiblood/src/utilities/constants.dart';
import 'package:eshiblood/src/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_flip_builder/page_flip_builder.dart';
import 'dart:math' as math;

import 'package:sliver_tools/sliver_tools.dart';

class HomeScreen extends StatelessWidget {
  CategoryBrain category = CategoryBrain();

  ScrollController controller = ScrollController();
  final tabs = [
    HomeWidget(),
    RequestListScreen(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ButtomNavigationBloc(),
      child: Scaffold(
          bottomNavigationBar: BottomNavigationWiget(),
          backgroundColor: Color(0xFFD32026),
          body: BlocBuilder<ButtomNavigationBloc, BottomNavigationState>(
            builder: (context, state) {
              return LayoutBuilder(
                builder: (context, c) {
                  return tabs[state.currentIndex];
                },
              );
            },
          )),
    );
  }
}

class _MyAppSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0) as double;
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        final fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
            return (authState is AuthenticationAuthenticated)
                ? Stack(
                    children: [
                      Opacity(
                        opacity: 1 - opacity,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${authState.user!.firstName} ${authState.user!.lastName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    )),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child:
                                          Text('${authState.user!.bloodType}',
                                              style: TextStyle(
                                                color: Color(0xFFD32026),
                                                fontWeight: FontWeight.bold,
                                              )),
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                    ),
                                    SizedBox(width: 6),
                                    (authState.user!.appointed)
                                        ? CircleAvatar(
                                            child: Text(
                                                '${authState.user!.totalDonations * 3}',
                                                style: TextStyle(
                                                  color: Color(0xFFD32026),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            radius: 20,
                                            backgroundColor: Colors.greenAccent,
                                          )
                                        : CircleAvatar(
                                            child: Text(
                                                '${authState.user!.totalDonations * 3}',
                                                style: TextStyle(
                                                  color: Color(0xFFD32026),
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            radius: 20,
                                            backgroundColor: Colors.redAccent,
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: opacity,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    direction: Axis.vertical,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          '${authState.user!.bloodType}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFD32026),
                                              fontSize: 20.0),
                                        ),
                                      ),
                                      Text(
                                        'Blood Type',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        '${Constants.imageBaseUrl}/images/users/${authState.user!.image}'),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    direction: Axis.vertical,
                                    children: [
                                      (authState.user!.appointed)
                                          ? CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                '${authState.user!.totalDonations * 3}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFD32026),
                                                    fontSize: 20.0),
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                '${authState.user!.totalDonations * 3}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFD32026),
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                      Text(
                                        'Lives Saved',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Center(child: Text("Save Blood"));
          },
        );
      },
    );
  }
}

class Category {
  final String name;
  final Icon icon;
  final String? image;

  Category({required this.name, required this.icon, this.image});
}

class CategoryBrain {
  List<Category> category = [
    Category(
        name: 'Donor Card',
        icon: Icon(Icons.request_page_outlined,
            size: 50.0, color: Color(0xFFD32026))),
    Category(
        name: 'Donation History',
        icon:
            Icon(Icons.card_membership, size: 50.0, color: Color(0xFFD32026))),
    Category(
        name: 'Profile',
        icon: Icon(Icons.card_giftcard_outlined,
            size: 50.0, color: Color(0xFFD32026))),
    Category(
        name: 'Eligibility Notice',
        icon: Icon(Icons.history_edu_outlined,
            size: 50.0, color: Color(0xFFD32026))),
    Category(
        name: 'Take a selfie',
        icon: Icon(Icons.camera_alt_outlined,
            size: 50.0, color: Color(0xFFD32026))),
    Category(
        name: 'Settings',
        icon: Icon(Icons.settings, size: 50.0, color: Color(0xFFD32026))),
  ];
}

class BottomNavigationWiget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: state.currentIndex,
          onTap: (int value) {
            context.read<ButtomNavigationBloc>().add(
                  ClickBottomNavigationEvent(currentIndex: value),
                );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xFFD32026),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Request List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}

class HomeWidget extends StatelessWidget {
  CategoryBrain category = CategoryBrain();

  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AppointmentBloc>(context).add(AppointmentLoad());
    return SafeArea(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return (state is AuthenticationAuthenticated)
              ? BlocBuilder<AppointmentBloc, AppointmentState>(
                  builder: (context, aptState) {
                    return (aptState is AppointmentOperationSuccess)
                        ? Container(
                            child: CustomScrollView(
                              physics: ClampingScrollPhysics(),
                              controller: controller,
                              slivers: <Widget>[
                                SliverAppBar(
                                  backgroundColor: Color(0xFFD32026),
                                  expandedHeight: 150.0,
                                  floating: true,
                                  leading: Container(),
                                  snap: true,
                                  elevation: 50.0,
                                  pinned: true,
                                  flexibleSpace: _MyAppSpace(),
                                ),
                                SliverStack(
                                  insetOnOverlap: false,
                                  children: [
                                    SliverPositioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SliverPadding(
                                      padding: EdgeInsets.only(
                                        top: 40,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 20.0,
                                      ),
                                      sliver: SliverToBoxAdapter(
                                        child: (state.user!.appointed)
                                            ? InkWell(
                                                onTap: () {
                                                  aptState.appointments
                                                      .forEach((element) {
                                                    if (element.userId["_id"] ==
                                                            state.user!.id &&
                                                        element.status ==
                                                            "pending") {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              RouteGenerator
                                                                  .appointmentDetail,
                                                              arguments:
                                                                  element);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 2,
                                                        blurRadius: 14,
                                                        color: Colors.grey,
                                                      )
                                                    ],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .calendar_today_rounded,
                                                        size: 50.0,
                                                        color:
                                                            Color(0xFFD32026),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'Manage Appointment',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFD32026),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : state
                                                    .user
                                                    ?.role["privileges"][4]
                                                        ["permissions"]
                                                    .contains("create")
                                                ? DateTime.fromMillisecondsSinceEpoch(int.parse(state.user!.lastDonation ?? '1623501622005'))
                                                                .add(const Duration(
                                                                    days: 90))
                                                                .difference(
                                                                    DateTime
                                                                        .now())
                                                                .inDays >
                                                            0 &&
                                                        DateTime.fromMillisecondsSinceEpoch(int.parse(state
                                                                        .user!
                                                                        .lastDonation ??
                                                                    '1623501622005'))
                                                                .add(const Duration(days: 90))
                                                                .difference(DateTime.now())
                                                                .inDays <
                                                            90
                                                    ? InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 120,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.white60,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                spreadRadius: 2,
                                                                blurRadius: 14,
                                                                color:
                                                                    Colors.grey,
                                                              )
                                                            ],
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .calendar_today_rounded,
                                                                size: 50.0,
                                                                color: Color(
                                                                    0xFFD32026),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              Text(
                                                                '${DateTime.fromMillisecondsSinceEpoch(int.parse(state.user!.lastDonation ?? '1623501622005')).add(const Duration(days: 90)).difference(DateTime.now()).inDays} days left to donate.',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFFD32026),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddAppointment(
                                                                args: AppointmentArgument(
                                                                    edit:
                                                                        false),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 120,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                spreadRadius: 2,
                                                                blurRadius: 14,
                                                                color:
                                                                    Colors.grey,
                                                              )
                                                            ],
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .calendar_today_rounded,
                                                                size: 50.0,
                                                                color: Color(
                                                                    0xFFD32026),
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              Text(
                                                                'Schedule Appointment',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFFD32026),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                : Container(
                                                    width: double.infinity,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          spreadRadius: 2,
                                                          blurRadius: 14,
                                                          color: Colors.grey,
                                                        )
                                                      ],
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'You can not appoint with your current role',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFD32026),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                      ),
                                    ),
                                    SliverPadding(
                                      padding: EdgeInsets.only(
                                        top: 180,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 20.0,
                                      ),
                                      sliver: SliverGrid(
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200.0,
                                          mainAxisSpacing: 30.0,
                                          crossAxisSpacing: 24.0,
                                          childAspectRatio: 1.15,
                                        ),
                                        delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, int index) {
                                            return Material(
                                              color: Colors.white,
                                              elevation: 14,
                                              shadowColor: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: InkWell(
                                                // TODO: Onclick
                                                onTap: () {
                                                  switch (index) {
                                                    case 0:
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PageFlipBuilder(
                                                            frontBuilder: (_) =>
                                                                DonationCardScreen(),
                                                            backBuilder: (_) =>
                                                                DonationHistoryScreen(),
                                                          ),
                                                        ),
                                                      );
                                                      break;
                                                    case 1:
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PageFlipBuilder(
                                                            frontBuilder: (_) =>
                                                                DonationHistoryScreen(),
                                                            backBuilder: (_) =>
                                                                DonationCardScreen(),
                                                          ),
                                                        ),
                                                      );
                                                      break;

                                                    case 2:
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteGenerator
                                                              .profileScreen);
                                                      break;

                                                    case 3:
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteGenerator
                                                              .eligibilityNoticeScreen);
                                                      // Navigator.pushNamed(context,
                                                      //     RouteGenerator.donationHistoryScreen);
                                                      break;

                                                    case 4:
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteGenerator
                                                              .profileScreen);
                                                      break;

                                                    case 5:
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteGenerator
                                                              .setting);
                                                      break;
                                                  }
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 1),
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    15.0)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: <Widget>[
                                                        category.category[index]
                                                            .icon,
                                                        SizedBox(
                                                          height: 4.0,
                                                        ),
                                                        Text(
                                                          category
                                                              .category[index]
                                                              .name,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFD32026),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          childCount: category.category.length,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
