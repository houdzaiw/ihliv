import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  DatePicker(this.title, {Key? key, required this.initDate, required this.onValuePicked, this.minimumDate, this.maximumDate}) : super(key: key);

  final DateTime initDate;
  final String title;
  final ValueChanged<DateTime> onValuePicked;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  final _kPickerSheetHeight = 160.0;
  var _datetime;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(title, style: const TextStyle(fontSize: 16, color: CupertinoColors.black)),
      message: Container(
        height: _kPickerSheetHeight,
        color: Colors.transparent,
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
          child: GestureDetector(
            // Blocks taps from propagating to the modal sheet and popping.
            onTap: () {},
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initDate,
              minimumDate: minimumDate,
              maximumDate: maximumDate,
              onDateTimeChanged: (DateTime newDateTime) {
                _datetime = newDateTime;
              },
            ),
          ),
        ),
      ),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text('Done'),
          onPressed: () {
            Navigator.pop(context);
            if (_datetime != null) {
              onValuePicked(_datetime);
            }
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        isDefaultAction: true,
        onPressed: (() {
          Navigator.pop(context, 'Cancel');
        }),
      ),
    );
  }
}

class LanguagePicker extends StatelessWidget {
  LanguagePicker(this.title, {Key? key, this.language, required this.onValuePicked}) : super(key: key);

  final String title;
  String? language;

  final ValueChanged<String?> onValuePicked;

  final _kPickerSheetHeight = 160.0;
  final _languageList = ["English", "Spanish", "Arabic", "French", "Russian", "Portuguese", "Hindi", "Chinese", "Other"];

  @override
  Widget build(BuildContext context) {
    var defaultIndex = 0;
    if (language != null) {
      defaultIndex = _languageList.indexOf(language!);
    }
    return CupertinoActionSheet(
      title: Text(title, style: const TextStyle(fontSize: 16, color: CupertinoColors.black)),
      message: Container(
        height: _kPickerSheetHeight,
        color: Colors.transparent,
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: defaultIndex),
            onSelectedItemChanged: (int value) {
              language = _languageList[value];
            },
            itemExtent: 30,
            children: _languageList.map((e) {
              return Text(e);
            }).toList(),
          ),
        ),
      ),
      actions: [
        CupertinoActionSheetAction(
          child: const Text('Done'),
          onPressed: () {
            Navigator.pop(context);
            onValuePicked(language ?? _languageList.first);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text("Cancel"),
        isDefaultAction: true,
        onPressed: (() {
          Navigator.pop(context, 'Cancel');
        }),
      ),
    );
  }
}

class GenderPicker extends StatelessWidget {
  GenderPicker(this.title, {Key? key, required this.onValuePicked}) : super(key: key);

  final String title;
  final ValueChanged<String> onValuePicked;

  final _genderList = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(title, style: const TextStyle(fontSize: 16, color: CupertinoColors.black)),
      actions: _genderList.map((e) {
        return CupertinoActionSheetAction(
          child: Text(e),
          onPressed: () {
            Navigator.pop(context);
            onValuePicked(e);
          },
        );
      }).toList(),
      cancelButton: CupertinoActionSheetAction(
        child: const Text("Cancel"),
        isDefaultAction: true,
        onPressed: (() {
          Navigator.pop(context, 'Cancel');
        }),
      ),
    );
  }
}

class CountryPicker extends StatelessWidget {
  CountryPicker(this.title, {Key? key, this.country, required this.onValuePicked}) : super(key: key);
  final String title;
  String? country;
  final ValueChanged<String> onValuePicked;

  final _kPickerSheetHeight = 160.0;

  final _countryList = [
    'AF',
    'AX',
    'AL',
    'DZ',
    'AS',
    'AD',
    'AO',
    'AI',
    'AQ',
    'AG',
    'AR',
    'AM',
    'AW',
    'AU',
    'AT',
    'AZ',
    'BS',
    'BH',
    'BD',
    'BB',
    'BY',
    'BE',
    'BZ',
    'BJ',
    'BM',
    'BT',
    'BO',
    'BQ',
    'BA',
    'BW',
    'BV',
    'BR',
    'IO',
    'BN',
    'BG',
    'BF',
    'BI',
    'KH',
    'CM',
    'CA',
    'CV',
    'KY',
    'CF',
    'TD',
    'CL',
    'CN',
    'CX',
    'CC',
    'CO',
    'KM',
    'CG',
    'CD',
    'CK',
    'CR',
    'CI',
    'HR',
    'CU',
    'CW',
    'CY',
    'CZ',
    'DK',
    'DJ',
    'DM',
    'DO',
    'EC',
    'EG',
    'SV',
    'GQ',
    'ER',
    'EE',
    'ET',
    'FK',
    'FO',
    'FJ',
    'FI',
    'FR',
    'GF',
    'PF',
    'TF',
    'GA',
    'GM',
    'GE',
    'DE',
    'GH',
    'GI',
    'GR',
    'GL',
    'GD',
    'GP',
    'GU',
    'GT',
    'GG',
    'GN',
    'GW',
    'GY',
    'HT',
    'HM',
    'VA',
    'HN',
    'HK',
    'HU',
    'IS',
    'IN',
    'ID',
    'IR',
    'IQ',
    'IE',
    'IM',
    'IL',
    'IT',
    'JM',
    'JP',
    'JE',
    'JO',
    'KZ',
    'KE',
    'KI',
    'KP',
    'KR',
    'KW',
    'KG',
    'LA',
    'LV',
    'LB',
    'LS',
    'LR',
    'LY',
    'LI',
    'LT',
    'LU',
    'MO',
    'MK',
    'MG',
    'MW',
    'MY',
    'MV',
    'ML',
    'MT',
    'MH',
    'MQ',
    'MR',
    'MU',
    'YT',
    'MX',
    'FM',
    'MD',
    'MC',
    'MN',
    'ME',
    'MS',
    'MA',
    'MZ',
    'MM',
    'NA',
    'NR',
    'NP',
    'NL',
    'NC',
    'NZ',
    'NI',
    'NE',
    'NG',
    'NU',
    'NF',
    'MP',
    'NO',
    'OM',
    'PK',
    'PW',
    'PS',
    'PA',
    'PG',
    'PY',
    'PE',
    'PH',
    'PN',
    'PL',
    'PT',
    'PR',
    'QA',
    'RE',
    'RO',
    'RU',
    'RW',
    'BL',
    'SH',
    'KN',
    'LC',
    'MF',
    'PM',
    'VC',
    'WS',
    'SM',
    'ST',
    'SA',
    'SN',
    'RS',
    'SC',
    'SL',
    'SX',
    'SG',
    'SK',
    'SI',
    'SB',
    'SO',
    'ZA',
    'GS',
    'ES',
    'LK',
    'SD',
    'SR',
    'SJ',
    'SZ',
    'SE',
    'CH',
    'SY',
    'TW',
    'TJ',
    'TZ',
    'TH',
    'TL',
    'TG',
    'TK',
    'TO',
    'TT',
    'TN',
    'TR',
    'TM',
    'TC',
    'TV',
    'UG',
    'UA',
    'AE',
    'GB',
    'US',
    'UM',
    'UY',
    'UZ',
    'VU',
    'VE',
    'VN',
    'VG',
    'VI',
    'WF',
    'EH',
    'YE',
    'ZM',
    'ZW'
  ];

  @override
  Widget build(BuildContext context) {
    var defaultIndex = 0;
    if (country != null) {
      try {
        final code = CountryPickerUtils.getCountryByName(country ?? "").isoCode;
        defaultIndex = _countryList.indexOf(code);
      } catch (e) {
        defaultIndex = 0;
      }
    }
    return CupertinoActionSheet(
      title: Text(title, style: const TextStyle(fontSize: 16, color: CupertinoColors.black)),
      message: Container(
        height: _kPickerSheetHeight,
        color: Colors.transparent,
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: defaultIndex),
            onSelectedItemChanged: (int value) {
              country = CountryPickerUtils.getCountryByIsoCode(_countryList[value]).name;
            },
            itemExtent: 30,
            children: _countryList.map((e) {
              final country = CountryPickerUtils.getCountryByIsoCode(e);
              return Row(
                children: [
                  CountryPickerUtils.getDefaultFlagImage(country),
                  const SizedBox(width: 8.0),
                  Expanded(child: Text(country.name, softWrap: true)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: const Text('Done'),
          onPressed: () {
            Navigator.pop(context);
            onValuePicked(country ?? CountryPickerUtils.getCountryByIsoCode(_countryList.first).name);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text("Cancel"),
        isDefaultAction: true,
        onPressed: (() {
          Navigator.pop(context, 'Cancel');
        }),
      ),
    );
  }
}
