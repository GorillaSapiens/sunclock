#!/usr/bin/env perl

`rm out*`;
for ($i = 0; $i < 60*24; $i ++) {
   $j = 20230505.55+ $i/(60*6);
   print "$i\n";
   print `TZ=IST ./calcdataprecise 19 73 $j`;
   $x = sprintf("out_%04d.png", $i);
   `convert -size 1024x1024 -depth 8 RGBA:out.bin $x`;
}

`convert -delay 25 out*.png out.gif`;