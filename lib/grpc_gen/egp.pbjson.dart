//
//  Generated code. Do not modify.
//  source: egp.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use dateDescriptor instead')
const Date$json = {
  '1': 'Date',
  '2': [
    {'1': 'year', '3': 1, '4': 1, '5': 5, '10': 'year'},
    {'1': 'month', '3': 2, '4': 1, '5': 5, '10': 'month'},
    {'1': 'day', '3': 3, '4': 1, '5': 5, '10': 'day'},
  ],
};

/// Descriptor for `Date`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dateDescriptor = $convert.base64Decode(
    'CgREYXRlEhIKBHllYXIYASABKAVSBHllYXISFAoFbW9udGgYAiABKAVSBW1vbnRoEhAKA2RheR'
    'gDIAEoBVIDZGF5');

@$core.Deprecated('Use eventDescriptor instead')
const Event$json = {
  '1': 'Event',
  '2': [
    {'1': 'ID', '3': 1, '4': 1, '5': 3, '10': 'ID'},
    {'1': 'Name', '3': 2, '4': 1, '5': 9, '10': 'Name'},
    {'1': 'Year', '3': 3, '4': 1, '5': 5, '10': 'Year'},
    {'1': 'StartDate', '3': 4, '4': 1, '5': 11, '6': '.egp.Date', '10': 'StartDate'},
    {'1': 'EndDate', '3': 5, '4': 1, '5': 11, '6': '.egp.Date', '10': 'EndDate'},
  ],
};

/// Descriptor for `Event`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDescriptor = $convert.base64Decode(
    'CgVFdmVudBIOCgJJRBgBIAEoA1ICSUQSEgoETmFtZRgCIAEoCVIETmFtZRISCgRZZWFyGAMgAS'
    'gFUgRZZWFyEicKCVN0YXJ0RGF0ZRgEIAEoCzIJLmVncC5EYXRlUglTdGFydERhdGUSIwoHRW5k'
    'RGF0ZRgFIAEoCzIJLmVncC5EYXRlUgdFbmREYXRl');

@$core.Deprecated('Use categoryDescriptor instead')
const Category$json = {
  '1': 'Category',
  '2': [
    {'1': 'ID', '3': 1, '4': 1, '5': 3, '10': 'ID'},
    {'1': 'Name', '3': 2, '4': 1, '5': 9, '10': 'Name'},
  ],
};

/// Descriptor for `Category`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoryDescriptor = $convert.base64Decode(
    'CghDYXRlZ29yeRIOCgJJRBgBIAEoA1ICSUQSEgoETmFtZRgCIAEoCVIETmFtZQ==');

@$core.Deprecated('Use categoriesDescriptor instead')
const Categories$json = {
  '1': 'Categories',
  '2': [
    {'1': 'Categories', '3': 1, '4': 3, '5': 11, '6': '.egp.Category', '10': 'Categories'},
  ],
};

/// Descriptor for `Categories`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List categoriesDescriptor = $convert.base64Decode(
    'CgpDYXRlZ29yaWVzEi0KCkNhdGVnb3JpZXMYASADKAsyDS5lZ3AuQ2F0ZWdvcnlSCkNhdGVnb3'
    'JpZXM=');

@$core.Deprecated('Use beerTypeDescriptor instead')
const BeerType$json = {
  '1': 'BeerType',
  '2': [
    {'1': 'ID', '3': 1, '4': 1, '5': 3, '10': 'ID'},
    {'1': 'Name', '3': 2, '4': 1, '5': 9, '10': 'Name'},
  ],
};

/// Descriptor for `BeerType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List beerTypeDescriptor = $convert.base64Decode(
    'CghCZWVyVHlwZRIOCgJJRBgBIAEoA1ICSUQSEgoETmFtZRgCIAEoCVIETmFtZQ==');

@$core.Deprecated('Use beerTypesDescriptor instead')
const BeerTypes$json = {
  '1': 'BeerTypes',
  '2': [
    {'1': 'BeerTypes', '3': 1, '4': 3, '5': 11, '6': '.egp.BeerType', '10': 'BeerTypes'},
  ],
};

/// Descriptor for `BeerTypes`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List beerTypesDescriptor = $convert.base64Decode(
    'CglCZWVyVHlwZXMSKwoJQmVlclR5cGVzGAEgAygLMg0uZWdwLkJlZXJUeXBlUglCZWVyVHlwZX'
    'M=');

@$core.Deprecated('Use shopDescriptor instead')
const Shop$json = {
  '1': 'Shop',
  '2': [
    {'1': 'ID', '3': 1, '4': 1, '5': 3, '10': 'ID'},
    {'1': 'EventID', '3': 2, '4': 1, '5': 3, '10': 'EventID'},
    {'1': 'CategoryID', '3': 3, '4': 1, '5': 3, '10': 'CategoryID'},
    {'1': 'No', '3': 4, '4': 1, '5': 5, '10': 'No'},
    {'1': 'ShopName', '3': 5, '4': 1, '5': 9, '10': 'ShopName'},
    {'1': 'MenuName', '3': 6, '4': 1, '5': 9, '10': 'MenuName'},
    {'1': 'Phone', '3': 7, '4': 1, '5': 9, '10': 'Phone'},
    {'1': 'Address', '3': 8, '4': 1, '5': 9, '10': 'Address'},
    {'1': 'BusinessDays', '3': 9, '4': 1, '5': 9, '10': 'BusinessDays'},
    {'1': 'RegularHoliday', '3': 10, '4': 1, '5': 9, '10': 'RegularHoliday'},
    {'1': 'BusinessHours', '3': 11, '4': 1, '5': 9, '10': 'BusinessHours'},
    {'1': 'ChargePrice', '3': 12, '4': 1, '5': 9, '10': 'ChargePrice'},
    {'1': 'NormalizedChargePrice', '3': 13, '4': 1, '5': 5, '10': 'NormalizedChargePrice'},
    {'1': 'SinglePrice', '3': 14, '4': 1, '5': 9, '10': 'SinglePrice'},
    {'1': 'NormalizedSinglePrice', '3': 15, '4': 1, '5': 5, '10': 'NormalizedSinglePrice'},
    {'1': 'SetPrice', '3': 16, '4': 1, '5': 9, '10': 'SetPrice'},
    {'1': 'NormalizedSetPrice', '3': 17, '4': 1, '5': 5, '10': 'NormalizedSetPrice'},
    {'1': 'BeerType', '3': 18, '4': 1, '5': 9, '10': 'BeerType'},
    {'1': 'NeedsReservation', '3': 19, '4': 1, '5': 9, '10': 'NeedsReservation'},
    {'1': 'NormalizedNeedsReservation', '3': 20, '4': 1, '5': 8, '10': 'NormalizedNeedsReservation'},
    {'1': 'UseHachipay', '3': 21, '4': 1, '5': 9, '10': 'UseHachipay'},
    {'1': 'NormalizedUseHachipay', '3': 22, '4': 1, '5': 8, '10': 'NormalizedUseHachipay'},
    {'1': 'IsOpenHoliday', '3': 23, '4': 1, '5': 8, '10': 'IsOpenHoliday'},
    {'1': 'IsIrregularHoliday', '3': 24, '4': 1, '5': 8, '10': 'IsIrregularHoliday'},
    {'1': 'Latitude', '3': 25, '4': 1, '5': 1, '10': 'Latitude'},
    {'1': 'Longitude', '3': 26, '4': 1, '5': 1, '10': 'Longitude'},
    {'1': 'Location', '3': 27, '4': 1, '5': 9, '10': 'Location'},
    {'1': 'WeekNumber', '3': 28, '4': 1, '5': 5, '10': 'WeekNumber'},
    {'1': 'DayOfWeek', '3': 29, '4': 1, '5': 5, '10': 'DayOfWeek'},
    {'1': 'StartTime', '3': 30, '4': 1, '5': 9, '10': 'StartTime'},
    {'1': 'EndTime', '3': 31, '4': 1, '5': 9, '10': 'EndTime'},
    {'1': 'IsHoliday', '3': 32, '4': 1, '5': 8, '10': 'IsHoliday'},
    {'1': 'InCurrentSales', '3': 33, '4': 1, '5': 8, '10': 'InCurrentSales'},
    {'1': 'BeerTypes', '3': 34, '4': 1, '5': 11, '6': '.egp.BeerTypes', '10': 'BeerTypes'},
  ],
};

/// Descriptor for `Shop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shopDescriptor = $convert.base64Decode(
    'CgRTaG9wEg4KAklEGAEgASgDUgJJRBIYCgdFdmVudElEGAIgASgDUgdFdmVudElEEh4KCkNhdG'
    'Vnb3J5SUQYAyABKANSCkNhdGVnb3J5SUQSDgoCTm8YBCABKAVSAk5vEhoKCFNob3BOYW1lGAUg'
    'ASgJUghTaG9wTmFtZRIaCghNZW51TmFtZRgGIAEoCVIITWVudU5hbWUSFAoFUGhvbmUYByABKA'
    'lSBVBob25lEhgKB0FkZHJlc3MYCCABKAlSB0FkZHJlc3MSIgoMQnVzaW5lc3NEYXlzGAkgASgJ'
    'UgxCdXNpbmVzc0RheXMSJgoOUmVndWxhckhvbGlkYXkYCiABKAlSDlJlZ3VsYXJIb2xpZGF5Ei'
    'QKDUJ1c2luZXNzSG91cnMYCyABKAlSDUJ1c2luZXNzSG91cnMSIAoLQ2hhcmdlUHJpY2UYDCAB'
    'KAlSC0NoYXJnZVByaWNlEjQKFU5vcm1hbGl6ZWRDaGFyZ2VQcmljZRgNIAEoBVIVTm9ybWFsaX'
    'plZENoYXJnZVByaWNlEiAKC1NpbmdsZVByaWNlGA4gASgJUgtTaW5nbGVQcmljZRI0ChVOb3Jt'
    'YWxpemVkU2luZ2xlUHJpY2UYDyABKAVSFU5vcm1hbGl6ZWRTaW5nbGVQcmljZRIaCghTZXRQcm'
    'ljZRgQIAEoCVIIU2V0UHJpY2USLgoSTm9ybWFsaXplZFNldFByaWNlGBEgASgFUhJOb3JtYWxp'
    'emVkU2V0UHJpY2USGgoIQmVlclR5cGUYEiABKAlSCEJlZXJUeXBlEioKEE5lZWRzUmVzZXJ2YX'
    'Rpb24YEyABKAlSEE5lZWRzUmVzZXJ2YXRpb24SPgoaTm9ybWFsaXplZE5lZWRzUmVzZXJ2YXRp'
    'b24YFCABKAhSGk5vcm1hbGl6ZWROZWVkc1Jlc2VydmF0aW9uEiAKC1VzZUhhY2hpcGF5GBUgAS'
    'gJUgtVc2VIYWNoaXBheRI0ChVOb3JtYWxpemVkVXNlSGFjaGlwYXkYFiABKAhSFU5vcm1hbGl6'
    'ZWRVc2VIYWNoaXBheRIkCg1Jc09wZW5Ib2xpZGF5GBcgASgIUg1Jc09wZW5Ib2xpZGF5Ei4KEk'
    'lzSXJyZWd1bGFySG9saWRheRgYIAEoCFISSXNJcnJlZ3VsYXJIb2xpZGF5EhoKCExhdGl0dWRl'
    'GBkgASgBUghMYXRpdHVkZRIcCglMb25naXR1ZGUYGiABKAFSCUxvbmdpdHVkZRIaCghMb2NhdG'
    'lvbhgbIAEoCVIITG9jYXRpb24SHgoKV2Vla051bWJlchgcIAEoBVIKV2Vla051bWJlchIcCglE'
    'YXlPZldlZWsYHSABKAVSCURheU9mV2VlaxIcCglTdGFydFRpbWUYHiABKAlSCVN0YXJ0VGltZR'
    'IYCgdFbmRUaW1lGB8gASgJUgdFbmRUaW1lEhwKCUlzSG9saWRheRggIAEoCFIJSXNIb2xpZGF5'
    'EiYKDkluQ3VycmVudFNhbGVzGCEgASgIUg5JbkN1cnJlbnRTYWxlcxIsCglCZWVyVHlwZXMYIi'
    'ABKAsyDi5lZ3AuQmVlclR5cGVzUglCZWVyVHlwZXM=');

@$core.Deprecated('Use shopLocationDescriptor instead')
const ShopLocation$json = {
  '1': 'ShopLocation',
  '2': [
    {'1': 'ID', '3': 1, '4': 1, '5': 3, '10': 'ID'},
    {'1': 'ShopID', '3': 2, '4': 1, '5': 3, '10': 'ShopID'},
    {'1': 'Latitude', '3': 3, '4': 1, '5': 1, '10': 'Latitude'},
    {'1': 'Longitude', '3': 4, '4': 1, '5': 1, '10': 'Longitude'},
    {'1': 'Location', '3': 5, '4': 1, '5': 9, '10': 'Location'},
  ],
};

/// Descriptor for `ShopLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shopLocationDescriptor = $convert.base64Decode(
    'CgxTaG9wTG9jYXRpb24SDgoCSUQYASABKANSAklEEhYKBlNob3BJRBgCIAEoA1IGU2hvcElEEh'
    'oKCExhdGl0dWRlGAMgASgBUghMYXRpdHVkZRIcCglMb25naXR1ZGUYBCABKAFSCUxvbmdpdHVk'
    'ZRIaCghMb2NhdGlvbhgFIAEoCVIITG9jYXRpb24=');

@$core.Deprecated('Use shopTimeDescriptor instead')
const ShopTime$json = {
  '1': 'ShopTime',
  '2': [
    {'1': 'ID', '3': 1, '4': 1, '5': 3, '10': 'ID'},
    {'1': 'ShopID', '3': 2, '4': 1, '5': 3, '10': 'ShopID'},
    {'1': 'WeekNumber', '3': 3, '4': 1, '5': 5, '10': 'WeekNumber'},
    {'1': 'DayOfWeek', '3': 4, '4': 1, '5': 5, '10': 'DayOfWeek'},
    {'1': 'StartTime', '3': 5, '4': 1, '5': 9, '10': 'StartTime'},
    {'1': 'EndTime', '3': 6, '4': 1, '5': 9, '10': 'EndTime'},
    {'1': 'IsHoliday', '3': 7, '4': 1, '5': 8, '10': 'IsHoliday'},
  ],
};

/// Descriptor for `ShopTime`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shopTimeDescriptor = $convert.base64Decode(
    'CghTaG9wVGltZRIOCgJJRBgBIAEoA1ICSUQSFgoGU2hvcElEGAIgASgDUgZTaG9wSUQSHgoKV2'
    'Vla051bWJlchgDIAEoBVIKV2Vla051bWJlchIcCglEYXlPZldlZWsYBCABKAVSCURheU9mV2Vl'
    'axIcCglTdGFydFRpbWUYBSABKAlSCVN0YXJ0VGltZRIYCgdFbmRUaW1lGAYgASgJUgdFbmRUaW'
    '1lEhwKCUlzSG9saWRheRgHIAEoCFIJSXNIb2xpZGF5');

@$core.Deprecated('Use shopsRequestDescriptor instead')
const ShopsRequest$json = {
  '1': 'ShopsRequest',
};

/// Descriptor for `ShopsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shopsRequestDescriptor = $convert.base64Decode(
    'CgxTaG9wc1JlcXVlc3Q=');

@$core.Deprecated('Use shopsResponseDescriptor instead')
const ShopsResponse$json = {
  '1': 'ShopsResponse',
  '2': [
    {'1': 'Shops', '3': 1, '4': 3, '5': 11, '6': '.egp.Shop', '10': 'Shops'},
  ],
};

/// Descriptor for `ShopsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shopsResponseDescriptor = $convert.base64Decode(
    'Cg1TaG9wc1Jlc3BvbnNlEh8KBVNob3BzGAEgAygLMgkuZWdwLlNob3BSBVNob3Bz');

