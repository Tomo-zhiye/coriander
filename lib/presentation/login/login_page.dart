import 'package:flutter/material.dart';
import 'package:korianderapp/presentation/login/login_model.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailEditingController = TextEditingController();
    final passwordEditingController = TextEditingController();

    return ChangeNotifierProvider<LogInModel>(
      create: (_) => LogInModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ログイン'),
        ),
        body: Consumer<LogInModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'example@kboy.com'),
                    controller: mailEditingController,
                    onChanged: (val) {
                      model.mail = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'パスワード',
                    ),
                    obscureText: true,
                    controller: passwordEditingController,
                    onChanged: (val) {
                      model.password = val;
                    },
                  ),
                  RaisedButton(
                    child: Text('ログインする'),
                    onPressed: () async {
                      try {
                        await model.logIn();
                        _showDialog(context, 'ようこそ！');
                      } catch (e) {
                        _showDialog(context, e.toString());
                        print(e.toString());
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future _showDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
