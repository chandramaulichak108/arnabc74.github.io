L = matrix(sample(10,25,rep=T),5)
U = matrix(sample(10,25,rep=T),5)
L[upper.tri(L)] = 0
U[lower.tri(U)]=0
diag(U) = 1
A = L%*% U
