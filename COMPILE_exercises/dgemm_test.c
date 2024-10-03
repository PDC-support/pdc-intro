#include <stdio.h>
#include <stdlib.h>
#include <cblas.h>

int main (int argc, char* argv[])
{
    int narow = 3, nacol = 5;
    int nbrow = 5, nbcol = 7;

    double* a = (double*)malloc(sizeof(double) * narow * nacol);
    double* b = (double*)malloc(sizeof(double) * nbrow * nbcol);

    for (int i = 0; i < narow; i++) {
        for (int j = 0; j < nacol; j++) {
            a[i * nacol + j] = (i * 2 + j) * 0.9;
        }
    }
    for (int i = 0; i < nbrow; i++) {
        for (int j = 0; j < nbcol; j++) {
            b[i * nbcol + j] = (i + j * 2) * 0.1;
        }
    }

    double* c = (double*)malloc(sizeof(double) * narow * nbcol);

    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, narow, nbcol, nacol, 1.0, a, nacol, b, nbcol, 0.0, c, nbcol);

    for (int i = 0; i < narow; i++) {
        for (int j = 0; j < nbcol; j++) {
            printf(" %8.3f ", c[i * nbcol + j]);
        }
        printf("\n");
    }
}
