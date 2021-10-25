

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends Navigator {

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        title: const Text('Settings')
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
    );
  }
}