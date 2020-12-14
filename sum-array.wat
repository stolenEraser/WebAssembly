(module
 (import "" "write_i32"  (func $write_i32  (param i32)))
 (import "" "write_i32x" (func $write_i32x (param i32)))
 (import "" "write_i32b" (func $write_i32b (param i32)))
 (import "" "write_char" (func $write_char (param i32)))
 (memory(export "memory ") 1)
 ;;(data (offset (i32.const 16)) "\01\02\03\04\05\06\07\08\09\0a")
 (func $memory_dump (param $start i32) (param $len i32)
   (local $counter i32)
   (local $address i32)
   i32.const 0
   local.set $counter

   block $done
     loop $repeat
       local.get $counter
       local.get $len
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
 (func $sum_array (param $start i32) (param $len i32) (result i32)
   (local $index i32)
   (local $total i32)
   (local $stop_index i32)

   i32.const 0
   local.set $index

   i32.const 0
   local.set $total

   ;;have start to start at 1 not 0
   local.get $start
   i32.const 1
   i32.add
   local.set $start

   ;;set the stop index the address at 0
   i32.const 0
   i32.load8_u
   local.set $stop_index

   block $done
     loop $repeat
       local.get $index
       local.get $stop_index
       i32.eq
       br_if $done

       local.get $start
       local.get $index
       i32.add
       i32.load8_u
       local.get $total
       i32.add
       local.set $total

       local.get $index
       i32.const 1
       i32.add
       local.set $index
       
       br $repeat
     end $repeat
   end $done

   local.get $total
 )
 (func $run (export "run") (result i32)
   ;;i32.cons
   ;;i32.const 32
   ;;call $memory_dump

   i32.const 0

   i32.const 255
   call $sum_array
 )
)