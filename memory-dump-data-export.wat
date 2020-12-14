(module
 (import "" "write_i32"  (func $write_i32  (param i32)))
 (import "" "write_i32x" (func $write_i32x (param i32)))
 (import "" "write_i32b" (func $write_i32b (param i32)))
 (import "" "write_char" (func $write_char (param i32)))
 (memory (export "memory") 1)
 (data (offset (i32.const 0)) "stuff\a0")     ;; puts 6 bytes into memory addresses 0..5
 (data (offset (i32.const 8)) "\10\20\30\40") ;; multiple data segments possible
 (func $memory_dump (param $start i32) (param $length i32)
   (local $counter i32)
   (local $address i32)
   i32.const 0
   local.set $counter
   block $done
     loop $repeat
       local.get $counter
       local.get $length
       i32.ge_u
       br_if $done
       ;;
       local.get $start
       local.get $counter
       i32.add
       local.set $address
       ;;
       local.get $address
       call $write_i32x
       i32.const 32
       call $write_char
       ;;
       local.get $address
       i32.load8_u
       call $write_i32x
       i32.const 10
       call $write_char
       ;;
       local.get $counter
       i32.const 1
       i32.add
       local.set $counter
       ;;
       br $repeat
     end $repeat
   end $done
 )
 (func $run (export "run") (result i32)
   i32.const 0
   i32.const 12
   call $memory_dump
   i32.const 0
 )
)