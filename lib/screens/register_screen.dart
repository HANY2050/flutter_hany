import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generalshops/widgets/textfield_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../otp.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String firstName,
      lastName,
      city,
      address,
      email,
      password,
      phoneNumber,
      countryCode = 'مفتاح الدولة';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16),
            child: ResponsiveBuilder(
              builder: (context, sizingInfo) => Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hint: 'الاسم الاول',
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجئ ادخال الاسم الاول';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            firstName = value;
                          });
                        },
                        type: TextInputType.name,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hint: 'الاسم الاخير',
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجئ ادخال الاسم الاخير';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            lastName = value;
                          });
                        },
                        type: TextInputType.name,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hint: 'المدينة',
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجئ ادخال المدينة';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            city = value;
                          });
                        },
                        type: TextInputType.name,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hint: 'العنوان',
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجئ ادخال العنوان';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            address = value;
                          });
                        },
                        type: TextInputType.name,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hint: 'الايميل',
                        onChanged: (String value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجئ ادخال الايميل';
                          }
                          return null;
                        },
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hint: 'كلمة المرور',
                        isPassword: true,
                        onChanged: (String value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجئ ادخال كلمة المرور';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        isPassword: true,
                        hint: 'تأكيد كلمة المرور',
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجئ ادخال تأكيد كلمة المرور';
                          } else if (value != password) {
                            return 'كلمات المرور غير متطابقة';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        onChanged: (newValue) {
                          setState(() {
                            phoneNumber = countryCode + newValue;
                          });
                        },
                        prefixIcon: TextButton(
                          child: Text(
                            countryCode,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                onSelect: (country) {
                                  setState(() {
                                    countryCode = '+' + country.phoneCode;
                                  });
                                });
                          },
                        ),
                        hint: 'رقم الهاتف',
                        validator: (String value) {
                          if (value == null ||
                              value.isEmpty ||
                              countryCode == 'مفتاح الدولة') {
                            return 'يرجئ ادخال رقم الهاتف و مفتاح الدولة';
                          }
                          return null;
                        },
                        type: TextInputType.number,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => OTPScreen(
                                    firstName: firstName,
                                    lastName: lastName,
                                    city: city,
                                    address: address,
                                    email: email,
                                    password: password,
                                    phoneNumber: phoneNumber),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(sizingInfo.screenSize.width * 0.4,
                              sizingInfo.screenSize.width * 0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('تسجيل '),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
