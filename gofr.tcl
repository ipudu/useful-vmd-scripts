set nf [molinfo top get numframes]
set sel1 [atomselect top "index 0 to 1001"]
set sel2 [atomselect top "index 0 to 1001"]
set gr [measure gofr $sel1 $sel2 delta .1 rmax 10 first 0 last 1]

set outfile [open gofr.dat w]

set r [lindex $gr 0]
set gr2 [lindex $gr 1]
set igr [lindex $gr 2]

set i 0
foreach j $r k $gr2 l $igr {
    puts $outfile "$j $k $l"
}

close $outfile
