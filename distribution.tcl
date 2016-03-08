#compute the distance distribution between two atoms
set sel1 [atomselect top "index 999"]
set sel1 [atomselect top "index 1000"]
set nf [molinfo top get numframes]
set f_r_out distance.dat
set f_d_out distribution.dat
set N_d 100

set outfile [open $f_r_out w]
for {set i 0} {$i < $nf} {incr i} {
    puts "frame $i of $nf"
    $sel1 frame $i
    $sel2 frame $i
    set coord1 [$sel1 get {x y z}]
    set coord2 [$sel2 get {x y z}]
    set simdata($i.r) [veclength [vecsub $coord1 $coord2]]
    puts $outfile "$i   $simdata($i.r)"
}
close $outfile


set r_min $simdata(0.r)
set r_max $simdata(0.r)

for {set i 0} {$i < $nf} {incr i} {
    set r_tmp $simdata($i.r)
    if {$r_tmp < $r_min} {set r_min $r_tmp}
    if {$r_tmp > $r_max} {set r_max $r_tmp}
}

set dr [expr ($r_max - $r_min) / ($N_d -1)]
for {set k 0} {$k < $N_d} {incr k} {
    set distribution(k) 0
}
for {set i 0} {$i < $nf} {incr i} {
    set k [expr int(($simdata($i.r) - $r_min) / $dr)]
    incr distribution($k)
}

set outfile [open $f_d_out w]
for {set k 0} {$k < $N_d} {incr k} {
    puts $outfile "[expr $r_min + $k * $dr] $distribution($k)"
}
close $outfile
