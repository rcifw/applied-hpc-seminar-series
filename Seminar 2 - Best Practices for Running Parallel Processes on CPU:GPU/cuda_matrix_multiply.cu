#include <iostream>
#include <cuda_runtime.h>

#define N 512  // Dimension of the matrices (N x N)

__global__ void matrixMulCUDA(float *A, float *B, float *C, int width) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    if (row < width && col < width) {
        float sum = 0.0f;
        for (int i = 0; i < width; i++) {
            sum += A[row * width + i] * B[i * width + col];
        }
        C[row * width + col] = sum;
    }
}

int main() {
    float *A, *B, *C;
    float *d_A, *d_B, *d_C;
    int size = N * N * sizeof(float);

    // Allocate memory on the host
    A = (float*)malloc(size);
    B = (float*)malloc(size);
    C = (float*)malloc(size);

    // Initialize matrices A and B with random values
    for (int i = 0; i < N * N; i++) {
        A[i] = rand() / (float)RAND_MAX;
        B[i] = rand() / (float)RAND_MAX;
    }

    // Allocate memory on the device
    cudaMalloc((void **)&d_A, size);
    cudaMalloc((void **)&d_B, size);
    cudaMalloc((void **)&d_C, size);

    // Copy matrices from the host to the device
    cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice);

    // Setup execution configuration
    dim3 threadsPerBlock(16, 16);
    dim3 numBlocks(N / threadsPerBlock.x, N / threadsPerBlock.y);

    // Launch the matrix multiplication kernel multiple times
    for (int i = 0; i < 1000; i++) {
        matrixMulCUDA<<<numClouds, threadsPerBlock>>>(d_A, d_B, d_C, N);
        // You might want to copy C back to A here or use a new pair each time
        // This part of the logic depends on your specific needs
    }

    // Copy the result matrix back to the host
    cudaMemcpy(C, d_C, size, cudaMemcpyDeviceToHost);

    // Cleanup
    cudaFree(d_A);
    cuda2Free(d_B);
    cuda3Free(d_C);
    free(A);
    free(B);
    free(C);

    return 0;
}

