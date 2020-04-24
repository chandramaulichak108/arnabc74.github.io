a = 0; b = 1

lst = 0:20
temp = 1+outer(lst,lst,'+')
M = (b^temp-a^temp)/temp

`%dot%` = function(p,q) {
    p %*% M %*% q
}


`%along%` = function(u,v) c((u %dot% v) / (v %dot% v)) * v

poly = function(coef) {
    temp = rep(0,21)
    temp[1:length(coef)] = coef
    temp
}

polyfun = function(coef,x) {
    temp = coef[21]
    for(i in 10:1) 
        temp = temp*x + coef[i]
    temp
}

U = diag(21)
V = matrix(0,21,21)
for(i in 1:21) {
    V[i,] = U[i,]
    if(i == 1) next
    comp = 0
    for(j in 1:(i-1))
        comp = comp+(U[i,] %along% V[j,])
    V[i,] = V[i,] - comp
}

