#!/bin/bash
#SBATCH --job-name=mandelbrot-mpi
#SBATCH --time=00:15:00
#SBATCH --output=_%j.out

# Parameters of fractal
WIDTH=1920
HEIGHT=1080
ITER=1000

# Compile parallel version
mpicc mandelbrot_mpi.c -o mandelbrot_mpi -lm

# Output file
echo "ntasks,nodes,ht_flag,time" > results.csv

# Test loop
for nt in 2 4 6 8 10 12 14 16; do
    # Calculate number of nodes (assuming 8 cores per node)
    nodes=$(( (nt + 7) / 8 ))

    # Test without Hyper-Threading
    echo "Executando $nt processos em $nodes nós (HT=off)"
    start=$(date +%s.%N)
    srun --nodes=$nodes --ntasks=$nt --cpus-per-task=1 ./mandelbrot_mpi $WIDTH $HEIGHT $ITER
    end=$(date +%s.%N)
    runtime=$(echo "$end - $start" | bc)
    echo "$nt,$nodes,off,$runtime" >> results.csv

    # Test with Hyper-Threading
    echo "Executando $nt processos em $nodes nós (HT=on)"
    start=$(date +%s.%N)
    srun --nodes=$nodes --ntasks=$nt --cpus-per-task=2 ./mandelbrot_mpi $WIDTH $HEIGHT $ITER
    end=$(date +%s.%N)
    runtime=$(echo "$end - $start" | bc)
    echo "$nt,$nodes,on,$runtime" >> results.csv
