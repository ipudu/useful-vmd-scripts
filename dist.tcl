set nf [molinfo top get numframes]
set cutoff 3.3
set sel1 [atomselect top "type 7"]
set sel2 [atomselect top "type 1"]

set counter 0
for {set i 0} {$i < $nf} {incr i} {
    $sel1 frame $i
    $sel2 frame $i
    set mylist [lindex [measure contacts $cutoff $sel1 $sel2] 0]
    set number [llength [lsort -unique $mylist]]
    set counter [expr $number + $counter ]
    puts "frame $i of $nf, number: $number, counter: $counter"

}

set counter [expr $counter*1.0/$nf]

puts "percent O-O: $counter %"
