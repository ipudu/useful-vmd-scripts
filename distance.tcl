set nf [molinfo top get numframes]
set fs 3.3
set sel1 [atomselect top "type 1"]
set sel2 [atomselect top "type 7"]

set counter 0

for {set i 0} {$i < $nf} {incr i} {
    for {set j 0} {$j < [$sel1 num]} {incr j} {
        for {set k 0} {$k < [$sel2 num]} {incr k} {
            set coord1 [lindex [$sel1 get {x y z}] $j]
            set coord2 [lindex [$sel2 get {x y z}] $k]
            set distance [vecdist $coord1 $coord2]
            if {$distance < $fs} {
                incr counter
                break
            }
        }
    }
}

set counter [expr $counter/($nf)*1.0]

puts "counter: $counter"






set nf [molinfo top get numframes]
set fs 3.3
set sel1 [atomselect top "type 1"]
set sel2 [atomselect top "type 7"]

set counter 0

for {set j 0} {$j < [$sel1 num]} {incr j} {
    for {set k 0} {$k < [$sel2 num]} {incr k} {
        set coord1 [lindex [$sel1 get {x y z}] $j]
        set coord2 [lindex [$sel2 get {x y z}] $k]
        set distance [vecdist $coord1 $coord2]
        if {$distance < $fs} {
            incr counter
            break
        }
    }
}

set counter [expr $counter/100.0]

puts "counter: $counter"
