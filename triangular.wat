(module
(import "" "write_i32"  (func $write_i32  (param i32)))
 (import "" "write_i32x" (func $write_i32x (param i32)))
 (import "" "write_i32b" (func $write_i32b (param i32)))
 (import "" "write_char" (func $write_char (param i32)))
(func $print_newline (param $n i32)
   local.get $n
   call $write_i32
   i32.const 10
   call $write_char
)

(func $triangle (param $n i32) (result i32)
    (local $result i32)
    i32.const 0
    local.set $result
    block $done
        loop $repeat
            ;;check if param is 0, if it is exit
             local.get $n
             i32.eqz
             br_if $done
             local.get $n
             local.get $result
             i32.add
             local.set $result
             local.get $n
             i32.const -1
             i32.add
             local.set $n
             br $repeat
        end $repeat
    end $done
    local.get $result
)
(func $run (export "run") (result i32)
    (local $counter i32)
    (local $curr_max i32)
    i32.const 1
    local.set $counter
    i32.const 10
    local.set $curr_max
    block $done
       loop $repeat
            local.get $counter
            local.get $curr_max
            i32.gt_s
            br_if $done
            local.get $counter
            call $triangle
            call $print_newline
            ;;increment the countr
            local.get $counter
                i32.const 1
            i32.add
            local.set $counter
            br $repeat
       end $repeat
    end $done
    i32.const 0
)
)