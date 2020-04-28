import 'package:flutter/material.dart';

import '../global.dart';
import 'action_buttons.dart';

class KeyValueSelectorWidget<T> extends StatelessWidget {
  const KeyValueSelectorWidget({
    Key key,
    this.keyText,
    this.valueText,
    this.keyStyle = const TextStyle(
      color: const Color(0xff666666),
      fontSize: 15,
    ),
    this.valueStyle = const TextStyle(
      color: const Color(0xff252525),
      fontSize: 18,
    ),
    this.hintStyle = const TextStyle(
      color: const Color(0xff999999),
      fontSize: 18,
    ),
    this.keyWidget,
    this.valueWidget,
    this.hintText = "请选择",
    this.onSaved,
    this.validator,
    this.initialValue,
    this.autovalidate = false,
    this.enabled = true,
    this.onPressed,
    this.suffix,
  }) : super(key: key);

  final String keyText;
  final String valueText;
  final TextStyle keyStyle;
  final TextStyle valueStyle;
  final TextStyle hintStyle;
  final Widget keyWidget;
  final Widget valueWidget;
  final Widget suffix;
  final String hintText;

  /// An optional method to call with the final value when the form is saved via
  /// [FormState.save].
  final FormFieldSetter<T> onSaved;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  ///
  /// The returned value is exposed by the [FormFieldState.errorText] property.
  /// The [TextFormField] uses this to override the [InputDecoration.errorText]
  /// value.
  ///
  /// Alternating between error and normal state can cause the height of the
  /// [TextFormField] to change if no other subtext decoration is set on the
  /// field. To create a field whose height is fixed regardless of whether or
  /// not an error is displayed, either wrap the  [TextFormField] in a fixed
  /// height parent like [SizedBox], or set the [TextFormField.helperText]
  /// parameter to a space.
  final FormFieldValidator<T> validator;

  /// An optional value to initialize the form field to, or null otherwise.
  final T initialValue;

  /// If true, this form field will validate and update its error text
  /// immediately after every change. Otherwise, you must call
  /// [FormFieldState.validate] to validate. If part of a [Form] that
  /// auto-validates, this value will be ignored.
  final bool autovalidate;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidate] is true, the field will be validated.
  /// Likewise, if this field is false, the widget will not be validated
  /// regardless of [autovalidate].
  final bool enabled;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: buildContent,
      initialValue: initialValue,
      autovalidate: autovalidate,
      enabled: enabled,
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget buildContent(FormFieldState<T> state) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (keyWidget != null)
                  keyWidget
                else
                  Text(
                    keyText ?? NDP,
                    style: keyStyle,
                  ),
                if (valueWidget != null)
                  DefaultTextStyle(
                    style: valueStyle,
                    child: valueWidget,
                  )
                else
                  Text(
                    valueText ?? hintText ?? "",
                    style: (valueText?.isNotEmpty ?? false)
                        ? valueStyle
                        : hintStyle,
                  )
              ],
            ),
          ),
          if (enabled) suffix ?? ArrowButton(onPressed: onPressed),
        ],
      ),
    );
  }
}
