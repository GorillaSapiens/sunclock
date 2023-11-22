#!/usr/bin/perl

`rm moon*.png`;

@x = (
"https://www.timeanddate.com/astronomy/australia/adelaide -34.9285 138.6007",
"https://www.timeanddate.com/astronomy/italy/rome 41.9028 12.4964",
"https://www.timeanddate.com/astronomy/antarctica/mcmurdo -77.8500 166.6667",
"https://www.timeanddate.com/astronomy/usa/honolulu 21.3099 -157.8581",
"https://www.timeanddate.com/astronomy/canada/tuktoyaktuk 69.4454 -133.0342",
"https://www.timeanddate.com/moon/usa/chicago 41.8781 -87.62.98"
);

$i = 0;
foreach $x (@x) {
   #print "$x\n";
   ($url, $lat, $lon) = split / /, $x;

   @place = split /\//, $url;
   $place = pop @place;

   $cmd = "(wget $url -O - 2>&1 | grep -a moon.php | sed \"s/.*moon.php//g\" | sed \"s/\\\".*//g\")";
   $cmd2 = "./calcdata $lat $lon";
   @a = `$cmd`;
   $a[0] =~ s/\&amp;/\&/g;
   $a[0] =~ s/^/https:\/\/www.timeanddate.com\/scripts\/moon.php/g;

   $cmd3 = "wget \"$a[0]\" -O moon.png";
   `$cmd3`;

   @b = `$cmd2`;
   print @b;

   `convert -size 1024x1024 -depth 8 RGBA:out.bin out.png`;

   `composite moon.png out.png moon$i\_.png`;

   `convert moon$i\_.png -strokewidth 3 -stroke white -fill black -pointsize 144 -gravity north -font DejaVu-Sans-Mono-Bold -draw "text 0,128 $place" moon$i.png`;

   $i++;
}

print `montage -border 0 -geometry 1024x moon0.png moon1.png moon2.png moon3.png moon4.png moon5.png moon0_all.png`;
print `mv moon0_all.png moon.png`;