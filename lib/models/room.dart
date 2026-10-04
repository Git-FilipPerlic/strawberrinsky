/// Soba u kući („Dnevna soba", „Kuhinja"...). Naziv upisuje ukućanin.
class Room {
  const Room({required this.id, required this.name});

  final String id;
  final String name;

  Room copyWith({String? name}) => Room(id: id, name: name ?? this.name);

  Map<String, Object?> toMap() => {'id': id, 'name': name};

  /// Vraća `null` ako podatak nije upotrebljiv (nema id-a).
  static Room? fromMap(Map<String, Object?> map) {
    final id = map['id'];
    if (id is! String || id.isEmpty) return null;
    final name = map['name'];
    return Room(id: id, name: name is String ? name : '');
  }

  @override
  bool operator ==(Object other) =>
      other is Room && other.id == id && other.name == name;

  @override
  int get hashCode => Object.hash(id, name);
}
