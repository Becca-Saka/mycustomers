import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

import '../../../core/mixings/validators.dart';
import '../../widgets/shared/custom_raised_button.dart';
import '../../widgets/shared/social_icon.dart';
import 'authentication_viewmodel.dart';

class AuthenticationView extends StatelessWidget with Validators {

  TextEditingController inputNumberController = new TextEditingController();
  final _key = GlobalKey<ScaffoldState>();
  /// A reusable text style
  /// Can be moved to a mixin or constant
  final regularTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    color: Colors.black,
  );

  /// Reusable height space weights
  /// Can be moved to a mixin or constant
  final mediumVerticalHeight = SizedBox(
    height: 16.0,
  );

  final smallVerticalHeight = SizedBox(
    height: 8.0,
  );


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        key: _key,
        body: Container(
          height: height/2,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/auth_background.png',
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(
                          'assets/images/heading.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
//        bottomSheet: inputNameBottomWidget(height, model, context),
        bottomSheet: inputNumberBottomWidget(height, model, context),
//        bottomSheet: modalBottomWidget(height),
      ),
      viewModelBuilder: () => AuthenticationViewModel(),
    );
  }
  Widget inputNumberBottomWidget(double height,
      AuthenticationViewModel model,
      BuildContext context) {
    return Container(
      height: height/2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Please, Enter your Phone Number',
              style: TextStyle(color: Colors.black, fontSize: 16.sp,),),
            SizedBox(width: 5.h,),
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey[400].withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.w),
              ),

              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                children: <Widget>[
                  DropdownButton<String>(
                    value: model.dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: 25.w,
                    elevation: 16,
                    onChanged: (String data){
                      model.setDropdownValue(data);
                    },
                    items: model.dropdownItems.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Container(width: 1.w,color: Colors.black.withOpacity(0.3),),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: TextField(
                      controller: inputNumberController, decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number'
                    ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5.h,),
            Text('or Continue with your social accounts',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF02034A), fontSize: 16.sp,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIconButton(
                  onTap: () {},
                  socialIconUrl: 'assets/images/google_icon.png',
                ),
                SocialIconButton(
                  onTap: () {},
                  socialIconUrl: 'assets/images/facebook_icon.png',
                ),
                SocialIconButton(
                  onTap: () {},
                  socialIconUrl: 'assets/images/apple_icon.png',
                ),
              ],
            ),
            InkWell(
              onTap: (){
                _key.currentState.
                showBottomSheet( (context)=> modalBottomWidget(height),
                );
              },
              child: Container(
                height: 50.h,
                decoration:BoxDecoration(
                  color: Color(0xFF333CC1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Next',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp,),),
                    SizedBox(width: 10.h),
                    Icon(Icons.arrow_forward, color: Colors.white,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget modalBottomWidget(double height) {
    return Container(
      height: height/2.5,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF263BBA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.w),
            topRight: Radius.circular(24.w),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10.h),
            Text(
              'PASTE FROM SMS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              '0349',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    PinCodeTextField(
                      length: 4,
                      obsecureText: false,
                      animationType: AnimationType.scale,
                      textInputType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        selectedColor: Colors.black,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        borderWidth: 1,
                        fieldWidth: ScreenUtil.screenWidthDp * 0.15,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      //errorAnimationController: errorController,
                      //controller: textEditingController,
                      autoDisposeControllers: false,
                      onCompleted: (v) {},
                      onChanged: (value) {},
                    ),
                    Center(
                      child: Text(
                        'Please enter 4-digit code we sent on \nyour number as SMS',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget inputNameBottomWidget(double height,
      AuthenticationViewModel model,
      BuildContext context){
    return Container(
      height: height/2.5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("What's your name",
              style: TextStyle(color: Colors.black, fontSize: 16.sp,),),
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey[400].withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.w),
              ),

              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                children: <Widget>[
                  Container(width: 30.w),
                  Container(width: 1.w,color: Colors.black.withOpacity(0.3),),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: TextField(
                      controller: inputNumberController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Name'
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: (){},
                  child: Container(
                    height: 50.h,
                    width: 60.w,
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF000E66)
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.white,),
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Container(
                      height: 50.h,
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF333CC1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Next',
                            style: TextStyle(color: Colors.white, fontSize: 16.sp,),),
                          SizedBox(width: 10.h),
                          Icon(Icons.arrow_forward, color: Colors.white,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




