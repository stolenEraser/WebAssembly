(module
 (import "" "write_i32"  (func $write_i32  (param i32)))
 (import "" "write_i32x" (func $write_i32x (param i32)))
 (import "" "write_i32b" (func $write_i32b (param i32)))
 (import "" "write_char" (func $write_char (param i32)))
 (memory (export "memory") 1) 
 (func $print_and_newline(param $memory_ad i32)
        local.get $memory_ad
        call $write_i32x ;;print the memory address
        i32.const 10
        call $write_char
 )
  ;; length would be 1023 in this case
 (func $sawtooth (param $start i32) (param $length i32)
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

        local.get $counter
        local.get $address
        i32.store ;;store the current address to global
        local.get $address
        call $print_and_newline
       
       local.get $counter
       i32.const 1
       i32.add
       local.set $counter
       
       br $repeat
     end $repeat
   end $done
 )
 (func $sawtooth_helper (param $start i32) (param $length i32)
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

       local.get $counter
       local.get $address
       i32.store ;;store the current address to global
       ;;get the local address but write it in decimal
       local.get $address
       call $write_i32
       i32.const 32
       call $write_char
       i32.const 10
       call $write_char
       
       local.get $counter
       i32.const 1
       i32.add
       local.set $counter
       
       br $repeat
     end $repeat
   end $done
 )


 (func $memory_dump (param $start i32) (param $length i32)
   (local $counter i32)
   (local $address i32)
   (local $second_counter)
   i32.const 0
   local.set $counter
   i32.const 0 
   local.set $second_counter
   
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
       ;; hexadecimal
       local.get $address
       call $write_i32x
       i32.const 32
       call $write_char

       ;; decimal
       local.get $address
       call $write_i32
       i32.const 32
       call $write_char
       
       ;; another decimal up to 15
       ;;local.get $address
       ;;i32.load
       ;;call $write_i32
       ;;i32.const 10
       ;;call $write_char
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
    ;;i32.const 0
    ;;i32.const 0x03FF
        ;;call $sawtooth
    i32.const 0
    i32.const 15
    call $sawtooth_helper
    i32.const 0
    i32.const 0x03FF
    call $memory_dump
    i32.const 42
 )

)