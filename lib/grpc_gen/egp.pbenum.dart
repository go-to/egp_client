//
//  Generated code. Do not modify.
//  source: egp.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CategoryType extends $pb.ProtobufEnum {
  static const CategoryType CATEGORY_TYPE_NONE = CategoryType._(0, _omitEnumNames ? '' : 'CATEGORY_TYPE_NONE');
  static const CategoryType CATEGORY_TYPE_EBISU_1 = CategoryType._(1, _omitEnumNames ? '' : 'CATEGORY_TYPE_EBISU_1');
  static const CategoryType CATEGORY_TYPE_EBISU_2 = CategoryType._(2, _omitEnumNames ? '' : 'CATEGORY_TYPE_EBISU_2');
  static const CategoryType CATEGORY_TYPE_EBISU_WEST = CategoryType._(3, _omitEnumNames ? '' : 'CATEGORY_TYPE_EBISU_WEST');
  static const CategoryType CATEGORY_TYPE_EBISU_SOUTH = CategoryType._(4, _omitEnumNames ? '' : 'CATEGORY_TYPE_EBISU_SOUTH');
  static const CategoryType CATEGORY_TYPE_BEER_COCKTAIL = CategoryType._(5, _omitEnumNames ? '' : 'CATEGORY_TYPE_BEER_COCKTAIL');

  static const $core.List<CategoryType> values = <CategoryType> [
    CATEGORY_TYPE_NONE,
    CATEGORY_TYPE_EBISU_1,
    CATEGORY_TYPE_EBISU_2,
    CATEGORY_TYPE_EBISU_WEST,
    CATEGORY_TYPE_EBISU_SOUTH,
    CATEGORY_TYPE_BEER_COCKTAIL,
  ];

  static final $core.Map<$core.int, CategoryType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CategoryType? valueOf($core.int value) => _byValue[value];

  const CategoryType._($core.int v, $core.String n) : super(v, n);
}

class SearchType extends $pb.ProtobufEnum {
  static const SearchType SEARCH_TYPE_IN_CURRENT_SALES = SearchType._(0, _omitEnumNames ? '' : 'SEARCH_TYPE_IN_CURRENT_SALES');
  static const SearchType SEARCH_TYPE_NOT_YET = SearchType._(1, _omitEnumNames ? '' : 'SEARCH_TYPE_NOT_YET');
  static const SearchType SEARCH_TYPE_IRREGULAR_HOLIDAY = SearchType._(2, _omitEnumNames ? '' : 'SEARCH_TYPE_IRREGULAR_HOLIDAY');
  static const SearchType SEARCH_TYPE_NEEDS_RESERVATION = SearchType._(3, _omitEnumNames ? '' : 'SEARCH_TYPE_NEEDS_RESERVATION');
  static const SearchType SEARCH_TYPE_BEER_COCKTAIL = SearchType._(4, _omitEnumNames ? '' : 'SEARCH_TYPE_BEER_COCKTAIL');

  static const $core.List<SearchType> values = <SearchType> [
    SEARCH_TYPE_IN_CURRENT_SALES,
    SEARCH_TYPE_NOT_YET,
    SEARCH_TYPE_IRREGULAR_HOLIDAY,
    SEARCH_TYPE_NEEDS_RESERVATION,
    SEARCH_TYPE_BEER_COCKTAIL,
  ];

  static final $core.Map<$core.int, SearchType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SearchType? valueOf($core.int value) => _byValue[value];

  const SearchType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
