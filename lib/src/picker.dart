import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pickers/datetime_picker.dart';
import 'pickers/photo_picker.dart';

class Picker with DateTimePicker, PhotoPicker {
  static Picker of(BuildContext context) => Provider.of<Picker>(
        context,
        listen: false,
      );
}
