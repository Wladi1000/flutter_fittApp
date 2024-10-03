import 'package:asp/asp.dart' as asp;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Esta clase `AtomFactory` es una fábrica para crear átomos y acciones asociadas
/// utilizando la biblioteca `asp`. Un átomo es una unidad de estado que puede ser
/// observada y modificada.
///
/// - `AtomFactory<T>`: Constructor que inicializa un átomo, un estado derivado y una acción
///   para modificar el átomo.
///   - `key`: Una clave única para identificar el átomo.
///   - `initialValue`: El valor inicial del átomo.
///   - `onGet`: (Opcional) Función que se llama cuando se obtiene el estado del átomo.
///   - `onSet`: (Opcional) Función que se llama cuando se establece un nuevo valor en el átomo.
///   - `persistent`: (Opcional) Indica si el estado del átomo debe ser persistente.
///
class AtomFactory<T> {
  late asp.Atom<T> atom;
  late asp.Atom<T> state;
  late asp.AtomAction1<T> set;
  AtomFactory(String key, T initialValue,
      {T Function(asp.GetState, asp.Atom<T>)? onGet,
      Function(asp.SetState, asp.Atom<T>, T)? onSet,
      bool persistent = false}) {
    atom = asp.atom(initialValue);
    state = asp.selector((get) => onGet?.call(get, atom) ?? get(atom));
    set = asp.atomAction1<T>((setter, value) =>
        onSet?.call(setter, atom, value) ?? setter(atom, value));
  }
}

/// - `useAtomState$<T>`: Hook de Flutter que permite usar el estado de un átomo dentro de un
///   widget funcional.
///   - `atom`: El átomo cuyo estado se desea usar.
///   - `when`: (Opcional) Función que determina cuándo debe actualizarse el estado del widget.
///
T useAtomState$<T>(asp.Atom<T> atom,
    {bool Function(T oldState, T state)? when}) {
  final hook = _AspAtomHook(atom, when);
  return use(hook);
}


/// - `_AspAtomHook<T>`: Clase interna que extiende `Hook<T>` para crear un hook personalizado
///   que observa el estado de un átomo.
///   - `atom`: El átomo observado.
///   - `when`: (Opcional) Función que determina cuándo debe actualizarse el estado del hook.
///
// flutter_hooks adapter
// ignore: must_be_immutable
class _AspAtomHook<T> extends Hook<T> {
  final asp.Atom<T> atom;
  final Function(T oldState, T state)? when;
  late T _oldState;

  _AspAtomHook(this.atom, [this.when]);

  @override
  _AspAtomHookState<T> createState() => _AspAtomHookState<T>();
}

/// - `_AspAtomHookState<T>`: Clase interna que extiende `HookState<T, _AspAtomHook<T>>` para
///   manejar el estado del hook personalizado.
class _AspAtomHookState<T> extends HookState<T, _AspAtomHook<T>> {
  BuildContext? _context;

///   - `initHook()`: Método que se llama al inicializar el hook. Añade un listener al átomo.
  @override
  void initHook() {
    super.initHook();
    hook._oldState = hook.atom.state;
    hook.atom.addListener(_listener);
  }

///   - `debugLabel`: Etiqueta de depuración para el hook.
  @override
  String get debugLabel => 'useAtomState\$ (flutter_hooks adapter)';

///   - `_listener()`: Método que se llama cuando cambia el estado del átomo. Actualiza el estado
///     del widget si la condición `when` se cumple.
  void _listener() {
    final state = hook.atom.state;

    if (hook.when?.call(hook._oldState, state) ?? true) {
      if (_context != null && context.mounted) {
        setState(() {});
      }
    }
    hook._oldState = state;
  }

///   - `build(BuildContext context)`: Método que construye el widget y devuelve el estado actual
///     del átomo.
  @override
  T build(BuildContext context) {
    _context = context;
    return hook.atom.state;
  }

///   - `dispose()`: Método que se llama al eliminar el hook. Limpia los recursos utilizados.
  @override
  void dispose() {
    super.dispose();
  }
}