class PageResult {
  final dynamic data;

  const PageResult._({
    this.data,
  });

  factory PageResult.dirty(dynamic data) => PageResult._(data: data);

  static PageResult dirtyResult = PageResult._();

  @override
  String toString() => 'PageResult data: $data';
}
