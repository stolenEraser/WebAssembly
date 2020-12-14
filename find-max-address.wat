(module
 (import "" "write_i32"  (func $write_i32  (param i32)))
 (import "" "write_i32x" (func $write_i32x (param i32)))
 (import "" "write_i32b" (func $write_i32b (param i32)))
 (import "" "write_char" (func $write_char (param i32)))
    (memory (export "memory") 1)  
    ;; means 64Ki (2^16 bytes of memory)
    ;; MAX address would be FFFF
    (func $print_and_newline(param $memory_ad i32)
        local.get $memory_ad
        call $write_i32x ;;print the memory address
        i32.const 10
        call $write_char
    )

    ;;function has 2 parameters
    (func $find_max (param $start i32)(param $length i32) ;;n doesn't do anything
        (local $current_max i32)
        (local $address i32)
        ;; initialize current_max
        i32.const 0
        local.set $current_max

        ;;initialize address
        i32.const 0
        local.set $address
        block $done
            loop $repeat 
                local.get $current_max
                local.get $length
                i32.ge_u
                br_if $done

                ;;set the start value and current_max value to 0
                local.get $start
                local.get $current_max
                i32.add
                local.set $address

                ;;print the address
                local.get $current_max
                local.get $address
                i32.store ;;store the current address to global
                local.get $address
                call $print_and_newline

                ;;read and print the address
                local.get $address
                i32.load
                ;;call $print_and_newline

                ;;keep incrementing current_max until it's greater/equal to the max memory address
                local.get $current_max
                i32.const 1
                i32.add
                local.set $current_max
        br $repeat
        end $repeat
        end $done
    )

    (func $run (export "run") (result i32)
        i32.const 0 ;;start param
        i32.const 0xFFFF ;;end param
        call $find_max
        i32.const 0
    )
)  