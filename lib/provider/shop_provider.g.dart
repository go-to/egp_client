// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shopHash() => r'8630f5dbc97849701f816835743ea859f0e634de';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Shop
    extends BuildlessAutoDisposeAsyncNotifier<ShopsResponse?> {
  late final BuildContext context;

  FutureOr<ShopsResponse?> build(
    BuildContext context,
  );
}

/// See also [Shop].
@ProviderFor(Shop)
const shopProvider = ShopFamily();

/// See also [Shop].
class ShopFamily extends Family<AsyncValue<ShopsResponse?>> {
  /// See also [Shop].
  const ShopFamily();

  /// See also [Shop].
  ShopProvider call(
    BuildContext context,
  ) {
    return ShopProvider(
      context,
    );
  }

  @override
  ShopProvider getProviderOverride(
    covariant ShopProvider provider,
  ) {
    return call(
      provider.context,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'shopProvider';
}

/// See also [Shop].
class ShopProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Shop, ShopsResponse?> {
  /// See also [Shop].
  ShopProvider(
    BuildContext context,
  ) : this._internal(
          () => Shop()..context = context,
          from: shopProvider,
          name: r'shopProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$shopHash,
          dependencies: ShopFamily._dependencies,
          allTransitiveDependencies: ShopFamily._allTransitiveDependencies,
          context: context,
        );

  ShopProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final BuildContext context;

  @override
  FutureOr<ShopsResponse?> runNotifierBuild(
    covariant Shop notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(Shop Function() create) {
    return ProviderOverride(
      origin: this,
      override: ShopProvider._internal(
        () => create()..context = context,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Shop, ShopsResponse?>
      createElement() {
    return _ShopProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShopProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ShopRef on AutoDisposeAsyncNotifierProviderRef<ShopsResponse?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _ShopProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Shop, ShopsResponse?>
    with ShopRef {
  _ShopProviderElement(super.provider);

  @override
  BuildContext get context => (origin as ShopProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
