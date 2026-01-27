../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:19:33: Error:      
'Void' isn't a type.
Pointer<Void> _freeImpl(Pointer<Void> ptr) {
                                ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:19:25: Error:      
'Pointer' isn't a type.
Pointer<Void> _freeImpl(Pointer<Void> ptr) {
                        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:27:38: Error:      
'Void' isn't a type.
final Pointer<NativeFunction<Pointer<Void> Function(Pointer<Void>)>>
                                     ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:27:30: Error:
'Pointer' isn't a type.
final Pointer<NativeFunction<Pointer<Void> Function(Pointer<Void>)>>
                             ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:27:61: Error:      
'Void' isn't a type.
final Pointer<NativeFunction<Pointer<Void> Function(Pointer<Void>)>>
                                                            ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:27:53: Error:      
'Pointer' isn't a type.
final Pointer<NativeFunction<Pointer<Void> Function(Pointer<Void>)>>
                                                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:27:15: Error:      
'NativeFunction' isn't a type.
final Pointer<NativeFunction<Pointer<Void> Function(Pointer<Void>)>>
              ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:27:7: Error:       
'Pointer' isn't a type.
final Pointer<NativeFunction<Pointer<Void> Function(Pointer<Void>)>>
      ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:28:23: Error:      
Undefined name 'Pointer'.
    freeFunctionPtr = Pointer.fromFunction(_freeImpl);
                      ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:35:33: Error:      
'Uint8' isn't a type.
  final ptr = allocate.allocate<Uint8>(bytes.length + additionalLength);
                                ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:46:26: Error:      
'Uint8' isn't a type.
    final asBytes = cast<Uint8>();
                         ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:60:29: Error:      
'Uint8' isn't a type.
    return utf8.decode(cast<Uint8>().asTypedList(resolvedLength));
                            ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/memory.dart:73:25: Error:      
'Uint8' isn't a type.
    list.setAll(0, cast<Uint8>().asTypedList(length));
                        ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:10:47: Error:   
'NativeType' isn't a type.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
                                              ^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:10:13: Error:   
'Pointer' isn't a type.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
            ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:14:16: Error:   
'DynamicLibrary' isn't a type.
  Bindings(ffi.DynamicLibrary dynamicLibrary) : _lookup = dynamicLibrary.lookup;
               ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:18:45: Error:   
'NativeType' isn't a type.
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
                                            ^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:18:11: Error:   
'Pointer' isn't a type.
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:22:30: Error:   
'Pointer' isn't a type.
  late final ffi.Pointer<ffi.Pointer<sqlite3_char>> _sqlite3_temp_directory =
                             ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:22:18: Error:   
'Pointer' isn't a type.
  late final ffi.Pointer<ffi.Pointer<sqlite3_char>> _sqlite3_temp_directory =
                 ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:23:19: Error:   
'Pointer' isn't a type.
      _lookup<ffi.Pointer<sqlite3_char>>('sqlite3_temp_directory');
                  ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:28:34: Error:   
'Pointer' isn't a type.
  set sqlite3_temp_directory(ffi.Pointer<sqlite3_char> value) =>
                                 ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:32:9: Error:    
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> filename,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:33:21: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3>> ppDb,
                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:33:9: Error:    
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3>> ppDb,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:35:9: Error:    
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> zVfs,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:57:9: Error:    
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:71:9: Error:    
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:72:9: Error:    
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> zDbName,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:103:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:119:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:133:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:162:21: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.Void> ptr,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:162:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> ptr,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:206:9: Error:
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:220:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:234:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:235:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> sql,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:236:21: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.Void> callback,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:236:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> callback,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:237:21: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.Void> argToCb,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:237:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> argToCb,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:238:21: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3_char>> errorOut,
                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:238:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3_char>> errorOut,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:266:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> arg0,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:269:21: Error:  
'Void' isn't a type.
                ffi.Void Function(
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:270:37: Error:  
'Void' isn't a type.
                    ffi.Pointer<ffi.Void>,
                                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:270:25: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Void>,
                        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:271:25: Error:  
'Int' isn't a type.
                    ffi.Int,
                        ^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:272:25: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<sqlite3_char>,
                        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:273:25: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<sqlite3_char>,
                        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:274:25: Error:  
'Int64' isn't a type.
                    ffi.Int64)>>
                        ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:268:17: Error:  
'NativeFunction' isn't a type.
            ffi.NativeFunction<
                ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:267:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:276:21: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.Void> arg2,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:276:9: Error:
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> arg2,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:312:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:326:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:327:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> zSql,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:329:21: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3_stmt>> ppStmt,
                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:329:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3_stmt>> ppStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:330:21: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3_char>> pzTail,
                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:330:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3_char>> pzTail,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:358:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:359:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> zSql,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:362:21: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3_stmt>> ppStmt,
                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:362:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3_stmt>> ppStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:363:21: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3_char>> pzTail,
                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:363:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Pointer<sqlite3_char>> pzTail,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:394:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:408:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:422:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:436:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:450:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:464:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:478:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:492:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> arg0,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:493:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> zName,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:510:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:527:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:545:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:547:21: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.Void> data,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:547:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> data,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:549:21: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.Void> destructor,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:549:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> destructor,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:573:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:592:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:611:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:628:9: Error:
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:630:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> data,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:632:21: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.Void> destructor,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:632:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> destructor,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:656:9: Error:
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:673:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:690:9: Error:
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:707:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:724:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:741:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_stmt> pStmt,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:758:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_value> value,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:773:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_value> value,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:787:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_value> value,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:801:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_value> value,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:815:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_value> value,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:830:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_value> value,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:844:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:845:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> zFunctionName,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:848:21: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.Void> pApp,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:848:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> pApp,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:851:21: Error:  
'Void' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:851:39: Error:  
'Pointer' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                                      ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:851:69: Error:  
'Int' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                                                                    ^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:852:37: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Pointer<sqlite3_value>>)>>
                                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:852:25: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Pointer<sqlite3_value>>)>>
                        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:850:17: Error:  
'NativeFunction' isn't a type.
            ffi.NativeFunction<
                ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:849:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:856:21: Error:  
'Void' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:856:39: Error:  
'Pointer' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                                      ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:856:69: Error:  
'Int' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                                                                    ^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:857:37: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Pointer<sqlite3_value>>)>>
                                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:857:25: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Pointer<sqlite3_value>>)>>
                        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:855:17: Error:  
'NativeFunction' isn't a type.
            ffi.NativeFunction<
                ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:854:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:860:36: Error:  
'Void' isn't a type.
            ffi.NativeFunction<ffi.Void Function(ffi.Pointer<sqlite3_context>)>>
                                   ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:860:54: Error:  
'Pointer' isn't a type.
            ffi.NativeFunction<ffi.Void Function(ffi.Pointer<sqlite3_context>)>>
                                                     ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:860:17: Error:  
'NativeFunction' isn't a type.
            ffi.NativeFunction<ffi.Void Function(ffi.Pointer<sqlite3_context>)>>
                ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:859:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:862:40: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                                       ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:862:70: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                                                                     ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:862:58: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                                                         ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:862:21: Error:  
'NativeFunction' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                    ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:862:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:930:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:931:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> zFunctionName,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:934:21: Error:
'Void' isn't a type.
    ffi.Pointer<ffi.Void> pApp,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:934:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> pApp,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:937:21: Error:  
'Void' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:937:39: Error:  
'Pointer' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                                      ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:937:69: Error:  
'Int' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                                                                    ^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:938:37: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Pointer<sqlite3_value>>)>>
                                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:938:25: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Pointer<sqlite3_value>>)>>
                        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:936:17: Error:  
'NativeFunction' isn't a type.
            ffi.NativeFunction<
                ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:935:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:941:36: Error:  
'Void' isn't a type.
            ffi.NativeFunction<ffi.Void Function(ffi.Pointer<sqlite3_context>)>>
                                   ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:941:54: Error:  
'Pointer' isn't a type.
            ffi.NativeFunction<ffi.Void Function(ffi.Pointer<sqlite3_context>)>>
                                                     ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:941:17: Error:  
'NativeFunction' isn't a type.
            ffi.NativeFunction<ffi.Void Function(ffi.Pointer<sqlite3_context>)>>
                ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:940:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:944:36: Error:  
'Void' isn't a type.
            ffi.NativeFunction<ffi.Void Function(ffi.Pointer<sqlite3_context>)>>
                                   ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:944:54: Error:  
'Pointer' isn't a type.
            ffi.NativeFunction<ffi.Void Function(ffi.Pointer<sqlite3_context>)>>
                                                     ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:944:17: Error:  
'NativeFunction' isn't a type.
            ffi.NativeFunction<ffi.Void Function(ffi.Pointer<sqlite3_context>)>>
                ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:943:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:948:21: Error:  
'Void' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:948:39: Error:  
'Pointer' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                                      ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:948:69: Error:
'Int' isn't a type.
                ffi.Void Function(ffi.Pointer<sqlite3_context>, ffi.Int,
                                                                    ^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:949:37: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Pointer<sqlite3_value>>)>>
                                    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:949:25: Error:  
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Pointer<sqlite3_value>>)>>
                        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:947:17: Error:  
'NativeFunction' isn't a type.
            ffi.NativeFunction<
                ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:946:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:951:40: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                                       ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:951:70: Error:  
'Void' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                                                                     ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:951:58: Error:
'Pointer' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                                                         ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:951:21: Error:  
'NativeFunction' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                    ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:951:9: Error:   
'Pointer' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1026:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_context> ctx,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1044:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_context> ctx,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1059:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_context> ctx,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1060:21: Error: 
'Void' isn't a type.
    ffi.Pointer<ffi.Void> data,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1060:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> data,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1062:21: Error: 
'Void' isn't a type.
    ffi.Pointer<ffi.Void> destructor,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1062:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> destructor,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1081:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_context> ctx,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1098:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_context> ctx,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1099:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> msg,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1118:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_context> ctx,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1135:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_context> ctx,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1149:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_context> ctx,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1150:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> data,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1152:21: Error: 
'Void' isn't a type.
    ffi.Pointer<ffi.Void> destructor,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1152:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> destructor,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1174:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> arg0,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1175:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> zName,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1177:21: Error: 
'Void' isn't a type.
    ffi.Pointer<ffi.Void> pArg,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1177:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> pArg,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1180:21: Error: 
'Int' isn't a type.
                ffi.Int Function(ffi.Pointer<ffi.Void>, ffi.Int,
                    ^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1180:50: Error: 
'Void' isn't a type.
                ffi.Int Function(ffi.Pointer<ffi.Void>, ffi.Int,
                                                 ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1180:38: Error: 
'Pointer' isn't a type.
                ffi.Int Function(ffi.Pointer<ffi.Void>, ffi.Int,
                                     ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1180:61: Error: 
'Int' isn't a type.
                ffi.Int Function(ffi.Pointer<ffi.Void>, ffi.Int,
                                                            ^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1181:37: Error: 
'Void' isn't a type.
                    ffi.Pointer<ffi.Void>, ffi.Int, ffi.Pointer<ffi.Void>)>>
                                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1181:25: Error: 
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Void>, ffi.Int, ffi.Pointer<ffi.Void>)>>
                        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1181:48: Error: 
'Int' isn't a type.
                    ffi.Pointer<ffi.Void>, ffi.Int, ffi.Pointer<ffi.Void>)>>
                                               ^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1181:69: Error:
'Void' isn't a type.
                    ffi.Pointer<ffi.Void>, ffi.Int, ffi.Pointer<ffi.Void>)>>
                                                                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1181:57: Error: 
'Pointer' isn't a type.
                    ffi.Pointer<ffi.Void>, ffi.Int, ffi.Pointer<ffi.Void>)>>
                                                        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1179:17: Error: 
'NativeFunction' isn't a type.
            ffi.NativeFunction<
                ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1178:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1183:40: Error: 
'Void' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                                       ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1183:70: Error: 
'Void' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                                                                     ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1183:58: Error: 
'Pointer' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                                                         ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1183:21: Error: 
'NativeFunction' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
                    ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1183:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Void>)>>
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1235:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> pDestDb,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1236:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> zDestDb,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1237:9: Error:
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> pSrcDb,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1238:9: Error:
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_char> zSrcDb,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1263:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_backup> p,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1280:9: Error:
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_backup> p,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1294:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_backup> p,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1308:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3_backup> p,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1322:21: Error: 
'Void' isn't a type.
    ffi.Pointer<ffi.Void> xEntryPoint,
                    ^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1322:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Void> xEntryPoint,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1336:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<sqlite3> db,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1339:21: Error: 
'Int' isn't a type.
    ffi.Pointer<ffi.Int> va1,
                    ^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/sqlite3-2.4.0/lib/src/ffi/sqlite3.g.dart:1339:9: Error:  
'Pointer' isn't a type.
    ffi.Pointer<ffi.Int> va1,
        ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:9:7: Error:
'DynamicLibrary' isn't a type.
final DynamicLibrary stdlib = Platform.isWindows
      ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:10:7: Error: Undefined 
name 'DynamicLibrary'.
    ? DynamicLibrary.open('ole32.dll')
      ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:11:7: Error: Undefined 
name 'DynamicLibrary'.
    : DynamicLibrary.process();
      ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:25:15: Error:
'NativeFunction' isn't a type.
final Pointer<NativeFunction<PosixFreeNative>> posixFreePointer =
              ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:25:7: Error: 'Pointer' 
isn't a type.
final Pointer<NativeFunction<PosixFreeNative>> posixFreePointer =
      ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:37:15: Error:
'NativeFunction' isn't a type.
final Pointer<NativeFunction<WinCoTaskMemFreeNative>> winCoTaskMemFreePointer =
              ^^^^^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:37:7: Error: 'Pointer' 
isn't a type.
final Pointer<NativeFunction<WinCoTaskMemFreeNative>> winCoTaskMemFreePointer =
      ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:61:5: Error: 'Pointer' 
isn't a type.
    Pointer<T> result;
    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:79:13: Error: 'Pointer'isn't a type.
  void free(Pointer pointer) {
            ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:138:20: Error:
'Pointer' isn't a type.
  void _fillMemory(Pointer destination, int length, int fill) {
                   ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:139:34: Error: 'Uint8' 
isn't a type.
    final ptr = destination.cast<Uint8>();
                                 ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:147:20: Error:
'Pointer' isn't a type.
  void _zeroMemory(Pointer destination, int length) =>
                   ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:161:5: Error: 'Pointer'isn't a type.
    Pointer<T> result;
    ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/allocation.dart:182:13: Error:
'Pointer' isn't a type.
  void free(Pointer pointer) {
            ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/arena.dart:26:9: Error: 'Allocator'    
isn't a type.
  final Allocator _wrappedAllocator;
        ^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/arena.dart:29:22: Error: 'NativeType'  
isn't a type.
  final List<Pointer<NativeType>> _managedMemoryPointers = [];
                     ^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/arena.dart:29:14: Error: 'Pointer'     
isn't a type.
  final List<Pointer<NativeType>> _managedMemoryPointers = [];
             ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/arena.dart:40:10: Error: 'Allocator'   
isn't a type.
  Arena([Allocator allocator = calloc]) : _wrappedAllocator = allocator;
         ^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/arena.dart:101:21: Error: 'NativeType' 
isn't a type.
  void free(Pointer<NativeType> pointer) {}
                    ^^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/arena.dart:101:13: Error: 'Pointer'    
isn't a type.
  void free(Pointer<NativeType> pointer) {}
            ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/arena.dart:120:6: Error: 'Allocator'   
isn't a type.
    [Allocator wrappedAllocator = calloc]) {
     ^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/arena.dart:144:6: Error: 'Allocator'   
isn't a type.
    [Allocator wrappedAllocator = calloc]) {
     ^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf8.dart:26:28: Error: 'Uint8' isn't atype.
    final codeUnits = cast<Uint8>();
                           ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf8.dart:43:28: Error: 'Uint8' isn't atype.
    final codeUnits = cast<Uint8>();
                           ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf8.dart:52:30: Error: 'Uint8' isn't atype.
  static int _length(Pointer<Uint8> codeUnits) {
                             ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf8.dart:52:22: Error: 'Pointer' isn'ta type.
  static int _length(Pointer<Uint8> codeUnits) {
                     ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf8.dart:81:31: Error: 'Allocator'    
isn't a type.
  Pointer<Utf8> toNativeUtf8({Allocator allocator = malloc}) {
                              ^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf8.dart:83:19: Error: 'Uint8' isn't atype.
    final Pointer<Uint8> result = allocator<Uint8>(units.length + 1);
                  ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf8.dart:83:11: Error: 'Pointer' isn'ta type.
    final Pointer<Uint8> result = allocator<Uint8>(units.length + 1);
          ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf8.dart:83:45: Error: 'Uint8' isn't atype.
    final Pointer<Uint8> result = allocator<Uint8>(units.length + 1);
                                            ^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:26:28: Error: 'Uint16' isn'ta type.
    final codeUnits = cast<Uint16>();
                           ^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:43:28: Error: 'Uint16' isn'ta type.
    final codeUnits = cast<Uint16>();
                           ^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:52:46: Error: 'Uint16' isn'ta type.
  static String _toKnownLengthString(Pointer<Uint16> codeUnits, int length) =>
                                             ^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:52:38: Error: 'Pointer'     
isn't a type.
  static String _toKnownLengthString(Pointer<Uint16> codeUnits, int length) =>
                                     ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:55:48: Error: 'Uint16' isn'ta type.
  static String _toUnknownLengthString(Pointer<Uint16> codeUnits) {
                                               ^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:55:40: Error: 'Pointer'     
isn't a type.
  static String _toUnknownLengthString(Pointer<Uint16> codeUnits) {
                                       ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:68:30: Error: 'Uint16' isn'ta type.
  static int _length(Pointer<Uint16> codeUnits) {
                             ^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:68:22: Error: 'Pointer'     
isn't a type.
  static int _length(Pointer<Uint16> codeUnits) {
                     ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:93:33: Error: 'Allocator'   
isn't a type.
  Pointer<Utf16> toNativeUtf16({Allocator allocator = malloc}) {
                                ^^^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:95:19: Error: 'Uint16' isn'ta type.
    final Pointer<Uint16> result = allocator<Uint16>(units.length + 1);
                  ^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:95:11: Error: 'Pointer'     
isn't a type.
    final Pointer<Uint16> result = allocator<Uint16>(units.length + 1);
          ^^^^^^^
../../AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.0/lib/src/utf16.dart:95:46: Error: 'Uint16' isn'ta type.
    final Pointer<Uint16> result = allocator<Uint16>(units.length + 1);
                                             ^^^^^^
Waiting for connection from debug service on Chrome...             95.8s
Failed to compile application.