;; uses load8_u to load one byte (with no sign extension) and print it out for the addresses 0..3

(module
 (import "" "write_i32"  (func $write_i32  (param i32)))
 (import "" "write_i32x" (func $write_i32x (param i32)))
 (import "" "write_i32b" (func $write_i32b (param i32)))
 (import "" "write_char" (func $write_char (param i32)))
 (memory (export "memory")1)
 
 (func $set_memory (param $start i32) (param $length i32)
   (local $counter i32)
   (local $address i32)
   i32.const 0
   local.set $counter
   block $done
     loop $repeat
       ;;compare counter and length
       local.get $counter
       local.get $length
       i32.gt_u
       br_if $done
       ;;
       local.get $start
       local.get $counter
       i32.add
       local.set $address
       ;;
       local.get $address
       i32.const 0xFF
       i32.store8
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

 (func $memory_dump (param $start i32) (param $length i32)
   (local $counter i32)
   (local $address i32)
   i32.const 0
   local.set $counter
   block $done
     loop $repeat
       local.get $counter
       local.get $length
       i32.gt_u
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
    i32.const 0xFFFF
    call $set_memory
    ;;set up a marker for it to stop the loop       
    i32.const 0
    i32.const 0xFFFF
    call $memory_dump
    ;;increment counter 
   i32.const 0
 )
)