(module
 (func $console_log (import "imports" "console_log") (param i32))
 (memory (export "memory") 1)
 (func $sum_array (export "sum_array") (param $start i32) (param $len i32)
   (local $count i32)
   (local $ad i32)

   i32.const 0
   local.set $count

   block $done
     loop $repeat
       ;; set stopping point at 15
       local.get $count
       local.get $len
       i32.ge_s
       br_if $done
       ;;
       local.get $start
       local.get $count
       i32.add
       local.set $ad ;;set address
       ;;
       local.get $ad
       i32.const 0xFF ;;write to the ad
       i32.store8
       ;;
       ;;increment count
       local.get $count
       i32.const 1
       i32.add
       local.set $count
       ;;
       br $repeat
     end $repeat
   end $done
 )

 (func $run (export "run") (result i32)
   i32.const 0
   i32.const 15
   call $sum_array
   i32.const 0
 )

)