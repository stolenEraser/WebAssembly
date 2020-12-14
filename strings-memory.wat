(module
 (import "" "write_i32"  (func $write_i32  (param i32)))
 (import "" "write_i32x" (func $write_i32x (param i32)))
 (import "" "write_i32b" (func $write_i32b (param i32)))
 (import "" "write_char" (func $write_char (param i32)))
 (memory (export "memory")1)
 
 (func $find_len (param $start i32) (result i32)
   (local $length i32)

   i32.const 0
   local.set $length

   block $done
     loop $repeat
       local.get $start
       i32.load8_u
       i32.eqz
       br_if $done

       local.get $start
       i32.const 1
       i32.add
       local.set $start

       local.get $length
       i32.const 1
       i32.add
       local.set $length
      
       br $repeat
     end $repeat
   end $done

   local.get $length
 )

 (func $str_copy (param $src i32) (param $length i32)
   (local $copied_string i32)
   (local $dst_str i32)
   (local $counter i32)

   i32.const 0
   local.set $counter

   i32.const 0
   call $find_len
   local.set $dst_str 

   i32.const 1
   local.get $dst_str 
   i32.add
   local.set $dst_str 


   block $b2
    loop $outer
    block $b1
        loop $inner
            local.get $src
            i32.load8_u
            local.set $copied_string

            local.get $dst_str 
            local.get $copied_string
            i32.store8

            ;;increment counter
            local.get $counter
            i32.const 1
            i32.add
            local.set $counter
       
            local.get $copied_string
            i32.eqz
            br_if $b1

            local.get $src
            i32.const 1
            i32.add
            local.set $src

            local.get $dst_str 
            i32.const 1
            i32.add
            local.set $dst_str 
        br $inner
        end $inner
    end $b1
    ;; compare counter to the largest address (159)
    local.get $counter
    local.get $length
    i32.gt_u
    br_if $b2

    local.get $dst_str 
    i32.const 1
    i32.add
    local.set $dst_str 
    i32.const 0
    local.set $src

   br $outer
   end $outer
   end $b2
 )

 (func $run (export "run") (result i32)
   ;; the string begins at address 16 in memory
   i32.const 0
   i32.const 160;;largest address that the thing will load
   call $str_copy
   i32.const 0
 )
)