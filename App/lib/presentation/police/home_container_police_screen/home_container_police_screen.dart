import 'bloc/home_container_police_bloc.dart';
import 'models/home_container_police_model.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/presentation/citizen/home_page/home_page.dart';
import 'package:rakshak/presentation/citizen/profile_page/profile_page.dart';
import 'package:rakshak/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class HomeContainerPoliceScreen extends StatelessWidget {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<HomeContainerPoliceBloc>(
        create: (context) => HomeContainerPoliceBloc(HomeContainerPoliceState(
            homeContainerPoliceModelObj: HomeContainerPoliceModel(),
            id: arg[NavigationArgs.id],
            station: arg[NavigationArgs.station],
            fullname: arg[NavigationArgs.fullname]))
          ..add(HomeContainerPoliceInitialEvent()),
        child: HomeContainerPoliceScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeContainerPoliceBloc, HomeContainerPoliceState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: ColorConstant.gray50,
              body: Navigator(
                  key: navigatorKey,
                  initialRoute: AppRoutes.homePage,
                  onGenerateRoute: (routeSetting) => PageRouteBuilder(
                      pageBuilder: (ctx, ani, ani1) =>
                          getCurrentPage(context, routeSetting.name!),
                      transitionDuration: Duration(seconds: 0))),
              bottomNavigationBar:
                  CustomBottomBar(onChanged: (BottomBarEnum type) {
                if (type == BottomBarEnum.Report) {
                  NavigatorService.pushNamed(
                    AppRoutes.addReportDetailScreen,
                  );
                } else {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, getCurrentRoute(type));
                }
              })));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Profile:
        return AppRoutes.profilePage;
      case BottomBarEnum.Helpline:
        return AppRoutes.profilePage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage.builder(context);
      case AppRoutes.profilePage:
        return ProfilePage.builder(context);
      default:
        return DefaultWidget();
    }
  }
}
