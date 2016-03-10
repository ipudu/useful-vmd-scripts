#distance seltext1 seltext2 N_d f_r_out f_d_out

set seltext1 "index 999 to 1000"
set seltext2 "index 2001 to 2002"
set N_d 100
set f_r_out "distance_aggdi_charge.dat"
set f_d_out "distribution_aggdi_charge.dat"
set sel1 [atomselect top "$seltext1"]
set sel2 [atomselect top "$seltext2"]
set nf [molinfo top get numframes]


set outfile [open $f_r_out w]
for {set i 0} {$i < $nf} {incr i} {
    puts "frame $i of $nf"
    $sel1 frame $i
    $sel2 frame $i
    set com1 [measure center $sel1 weight mass]
    set com2 [measure center $sel2 weight mass]
    set dis [veclength [vecsub $com1 $com2]]
    set simdata($i.r) $dis
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
    set distribution($k) 0
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
