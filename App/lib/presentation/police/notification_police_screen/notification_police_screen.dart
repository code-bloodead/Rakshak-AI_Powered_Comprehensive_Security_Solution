import 'bloc/notification_police_bloc.dart';
import 'package:rakshak/data/models/notification/notification_model.dart'
    as notification;
import 'models/notification_police_model.dart';
import 'widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/core/app_export.dart';
import 'package:rakshak/widgets/app_bar/appbar_iconbutton_1.dart';
import 'package:rakshak/widgets/app_bar/appbar_subtitle.dart';
import 'package:rakshak/widgets/app_bar/custom_app_bar.dart';
import 'package:rakshak/widgets/custom_button.dart';

class NotificationPoliceScreen extends StatelessWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<NotificationPoliceBloc>(
        create: (context) => NotificationPoliceBloc(NotificationPoliceState(
            notificationPoliceModelObj: NotificationPoliceModel()))
          ..add(NotificationPoliceInitialEvent()),
        child: NotificationPoliceScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            appBar: CustomAppBar(
                height: getVerticalSize(48),
                leadingWidth: 64,
                leading: AppbarIconbutton1(
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 24, top: 16),
                    onTap: () {
                      onTapArrowleft(context);
                    }),
                centerTitle: true,
                title: AppbarSubtitle(
                  text: "lbl_notification".tr,
                  margin: getMargin(top: 16),
                )),
            body: Container(
                width: double.maxFinite,
                padding: getPadding(left: 24, top: 35, right: 24, bottom: 35),
                child: BlocSelector<NotificationPoliceBloc,
                    NotificationPoliceState, NotificationPoliceModel>(
                  selector: (state) => state.notificationPoliceModelObj,
                  builder: (context, notificationPoliceModelObj) {
                    return notificationPoliceModelObj.todayList.length == 0 &&
                            notificationPoliceModelObj.thisWeekList.length == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                CustomImageView(
                                    margin: getMargin(top: 24),
                                    alignment: Alignment.center,
                                    svgPath: ImageConstant.imgMailnotification,
                                    height: getVerticalSize(204),
                                    width: getHorizontalSize(255)),
                                Padding(
                                    padding: getPadding(
                                      top: 31,
                                      left: 41,
                                    ),
                                    child: Text("msg_no_notification".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: AppStyle.txtManropeExtraBold20
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.2)))),
                                Container(
                                    width: getHorizontalSize(292),
                                    margin: getMargin(top: 9),
                                    child: Text("msg_no_notification2".tr,
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                        style: AppStyle.txtManrope16.copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.3)))),
                                CustomButton(
                                    height: getVerticalSize(45),
                                    text: "msg_notifications_s".tr,
                                    margin: getMargin(
                                        left: 36,
                                        top: 21,
                                        right: 37,
                                        bottom: 5),
                                    shape: ButtonShape.RoundedBorder10,
                                    fontStyle:
                                        ButtonFontStyle.ManropeBold14Blue500_1,
                                    variant: ButtonVariant.OutlineBlue500,
                                    padding: ButtonPadding.PaddingAll12,
                                    onTap: () {
                                      onTapNotificationssettings(context);
                                    })
                              ])
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container(
                                    child: notificationPoliceModelObj
                                                .todayList.length >
                                            0
                                        ? Row(
                                            children: [
                                              Text("lbl_today".tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle
                                                      .txtManropeBold16
                                                      .copyWith(
                                                          letterSpacing:
                                                              getHorizontalSize(
                                                                  0.2))),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () =>
                                                    onTapMarkAllAsRead(context),
                                                child: Text(
                                                    (notificationPoliceModelObj
                                                                    .todayList
                                                                    .length +
                                                                notificationPoliceModelObj
                                                                    .thisWeekList
                                                                    .length) >
                                                            1
                                                        ? "lbl_mark_all_as_read"
                                                            .tr
                                                        : "lbl_mark_as_read".tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtManropeBold12Blue500
                                                        .copyWith(
                                                            letterSpacing:
                                                                getHorizontalSize(
                                                                    0.2))),
                                              )
                                            ],
                                          )
                                        : Container()),
                                Padding(
                                    padding: getPadding(top: 15),
                                    child: notificationPoliceModelObj
                                                .todayList.length >
                                            0
                                        ? ListView.separated(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                  height: getVerticalSize(14));
                                            },
                                            itemCount:
                                                notificationPoliceModelObj
                                                    .todayList.length,
                                            itemBuilder: (context, index) {
                                              notification.Notification model =
                                                  notificationPoliceModelObj
                                                      .todayList[index];
                                              return NotificationWidget(model);
                                            })
                                        : Container()),
                                Container(
                                    child:
                                        notificationPoliceModelObj
                                                    .thisWeekList.length >
                                                0
                                            ? Padding(
                                                padding: getPadding(top: 22),
                                                child: Row(
                                                  children: [
                                                    Text("lbl_this_week".tr,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: AppStyle
                                                            .txtManropeBold16
                                                            .copyWith(
                                                                letterSpacing:
                                                                    getHorizontalSize(
                                                                        0.2))),
                                                    Spacer(),
                                                    Container(
                                                      child:
                                                          notificationPoliceModelObj
                                                                      .todayList
                                                                      .length ==
                                                                  0
                                                              ? GestureDetector(
                                                                  onTap: () =>
                                                                      onTapMarkAllAsRead(
                                                                          context),
                                                                  child: Text(
                                                                      (notificationPoliceModelObj.thisWeekList.length + notificationPoliceModelObj.todayList.length) > 1
                                                                          ? "lbl_mark_all_as_read"
                                                                              .tr
                                                                          : "lbl_mark_as_read"
                                                                              .tr,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: AppStyle
                                                                          .txtManropeBold12Blue500
                                                                          .copyWith(
                                                                              letterSpacing: getHorizontalSize(0.2))),
                                                                )
                                                              : Container(),
                                                    )
                                                  ],
                                                ))
                                            : Container()),
                                Padding(
                                    padding: getPadding(top: 17),
                                    child: notificationPoliceModelObj
                                                .thisWeekList.length >
                                            0
                                        ? ListView.separated(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                  height: getVerticalSize(14));
                                            },
                                            itemCount:
                                                notificationPoliceModelObj
                                                    .thisWeekList.length,
                                            itemBuilder: (context, index) {
                                              notification.Notification model =
                                                  notificationPoliceModelObj
                                                      .thisWeekList[index];
                                              return NotificationWidget(model);
                                            })
                                        : Container())
                              ]);
                  },
                ))));
  }

  onTapArrowleft(BuildContext context) {
    NavigatorService.goBack();
  }

  onTapMarkAllAsRead(BuildContext context) {
    // TODO: implement onTapMarkAllAsRead via API call
  }

  onTapNotificationssettings(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.profilePolicePage,
    );
  }
}
