#!/bin/bash
read -p "Enter your Password " P

if [ "$1" = "-h"  -o "$1" = "--help" ]    
then                                       
  cat <<DOCUMENTATIONXX
NAME
       sqopper helps to move rdbms data to HDFS File system using SQOOP.

SYNOPSIS
       sqooper [OPTION]...

DESCRIPTION
       Concatenate FILE(s), or standard input, to standard output.
       
       -r,   --run
              to start the program

       -q,   --query
              import with conditions

       -i,   --increment
              import with incremental method

       -s,  --split-by
              split the data
         
       -gui, --graphical-interface
              open a graphical interface in browser


AUTHOR
       Written by Akash M.

REPORTING BUGS
       Report hadooports bugs to akash.m@infocepts.com
       Apache Hadoop home page: <http://hadoop.apache.org/>

COPYRIGHT
       Copyright  ©  2023
       This is free software: you are free  to  change  and  redistribute  it.
       There is NO WARRANTY, to the extent permitted by law.

CREATED 
       Created on 16-04-2023:12:19
DOCUMENTATIONXX
exit $DOC_REQUEST


elif [ "$1" = "-r"  -o "$1" = "--run" ]
then
read -p "choose Database " D
read -p "Table name? " T
read -p "Column names? " C
read -p "Location? " L
read -p "Number of Mappers? " M
sqoop import --connect jdbc:mysql://localhost:3306/$D --username root --password $P --table $T --columns $C -m $M --target-dir $L

elif [ "$1" = "-q"  -o "$1" = "--query" ]
then
read -p "choose Database " D
read -p "Table name? " T
read -p "Column names? " C
read -p "Query? " Q
read -p "Location? " L
read -p "Number of Mappers? " M
sqoop import --connect jdbc:mysql://localhost:3306/$D --username root --password $P --query "select $C from $T where $Q  and \$CONDITIONS" -m $M --target-dir $L

elif [ "$1" = "-i"  -o "$1" = "--increment" ]
then
read -p "choose Database " D
read -p "Table name? " T
read -p "Column names? " C
read -p "Query? " Q
read -p "Location? " L
read -p "Number of Mappers? " M
read -p "Check Column? " CC
read -p "Last Value? " LV
sqoop import --connect jdbc:mysql://localhost:3306/$D --username root --password $P --table $T -m $M --target-dir $L --incremental append --check-column $CC --last-value $LV 

elif [ "$1" = "-s"  -o "$1" = "--sqlit" ]
then
read -p "choose Database " D
read -p "Table name? " T
read -p "Column names? " C
read -p "Query? " Q
read -p "Split by? " S
read -p "Location? " L
read -p "Number of Mappers? " M

sqoop import --connect jdbc:mysql://localhost:3306/$D --username root --password $P --query "select $C from $T where $Q  and \$CONDITIONS" --split-by $S -m $M --target-dir $L
fi











