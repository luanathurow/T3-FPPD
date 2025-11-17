# Parallel Implementation of Mandelbrot Fractals

This repository was forked from [abagali1/mandelbrot](https://github.com/abagali1/mandelbrot) and modified for use in my **"Fundamentals of Parallel and Distributed Processing"** class. The changes were made mainly to enable students to run parallel programs on our computer cluster, which uses the SLURM workload manager, and align the examples with the course objectives. By exploring this repository, students can gain hands-on experience executing and analyzing parallel computations in a real-world environment.

## Mandelbrot Fractals

Mandelbrot fractals are a class of mathematical objects that arise from the iterative application of a simple formula in complex numbers. Named after the mathematician Benoît B. Mandelbrot, these fractals are famous for their intricate and infinitely detailed structures. They are visualized as a set of points in the complex plane that remain bounded under repeated iteration of a specific equation.

![Mandelbrot Equation](https://latex.codecogs.com/png.latex?z_{n%2B1}%20=%20z_n^2%20+%20c)

This simple recursive formula gives rise to patterns that exhibit self-similarity, meaning smaller parts of the fractal resemble the whole. Mandelbrot fractals are not only visually captivating but also provide deep insights into chaos theory, complex dynamics, and mathematical beauty.


## Repository Structure

```
.
├── mandelbrot_seq.c       # Sequential implementation
├── mandelbrot_mpi.c       # MPI parallel implementation
├── batch-job-mpi.sh       # SLURM batch script for MPI
├── output/                # Generated images directory
└── README.md
```

## Sequential Implementation


```bash
gcc mandelbrot_seq.c -o mandelbrot_seq -lm
srun --nodes=1 --ntasks=1 ./mandelbrot_seq
```

Images are generated in .ppm format and stored in the `./output` directory. You can open them directly with compatible viewers using a command like:

```bash
open output/ms.ppm
```

Alternatively, convert them to other formats (e.g., .png) using ImageMagick:

```bash
convert output/ms.ppm output/ms.png
```

![mandelbrot](https://github.com/mvneves/parallel-mandelbrot-mpi/raw/master/output/readme.png)


## Parallel Implementation with MPI

```bash
mpicc mandelbrot_mpi.c -o mandelbrot_mpi -lm
srun --nodes=2 --ntasks=16 mandelbrot_mpi
```

Explanation:
- --nodes=2: Allocates two nodes.
- --ntasks=16: Executes 16 tasks (process), 8 per node.

or as batch job
```bash
sbatch batch-job-mpi.sh
```

