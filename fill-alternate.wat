(module
 (func $console_log (import "imports" "console_log") (param i32))
 (memory (export "memory") 13)
 (func $step (export "step") 
    (local $width i32)
    (local $height i32)
    (local $p i32)
    (local $counter i32)

    ;; width and height should be parameters
    i32.const 512
    local.set $width
    i32.const 360
    local.set $height

    local.get $width
    local.get $height
    i32.mul
    local.set $counter

    i32.const 0x10000
    local.set $p
    block $done
        loop $repeat
            ;; set stopping point
            local.get $p 
            i32.const 0xC3FFF
            i32.ge_s
            br_if $done
            ;; conditions
            local.get $counter
            i32.const 2
            i32.rem_s
            i32.eqz
            ;; set colors to alternate
            if $odd
            local.get $p
            i32.const 0xFF0000FF ;; red
            i32.store
            else 
            local.get $p
            i32.const 0xFFFF0000;; blue
            i32.store

            end $odd
            ;; move to the next pixel 
            local.get $p
            i32.const 4
            i32.add
            local.set $p

            ;; subtract counter
            local.get $counter
            i32.const -1
            i32.add
            local.set $counter
      
            local.get $counter
            br $repeat
        end $repeat
    end $done
 )
 
 (func $run (export "run") (result i32)
   call $step
   i32.const 0
   ;; i32.const 0xFF00FF00   ;; green
   ;; i32.const 0xFFFF0000   ;; blue
   ;; i32.const 0xFFFFFFFF   ;; white
   ;; i32.const 0xFF000000   ;; black
 )   
)