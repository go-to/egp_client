// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stampHash() => r'59f9b786c4ea721ad9da6d03f765e6935a9e8ff0';

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

abstract class _$Stamp extends BuildlessAutoDisposeAsyncNotifier<int> {
  late final BuildContext context;
  late final String userId;
  late final int shopId;

  FutureOr<int> build(
    BuildContext context,
    String userId,
    int shopId,
  );
}

/// See also [Stamp].
@ProviderFor(Stamp)
const stampProvider = StampFamily();

/// See also [Stamp].
class StampFamily extends Family<AsyncValue<int>> {
  /// See also [Stamp].
  const StampFamily();

  /// See also [Stamp].
  StampProvider call(
    BuildContext context,
    String userId,
    int shopId,
  ) {
    return StampProvider(
      context,
      userId,
      shopId,
    );
  }

  @override
  StampProvider getProviderOverride(
    covariant StampProvider provider,
  ) {
    return call(
      provider.context,
      provider.userId,
      provider.shopId,
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
  String? get name => r'stampProvider';
}

/// See also [Stamp].
class StampProvider extends AutoDisposeAsyncNotifierProviderImpl<Stamp, int> {
  /// See also [Stamp].
  StampProvider(
    BuildContext context,
    String userId,
    int shopId,
  ) : this._internal(
          () => Stamp()
            ..context = context
            ..userId = userId
            ..shopId = shopId,
          from: stampProvider,
          name: r'stampProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stampHash,
          dependencies: StampFamily._dependencies,
          allTransitiveDependencies: StampFamily._allTransitiveDependencies,
          context: context,
          userId: userId,
          shopId: shopId,
        );

  StampProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.userId,
    required this.shopId,
  }) : super.internal();

  final BuildContext context;
  final String userId;
  final int shopId;

  @override
  FutureOr<int> runNotifierBuild(
    covariant Stamp notifier,
  ) {
    return notifier.build(
      context,
      userId,
      shopId,
    );
  }

  @override
  Override overrideWith(Stamp Function() create) {
    return ProviderOverride(
      origin: this,
      override: StampProvider._internal(
        () => create()
          ..context = context
          ..userId = userId
          ..shopId = shopId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        userId: userId,
        shopId: shopId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Stamp, int> createElement() {
    return _StampProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StampProvider &&
        other.context == context &&
        other.userId == userId &&
        other.shopId == shopId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, shopId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StampRef on AutoDisposeAsyncNotifierProviderRef<int> {
  /// The parameter `context` of this provider.
  BuildContext get context;

  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `shopId` of this provider.
  int get shopId;
}

class _StampProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Stamp, int> with StampRef {
  _StampProviderElement(super.provider);

  @override
  BuildContext get context => (origin as StampProvider).context;
  @override
  String get userId => (origin as StampProvider).userId;
  @override
  int get shopId => (origin as StampProvider).shopId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
