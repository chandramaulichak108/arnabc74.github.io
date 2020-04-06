jacobi = function(A) {
    ## Find max abs off diag entry
    n = nrow(A)

    mx = abs(A[2,1])
    mi = 2; mj = 1
    for(i in 2:n) {
        for(j in 1:(i-1)) {
            if(mx < abs(A[i,j])) {
                mi = i; mj = j; mx = abs(A[i,j]);
            }
        }
    }
    cat(mx,"\n")

    ## Compute theta
    theta = atan2(2*A[mi,mj] , A[mj,mj]-A[mi,mi])/2

    ## Create rotation matrix
    sn = sin(theta); cs = cos(theta)
    G = diag(n); G[c(mi,mj),c(mi,mj)] = c(cs,sn,-sn,cs)

    ## Do the transformation
    G %*% A %*% t(G)
}
