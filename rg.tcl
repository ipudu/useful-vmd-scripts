set nf [molinfo top get numframes]
set sel [atomselect top "index 0 to 1001"]

set rg 0

for {set i 0} {$i < $nf} {incr i} {
    puts "frame $i of $nf"
    $sel frame $i
    set rg [vecadd $rg [measure rgyr $sel]]
}
set rg [vecscale $rg [expr 1.0/$nf]]


puts "Radius of gyration: $rg"
