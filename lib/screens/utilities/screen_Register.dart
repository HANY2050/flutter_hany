/*
import 'package:flutter/material.dart';
import 'package:generalshops/api/authentication.dart';

import '../home_page.dart';

class ScreenRegister extends StatefulWidget {
  //const ScreenRegister({Key? key}) : super(key: key);
  final String firstName, lastName, email, password, phoneNumber;

  @override
  const ScreenRegister(this.firstName, this.lastName, this.email, this.password,
      this.phoneNumber);

  _ScreenRegisterState createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        "الاسم الاول",
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 48),
                        child: Text(
                          widget.firstName,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "الاسم الاخير",
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 63),
                        child: Text(
                          widget.lastName,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "رقم الهاتف",
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 37),
                        child: Text(
                          widget.phoneNumber,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "الايميل",
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 37),
                        child: Text(
                          widget.email,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  ),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    String first_name = widget.firstName;
                    String last_name = widget.lastName;
                    String mobile = widget.phoneNumber;
                    String email = widget.email;
                    String password = widget.password;
                    final user = await authentication.register(
                        first_name, last_name, email, password, mobile);
                    if (user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      print('true');
                    } else {
                      print('false');
                    }
                  },
                  color: Color(0xFFB41305),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'حفظ ومتابعة التسوق',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(100),
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
