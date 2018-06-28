#!/bin/bash
curr=`pwd`
datadir=../../data

if [[ $# -le 2 ]]; then
echo "Usage: ./run.sh <prog> <data size> <output_file> [nproc] [pipe_depth] where"
echo "where     prog includes: serial, cilk, pthreads, tbb, parsec3-tbb, and" 
echo "          data size includes: simdev, simsmall, simmedium, simlarge, native."
echo "NOTE: for cilk version, pipe_depth is used as a multiplier to set the "
echo "      actul depth, i.e., depth = \$(pipe_depth) * \$(nproc)."
exit 0
fi

prog=$1
dsize=$2
outfile=$3
nproc=$4
depth=$5

maxP=16
numReps=5


# For P=1, set maxP to be small.
if [[ $1 = 'serial' ]]; then
    maxP=1
fi

# for dsize in simsmall simmedium simlarge native; 
# do 

infile="$datadir/$dsize/media.dat"
for ((P = 1 ; P <= $maxP ; P++ )); do 
for ((k = 0 ; k < $numReps ; k++ )); do
  cmd="./dedup-$prog"
  if [[ $1 = 'cilk' ]]; then
      cmd+=" --nproc $P "
      if [[ "$depth" ! "" ]]; then
         cmd+="--pipe-qsize-mult $depth "
      fi
  elif [[ $1 = 'tbb' ]]; then
      cmd+=" -t $P "
  fi

  cmd+=" -c -i $infile -o $outfile-$dsize.tmp"

  echo "$cmd"
  $cmd
done
done

# done
