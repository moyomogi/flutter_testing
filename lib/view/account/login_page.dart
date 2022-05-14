import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_testing/screen.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/utils/firestore.dart';
import 'package:flutter_testing/view/account/create_account_page.dart';
//import 'package:flutter_login.dart';

const Color kAccentColor = Color(0xFFFE7C64);
const Color kBackgroundColor = Colors.white;
const Color kTextColorPrimary = Color(0xFFECEFF1);
const Color kTextColorSecondary = Color(0xFFB0BEC5);
const Color kButtonColorPrimary = Color(0xFFECEFF1);
const Color kButtonTextColorPrimary = Color(0xFF455A64);
const Color kIconColor = Color(0xFF455A64);


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _Header(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _SignInForm(),
              ),
              /*Padding(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: _Footer(),
              ),*/

              /* ここに、ヘッダー・フォーム・フッターを並べていく */
            ],
          ),
        ),
      ),
    );
  }
}

// ヘッダー作成
class _HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height,
        size.width,
        size.height * 0.6,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _HeaderBackground extends StatelessWidget {
  final double height;

  const _HeaderBackground({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _HeaderCurveClipper(),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              Color(0xFFFD9766),
              Color(0xFFFF7362),
            ],
            stops: [0, 1],
          ),
        ),
      ),
    );
  }
}

//戻るui
class _HeaderCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.4),
      12,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.2),
      12,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _HeaderCircles extends StatelessWidget {
  final double height;

  const _HeaderCircles({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HeaderCirclePainter(),
      child: Container(
        width: double.infinity,
        height: height,
      ),
    );
  }
}

//タイトル（タイトルuiの上）
class _HeaderTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '大阪公立大学生向けSNS(仮称)',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: kTextColorPrimary,
                fontWeight: FontWeight.w500,
              ),
        ),
        /*SizedBox(height: 4),
        Text(
          '登録画面',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: kTextColorPrimary),
        ),*/
      ],
    );
  }
}

//戻るボタン（もどるUIの上）
/*class _HeaderBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: kButtonTextColorPrimary,
        backgroundColor: Colors.transparent,
        shape: CircleBorder(
          side: BorderSide(color: kButtonColorPrimary),
        ),
      ),
      onPressed: () {},
      child: Icon(Icons.chevron_left, color: kIconColor),
    );
  }
}*/

//タイトル
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = 320;
    return Container(
      height: height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _HeaderBackground(height: height),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: _HeaderCircles(height: height),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 128),
              child: _HeaderTitle(),
            ),
          ),
          /*Positioned(
            top: 16,
            left: 0,
            child: _HeaderBackButton(),
          ),*/
        ],
      ),
    );
  }
}

//フォーム作成
class _CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String decoration;
  final bool obscureText;

  const _CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    required this.decoration,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      obscureText: obscureText,

      onTap: () {},
    );
  }
}

//入力画面
class _SignInForm extends StatelessWidget {
  String newEmail = "";
  String newPassword = "";
  String infoText = "";
  bool pswdOk = false;
  final controller = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
            controller: emailController,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'メールアドレスを入力してください',
            ),

            //適切なメールアドレスに誘導する
            onChanged: (String value) {
              newEmail = value;
            }),
        SizedBox(height: 48),
        TextFormField(
            controller: passController,
            decoration: const InputDecoration(
              labelText: 'Pass',
              hintText: 'パスワードを入力してください(8文字以上)',
            ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            maxLength: 20,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (value) {
              if (value.length >= 8) {
                newPassword = value;

                print('ok'); //
              } else {
                //入力した文字列をリセットしたい or エラー文を表示させたい

                pswdOk = false;
              }
            }

            //パスワード文字数判別
            ),
        /*SizedBox(height: 8),
        TextFormField(
            decoration: const InputDecoration(
              labelText: 'rewrite Pass',
              hintText: '確認用パスワードを入力',
              fillColor:Colors.white,
            ),
            obscureText: true,
            maxLength: 20,
            onFieldSubmitted: (String? value1) {
              if (value1 == newPassword) {
                pswdOk = true;
              } else if (value1 != newPassword) {
                // 入力した文字列をリセットしたい
                controller.clear();
                print('no');
              } //パスワード文字数判別
            }),*/
        /*Text(
          'パスワードを忘れましたか？',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorSecondary),
        ),
        SizedBox(height: 48),*/
        Container(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              primary: kButtonTextColorPrimary,
              backgroundColor: kButtonColorPrimary,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async{
              //条件
              var result = await Authentication.emailSignIn(email: emailController.text, pass: passController.text);
              if(result is UserCredential){
                print(result.user!.uid);
                var _result = await Firestore.getUser(result.user!.uid);
                if(_result == true){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Screen(0)));
                }
                print("サインイン成功、別の画面飛ぶ");
              }
            },
            child: Text(
              'Sign in',
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: kButtonTextColorPrimary, fontSize: 18),
            ),
          ),
        ),
        SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey),
            children: [
              TextSpan(text: 'Don\'t have Account?'),
              TextSpan(text: 'Sign up',
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()..onTap = (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage()));
              }
              ),
            ]
          )
        ),

        /*Text(
          'Don\'t have Account?',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorSecondary),
        ),
        Text(
          'Sign up',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorPrimary),
        ),*/
        /*Text(
          'OR',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorSecondary),
        ),
        SizedBox(height: 16),
        Text(
          'Connect with',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorPrimary),
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
            Container(
              color: kTextColorSecondary,
              width: 1,
              height: 16,
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
        )*/
      ],
    );
  }
}

//テキスト作成
/*class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have Account?',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorSecondary),
        ),
        SizedBox(width: 4),
        Text(
          'Sign up',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: kTextColorPrimary),
        ),
      ],
    );
  }
}*/



/// ボタン押下時
/*void _validateAndSubmit(AuthViewModel viewModel) async {
  if (_validateAndSave()) {
    await viewModel.addUser(
      email: _email!,
      password: _password!,
    );
  }
}*/