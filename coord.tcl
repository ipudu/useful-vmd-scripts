set nf [molinfo top get numframes]
set cutoff 2.75
set sel1 [atomselect top "type 7"]
set sel2 [atomselect top "type 3"]
set cutoff2 [expr $cutoff ** 2]

set counter 0
for {set i 0} {$i < $nf} {incr i} {
    $sel1 frame $i
    $sel2 frame $i
    set cell [pbc get -first $i -last $i]
    set boxx [lindex [split [lindex $cell 0]] 0]
    set boxy [lindex [split [lindex $cell 0]] 0]
    set boxz [lindex [split [lindex $cell 0]] 0]
    set coord1 [$sel1 get {x y z}]
    set coord2 [$sel2 get {x y z}]
    set coordFrame 0

    foreach j $coord1 {
        set x1 [lindex $j 0]
        set y1 [lindex $j 1]
        set z1 [lindex $j 2]

        foreach k $coord2 {
            set x2 [lindex $k 0]
            set y2 [lindex $k 1]
            set z2 [lindex $k 2]

            set lx [expr {abs($x1 - $x2)}]
            set ly [expr {abs($y1 - $y2)}]
            set lz [expr {abs($z1 - $z2)}]
            if {$lx > $boxx / 2.0} {
                set lx [expr $lx - $boxx]
            }
            if {$ly > $boxy / 2.0} {
                set ly [expr $ly - $boxy]
            }
            if {$lz > $boxz / 2.0} {
                set lz [expr $lz - $boxz]
            }
            set  d2 [expr $lx ** 2 + $ly ** 2 + $lz ** 2]
            if {$d2 <= $cutoff2} {
                incr counter
                incr coordFrame
            }
        }
    }
    puts "frame $i of $nf, coordnumber: [expr $coordFrame * 1.0 / [$sel1 num]]"
}
puts "avgCoord: [expr $counter * 1.0 / ($nf * [$sel1 num])]"
