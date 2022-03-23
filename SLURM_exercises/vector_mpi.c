#include <mpi.h>
#include <stdio.h>
#include <unistd.h>

#define NROWS 16384
#define NCOLS 16384

double A[NROWS][NCOLS];

int main(int argc, char** argv) {
  int world_size,world_rank;
  int i, j;

  // Initialize the MPI environment
  MPI_Init(NULL, NULL);

  // Get the number of processes
  MPI_Comm_size(MPI_COMM_WORLD, &world_size);

  // Get the rank of the process
  MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

  // Print off a hello world message
  printf("Hello world from rank %d out of %d process\n", world_rank, world_size);

  // Initialize the matrix
  for(i = 0; i < NROWS; i++)
     for(j = 0; j < NCOLS; j++)
        A[i][j] = i + j;


  // Wait a bit to simulate some computation
  sleep(30);

  // Finalize the MPI environment.
  MPI_Finalize();
  return 0;
}
