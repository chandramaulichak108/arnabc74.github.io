gau=. 4 : '3*^-(*:x)+*:y'

f1=. 4 : 'x,((x gau y) + x gau y-5),y'

f2=. 4 : 'x,((x gau y) + 0.5*x gau y-5),y'


x=. _3 + 6*100%~i.100
z=. _3 + 11*100%~i.100

(x f1 s z) fwrite '1f1.obj'
(x f2 s z) fwrite '1f2.obj'
