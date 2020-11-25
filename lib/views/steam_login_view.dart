import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:steam_lib/cubit/steam_cubit.dart';

class SteamLoginPage extends StatefulWidget {
  @override
  _SteamLoginPageState createState() => _SteamLoginPageState();
}

class _SteamLoginPageState extends State<SteamLoginPage> {
  TextEditingController _steamIdController;

  @override
  void initState() {
    _steamIdController ??= TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _steamIdController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Steameo'),
        ),
        body: Center(
            child: _SteamLoginView(
          controller: _steamIdController,
        )),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurpleAccent,
          label: Text('Connect'),
          icon: Icon(
            FontAwesomeIcons.steam,
          ),
          onPressed: () async {
            if (_steamIdController.text.isNotEmpty) {
              final steamCubit = context.read<SteamCubit>();
              if (steamCubit.state != SteamUserLoading()) {
                // valid
                // await steamCubit.getUserProfile('76561197985266024');
                // invalid
                await steamCubit.getUserProfile(_steamIdController.text);
              } else {
                print(
                    'ignoring onPressed already fired... connection in progress.');
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.exclamationTriangle,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Please input a Steam Id.'),
                    ],
                  )));
            }
          },
        ),
      ),
    );
  }
}

Widget _buildLoading() => Center(
      child: CircularProgressIndicator(),
    );

Widget _buildInitialInput(TextEditingController controller) {
  return Form(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 40,
        ),
        Icon(
          FontAwesomeIcons.steamSymbol,
          size: 120,
          color: Colors.white,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                labelText: 'Steam Id',
                errorMaxLines: 1,
                focusColor: Colors.white,
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  FontAwesomeIcons.userNinja,
                  color: Colors.white,
                )),
            controller: controller,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            print('pop up info on steam Id');
          },
          child: Text('where can i find my Steam Id?',
              style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

class _SteamLoginView extends StatelessWidget {
  final TextEditingController controller;

  const _SteamLoginView({Key key, @required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: BlocConsumer<SteamCubit, SteamState>(
        listener: (BuildContext context, state) {
          if (state is SteamUserError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(state.errorMessage),
              ],
            )));
          } else if (state is SteamUserLoaded) {
            //Navigator.of(context).pushReplacement(HomeView);
            print('TODO: how do we navigate to home from here?');
          }
        },
        builder: (BuildContext context, state) {
          if (state is SteamInitial) {
            return _buildInitialInput(controller);
          } else if (state is SteamUserLoading) {
            return _buildLoading();
          } else {
            // (state is WeatherError)
            return _buildInitialInput(controller);
          }
        },
      ),
    );
  }
}
