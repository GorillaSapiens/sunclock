#!/bin/sh

##  Sunclock, draw a clock with local solar and lunar information
##  Copyright (C) 2022 Adam Wozniak / GorillaSapiens
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <https://www.gnu.org/licenses/>.

echo LC_ALL=$LC_ALL
echo LANG=$LANG

for WIDTH in 128 512 768 1000 1024 1048 1440 2048 4096
do
echo ====== WIDTH=$WIDTH ./calcdata 34.0007 -81.0348 $1 $2
WIDTH=$WIDTH ./calcdata 34.0007 -81.0348 $1 $2
convert -size $WIDTH\x$WIDTH -depth 8 RGBA:out.bin tmp.png
mv tmp.png out_$WIDTH.png
done
