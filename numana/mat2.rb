<NOTE>
@{
<M>\newcommand{\bx}{{\bf x}}
\newcommand{\by}{{\bf y}}
\newcommand{\bb}{{\bf b}}
\newcommand{\be}{{\bf e}}
\newcommand{\bv}{{\bf v}}
\newcommand{\bz}{{\bf 0}}
\newcommand{\bxi}{{\bf \xi}}
\newcommand{\bc}{{\bf c}}
\newcommand{\zbar}{\overline{z}}
\newcommand{\cald}{{\mathcal D}}
</M>

<TITLE>Matrix algorithms</TITLE> 
<UPDT>SUN APR 26 IST 2020</UPDT>
<HEAD1>Matrix algorithms</HEAD1> 


<HEAD1>Linear equations behind a soap film!</HEAD1>
If you dip a wire frame in a soap solution, then a thin film of soap water
will cling to it.
<CIMG web="soap12.png"></CIMG>
Given the shape of the frame, we want to find the natural shape of the film. This is an important
question in architecture, where a structure must be given the most
natural shape to reduce stress. 
<P/>
It is known that a soap film will always occupy the position that
minimises its elastic potential energy. In the next section we
shall see how to express this mathematically.

<HEAD2>Coordinate system</HEAD2>
We imagine an <M>xy</M>-plane under the frame:
<CIMG web="soap3.png">Coordinate system</CIMG>
If the surface is given by a function <M>u(x,y),</M> then its
elastic potential energy is given by
<D>
E(u) = \iint_R (u_x)^2 + (u_y)^2\, dxdy.
</D>
This is to be minimised subject to the boundary condition that
the <M>u(x,y)</M> must match the frame height at the boundary.
<P/>
In general, this is a difficult/impossible problem to solve
analytically. 

<HEAD2>Numerical solution</HEAD2>
To proceed numerically, one starts with a
triangulation of the base. 
<CIMG web="basis0.png">Triangulation</CIMG>
Then the aim is to find the value of <M>u(x,y)</M> at the
vertices. Let <M>c_j</M> denote the value of <M>u(x,y)</M> at the
<M>j</M>-th vertex. 
<P/>
Since the target function involves <M>u_x</M>
and <M>u_y</M>, we need to somehow approximate them using only
the values at the vertices. For this we choose a set of <B>basis
function</B>s, one for each vertex. It is constructed by "pulling
up" the vertex to a height 1, while leaving all the other
vertices at height 0. Here are two examples:
<CIMG web="basis12.png">Two basis functions</CIMG>
Notice that the graph of each basis function (<M>\phi_j</M>) is a plane over 
each triangle (<M>T_i</M>).  and hence we may write a basis
function <M>\phi_j(x,y)</M> as
<D>
\phi_j(x,y) = \alpha_{ij} + \beta_{ij}x + \gamma_{ij} y \quad\mbox{
for } (x,y)\in T_i.
</D>
for suitable numbers <M>\alpha_{ij},</M> <M>\beta_{ij}</M>
and <M>\gamma_{ij}</M>.
Also, notice that <M>\alpha_{ij}, \beta_{ij},
\gamma_{ij}</M>'s are zero if the <M>j</M>-th vertex is not part
of <M>T_i</M>. Thus, most of these numbers are actually zero.

<P/>
Then we can approximate <M>u(x,y)</M> by
<D>
u(x,y) = \sum_j c_j \phi_j(x,y).
</D>
Thus, the problem of finding <M>u(x,y)</M> reduces to finding the
finitely many numbers <M>c_j</M>'s.
<P/>
Now 
<D>
u_x(x,y) = \sum_j c_j\beta_{ij} \mbox{ for } (x,y)\in T_i^\circ,
</D>
where <M>T_j^\circ</M> denotes the interior of <M>T_j.</M>
<P/>

Similarly for <M>u_y(x,y).</M>
<P/>
Hence we have
<D>
E(u) = \sum_i \iint_{T_i^\circ} (\sum_j c_j \beta_{ij})^2 + (\sum_j c_j\gamma_{ij})^2 
  = \sum_i |T_i| \{ (\sum_j c_j \beta_{ij})^2 + (\sum_j c_j\gamma_{ij})^2 \},
</D>
where <M>|T_i|</M> denotes the area of <M>T_i</M> (same as the
area of <M>T_i^\circ</M>).
<P/>

Thus, 
<D>
E(u) = \bc' M\bc,
</D>
where <M>M</M> is the NND matrix with <M>(j,j')</M>-th entry given
by 
<D>
m_{jj'} = \sum_i |T_i| (\beta_{ij}\beta_{ij'} + \gamma_{ij} \gamma_{ij'}).
</D>

<HEAD2>Solving</HEAD2>
Suppose that the last <M>k</M> of the <M>c_j</M>'s are
known frame heights. Partition <M>\bc</M>
as <M>(\bc_1,\bc_2).</M> Then <M>\bc_2</M> is known,
and <M>\bc_1</M> is to be chosen to minimise <M>E(u).</M>
<P/>
Let us partition <M>M</M> accordingly as
<D>
M = <MAT>M_{11} & M_{12}\\M_{21} & M_{22}</MAT>.
</D>
Then 
<D>
\bc' M\bc = <MAT>\bc_1' & \bc_2'</MAT><MAT>M_{11} &
M_{12}\\M_{21} & M_{22}</MAT> <MAT>\bc_1\\\bc_2</MAT> = 
\bc_1' M_{11}\bc_1 + 2\bc_1' M_{12}\bc_2 + \bc_2' M_{11}\bc_2.
</D>
Differentiating w.r.t. <M>\bc_1</M>, and equating to zero, we get
<D>
M_{11}\bc_1 + M_{12}\bc_2 = \bz,
</D>
or
<D>
M_{11}\bc_1 = - M_{12} \bc_2.
</D>
<Q>
<ALERT/>Here is a <LINK to="multidiff.html">quick primer</LINK>
of multivariate differentiation, in case you need one.
</Q>
It is a simple linear algebra exercise to show that this is
always consistent. In fact, <M>M_{11}</M> will also be
nonsingular (not easy to prove). So the problem always has unique solution. 


<HEAD2>Practical problem</HEAD2>
However,
there is a practical difficulty. To get a reasonable
approximation we need the number of vertices to be pretty
large. In our example, the vertices are in a rectangular array formed
by subdividing the sides of the base. If we use 100 subdivisions
in both directions, then the number of vertices is <M>101^2,</M>
of which <M>99^2=9801</M> are interior vertices. Thus, we need to
solve <M>9801</M> equations in as many unknowns! For many real
life problem we need even more vertices:
<CIMG web="camgrid.png">Many vertices are needed to capture the
nooks and corners.</CIMG>
<P/>
However, notice that <M>M_{11}</M> is an extremely sparse
matrix. Each row contains just 6 nonzero entries. Using
Gauss-Jordan elimination is not a good idea in such a case, as it
destroys the sparseness of the system. There are special
algorithms for such cases that we shall learn now.

<COMMENT>
<J>
99^2
n=.10
(],. 10&+,. 1&|.) i.n
(],. 10&+,. (_1&|.)@(10&+)) i.n

f=: 4 :'x,y,(x*y) + (1-x)*y^3'
b=: 4 :'x,y,0'
t=: 29%~i.30
((f s)~ t) fwrite 't.obj'
((b s)~ 4%~i.5) fwrite 'b.obj'
</J>
<D>
E(u) = \int_R u_x^2 + u_y^2. 
</D>
We approximate <M>u</M> with 
<D>
u(x,y) = \sum_j c_j \phi_j(x,y),
</D>
where 
<D>
\phi_j(x,y) = \alpha_{ij} + \beta_{ij}x + \gamma_{ij} y \mbox{
for } (x,y)\in T_i.
</D>
So 
<D>
u_x(x,y) = \sum_j c_j\beta_{ij} \mbox{ for } (x,y)\in T_i^\circ.
</D>
Hence
<D>
E(u) = \sum_i \int_{T_i} (\sum_j c_j \beta_{ij})^2 + (\sum_j c_j\gamma_{ij})^2 
  = \sum_i |T_i| \{ (\sum_j c_j \beta_{ij})^2 + (\sum_j c_j\gamma_{ij})^2 \}.
</D>
Thus, 
<D>
E(u) = \bc' M\bc,
</D>
where <M>M</M> is the PD matrix with <M>(j,j')</M>-th entry given
by 
<D>
m_{jj'} = \sum_i |T_i| (\beta_{ij}\beta_{ij'} + \gamma_{ij} \gamma_{ij'}).
</D>
Suppose that the last <M>k</M> of the <M>c_j</M>'s are
known. Partition <M>\bc</M> as <M>(\bc_1,\bc_2).</M> Then 
for minimum <M>E(u)</M> we need 
<D>
\bc_1 = M_{11} ^{-1} M_{12} \bc_2.
</D>
Here <M>M_{11}</M> is sparse.
</COMMENT>

<HEAD1>Iterative methods for linear systems</HEAD1>
Gauss and Gauss-Jordan elimination suffer from one problem:
accumulation of errors. If the system is large then the solution obtained
by these methods is usually not as precise as can be desired. Remember
that due to finite precision of the computer <I>some</I> error is always
inevitable. But the the solution obtained by Gauss or Gauss-Jordan
eliminations often produce error larger than the minimum error possible
with the machine. In such situation one may try to improve the precision of
the solution by applying iterative methods like the one discussed
below. However, this is not the most popular reason for the using
iterative methods.

A more compelling reason to use these methods is when the system is
<I>sparse.</I> A sparse system is where many of the entries of the
coefficient matrix are <I>known to be zero.</I> Such matrices occur in
different applications. Gauss and Gauss-Jordan eliminations cannot take
advantage of the zeros. The iterative methods on the other hand work faster
for sparse matrices.


<HEAD2>Gauss-Jacobi method</HEAD2>
Consider  a linear system of equations
<D>
A\bx={\bf b},
</D>
where <M>A</M> is a square matrix.
<EXM>
Suppose that you are to solve
<MULTILINE>
20x+3y-4z & =&  19\\
x-4y+z & =&  -3\\
x-4y+10z & =&  7.
</MULTILINE>
The system has three equations in three unknowns. To solve it by
Gauss-Jacobi method we solve for <M>x</M> in the first equation, for
<M>y</M> in the second equation and so on. Solving for <M>x</M> in the
first equation means keeping <M>x</M> in the left hand side and taking
everything else to the right hand side:
<D>
x = (19-3y+4z)/20.
</D>
Similarly, we get three equations by solving for <M>x,y,</M> and <M>z</M>
from the three equations:
<MULTILINE>
x & =&  (19-3y+4z)/20\\
y & =&  (3+x+z)/4\\
z & =&  (7-x+4y)/10.
</MULTILINE>
Now take any three numbers
<M>x_0,y_0</M> and <M>z_0</M>
as initial guesses for <M>x,y</M>and <M>z.</M> Suppose that we take
<D>
<MAT>x_0\\y_0\\z_0</MAT> = <MAT>0\\0\\0</MAT>.
</D>
Use these in the right hand sides of the three equations, to compute 
<M>x_1,y_1,z_1.</M> Thus,
 <D>
<MAT>x_1\\y_1\\z_1</MAT> = <MAT>(19-3y_0+4z)/20\\
(-3+x_0+z_0)/4\\
(7-x_0+4y_0)/10
</MAT> = <MAT>0.9500\\0.7500\\0.7000 </MAT>.
</D>
Similarly, we get <M>x_2,y_2,z_2</M> from <M>x_1,y_1,z_1,</M> and so
on. We show the values of <M>x_i,y_i,z_i</M> for <M>i=0,1,...,5:</M>

<PRE>
i      x_i        y_i        z_i
----------------------------------
0   0          0          0
1   0.980356   1.255969   1.092588
2   0.980122   1.268236   1.104352
3   0.980635   1.271119   1.109282
4   0.981189   1.272479   1.110384
5   0.981205   1.272893   1.110873
6   0.981241   1.273019   1.111037
7   0.981254   1.273069   1.111084
8   0.981256   1.273085   1.111102
9   0.981258   1.273090   1.111108
10   0.981258   1.273091   1.111110
</PRE>
Thus, after 10 iterations our answer is 
<D>
<MAT>x\\y\\z</MAT> = <MAT>0.981258 \\ 1.273091\\ 1.111110</MAT>.
</D>
This is called the Gauss-Jacobi method.
How accurate is this answer? To check this let us compute 
<D>
A\bx-{\bf b}.
</D>
Ideally, it should be the zero vector. For our answer it turns out to be
<D>
<MAT>-0.000002\\0.000002\\-0.000007</MAT>,
</D>
which is quite close to zero.
</EXM>

<HEAD2>Gauss-Seidel method</HEAD2>
This is a method very similar to the above. 

<EXM>
Let us consider the same system of
equation once again. As before, we shall solve for <M>x</M> from the first
equation, for <M>y</M> from the second equation, and so on. Thus, we
arrive at the three equations (as before):
<MULTILINE>
x & =&  (19-3y+4z)/20\\
y & =&  (3+x+z)/4\\
z & =&  (7-x+4y)/10.
</MULTILINE>
Again, start with, say, 
<D>
<MAT>x_0\\y_0\\z_0</MAT> = <MAT>0\\0\\0</MAT>.
</D>
But this time, apply the equations <I> one by one.</I> Thus, we first
compute <M>x_1</M> as
<D>
x_1 =  (19-3y_0+4z_0)/20 = 0.95.
</D>
Then we compute <M>y_1</M> using this <M>x_1</M>
<D>
y_1 = (3+x_1+z_0)/4 = 0.9875.
</D>
Observe that we are using <M>x_1</M> and <M>z_0</M> in the right hand side.
This is the only difference between between the Gauss-Seidel and
Gauss-Jacobi method. In Gauss-Seidel method we always use the most recent
value available. Thus, to compute <M>z_1</M> we shall use the most recent
values of <M>x</M> and <M>y,</M> namely, <M>x_1</M> and <M>y_1:</M>
<D>
z_1 = (7-x_1+4y_1)/10.
</D> 
Then we shall compute <M>x_2</M> from <M>y_1,z_1.</M> After that we shall
compute <M>y_2</M> from <M>x_2,z_1,</M> and so on. We show the values of
<M>x_i,y_i,z_i</M> in the following table for <M>i=0,1,...,10.</M>
<PRE>
i      x_i        y_i       z_i
----------------------------------
0   0          0          0
1   0.950000   0.987500   1.000000
2   1.001875   1.250469   1.100000
3   0.982430   1.270607   1.110000
4   0.981409   1.272852   1.111000
5   0.981272   1.273068   1.111100
6   0.981260   1.273090   1.111110
7   0.981259   1.273092   1.111111
8   0.981258   1.273092   1.111111
9   0.981258   1.273092   1.111111
10   0.981258   1.273092   1.111111
</PRE>
</EXM>

<HEAD2>Convergence issues</HEAD2>
The following discussion involves some advanced techniques, and
I have skipped the proofs of the some of the results. For a
comprehensive discussion see the book <I>Matrix Computations</I>
by Golub and Van Loan.

<P/>

Both these methods are special cases of splitting methods, where
a nonsingular system 
<D>
A\bx = \bb
</D>
is written as 
<D>
M\bx = N\bx + \bb.
</D>
Here <M>A</M> is split as <M>M-N</M> with <M>M</M> nonsingular. Then 
<D>
\bx = M^{-1} N \bx + M^{-1}\bb.
</D> 
We use the iteration
<D>
\bx_{n+1} = M^{-1} N \bx_n + M^{-1}\bb.
</D>
<EXM>
In Gauss-Jacobi  <M>M</M> consists of the diagonal elements
of <M>A.</M> 
</EXM>

<EXR ref="" paper="">
What is <M>M</M> in the Gauss-Seidel method?
</EXR>

Let the actual solution be <M>\bxi = A^{-1}\bb.</M> Then 
<D>
\bxi = M^{-1} N \bxi + M^{-1}\bb.
</D>
Subtracting this from the last equation we get 
<D>
\bx_{n+1}-\bxi = M ^{-1} N (\bx_n-\bxi),
</D>
or 
<D>\be_{n+1}  =  M^{-1} N \be_n,</D>
where <M>\be_n = \bx_n-\bxi</M> is the error committed in step <M>n</M>.

<P/>

We need some condition of <M>M ^{-1} N</M> for the
sequence <M>(\be_n)</M> to converge to <M>\bz.</M> 
A necessary and sufficient condition is based on the following
definition.
<DEFN name="Spectral radius">
If <M>A</M> is a real square matrix with
eigenvalues <M>\lambda_1,...,\lambda_n</M> (possibly complex),
then the <B>spectral radius</B> of <M>A</M> is the maximum of <M>|\lambda_1|,...,|\lambda_n|.</M> 
</DEFN>

<THM>A necessary and sufficient condition for <M>\be_n\to \bz</M> is that 
the spectral radius of <M>M^{-1}N</M> is <M><  1.</M></THM>

This is not very easy to prove. In fact, even checking that the
spectral radius is <M>< 1</M> is not easy. We shall discuss two
sufficient condtions for this: strict diagonal dominance in case
of Gauss-Jacobi, and
positive definiteness in case of Gauss-Seidel.


<HEAD3>Strict diagonal dominance</HEAD3>

<DEFN name="Strict diagonal dominance">A matrix <M>A_{n\times
n}</M> is said to have the <B>strict diagonal dominance</B>
property if for all <M>i=1,...,n,</M>
<D>
|a_{ii}| > \sum_{j\neq i} |a_{ij}|.
</D></DEFN>


<EXM>
The following matrix has strict diagonal dominance property:
<D>
<MAT>10& 1& -5\\-1& 3& 1\\1& 3& 20</MAT>.
</D>
However the matrix below does not have the property.
<D>
<MAT>1& 2& -3\\2& 14& 3\\3& 4& 10</MAT>,
</D>
since in the first row
<D>
1 \not > 2+|-3|. 
</D>
</EXM>


<THM>
Let <M>A</M> be a matrix with strict diagonal dominance. Then
the Gauss-Jacobi method must converge.
</THM>
<PF>
Enough to show that the spectral radius of <M>C=M^{-1}N</M> is <M><1.</M>
Here the <M>(i,j)</M>-th element of <M>C</M> is
<D>
c_{ij} = <CASES>
    -\frac{a_{ij}}{a_{ii}} <IF>i\neq j</IF>
0 <ELSE/>
</CASES>
</D>

Thus <M>\forall i~~\sum_j |c_{ij}| <  1.</M>

This implies that all the eigen values of <M>C</M> must
have moduli <M><  1.</M>
<BECAUSE>
Let <M>\lambda</M> be an eigen value
of <M>C,</M> and let <M>\bv</M> be a corresponding
eigen vector.


Let the <M>k</M>-th entry of <M>\bv</M> have max modulus:
<D>
\forall i~~|v_k| \geq |v_i|.
</D>

Then consider the <M>k</M>-th row of <M>\lambda\bv = C\bv</M>
to have
<D>
\lambda v_k= \sum_j c_{kj} v_j, 
</D> 
or,
<D>
|\lambda| |v_k|\leq \sum_j |c_{kj}| |v_j|  \leq |v_k|\sum_j
|c_{kj}|, 
</D> 
or
<D>
|\lambda| \leq \sum_j|c_{kj}| <  1. 
</D> 
</BECAUSE>
So spectral radius of <M>C</M> must be <M><1,</M> as well.
</PF>


<HEAD3>Positive definiteness</HEAD3>
<THM>
The Gauss-Seidel method converges if the coefficient matrix is
positive definite.
</THM>
<PF>
Here the coefficient matrix can be written as
<D>
A = L + D + L',
</D>
where <M>L</M> is the strict lower triangular half, <M>D</M> is
the diagonal part (and so <M>L'</M> is the strict upper
triangular half). Then the Gauss-Seidel method uses the splitting
<M>A = M - N</M>, where
<D>
M = L+D\mbox{ and } N = -L'.
</D>
So enough to show that <M>C = M ^{-1} N =   -(L+D)^{-1}L'</M> has
spectral radius <M><1,</M> i.e, all eigen values of <M>C</M>
has moduli <M><  1.</M>

<P/>

Now eigen values of <M>C</M> are the same as the eigen values of 
<MULTILINE>
C_1 
& =&  D^{1/2}CD^{-1/2} \\
& =&  -D^{1/2}(L+D)^{-1}L'D^{-1/2}\\
&  = &  
-D^{1/2}(L+D)^{-1}D^{1/2}D^{-1/2}L'D^{-1/2}\\
&  = & 
-(I + L_1)^{-1} L_1', 
</MULTILINE>
where <M>L_1=D^{-1/2}LD^{-1/2}.</M>
Notice that though <M>C_1</M> is similar to <M>C,</M>
but <M>L_1</M> may not be similar to <M>L.</M>

<P/>

Now let <M>\lambda</M> be any eigen
value of <M>C_1.</M> Take any eigen vector <M>\bx</M> with 
<M>\bx^*\bx=1.</M>

Then <M>C_1\bx = \lambda \bx,</M> i.e., <M>-(I + L_1)^{-1}
L_1'\bx = \lambda \bx,</M> or
<D>
-L_1'\bx = \lambda(I+L_1)\bx,
</D>
and so
<D>
-\bx^*L_1'\bx = \lambda\bx^*(I+L_1)\bx = \lambda(1+\bx^*L_1\bx).
</D>

Let <M>z=\bx^*L_1\bx.</M> Then <M>\bx^*L_1'\bx=\zbar.</M>
So we have 
<D>
-\zbar = \lambda(1+z).
</D>

Hence 
<D>
|\lambda| = \frac{|z|}{|1+z|} = [[ |z-0| ][ |z-(-1)| ]].
</D>
We are to show that <M>|\lambda|<1,</M> i.e., <M>z</M> is closer
to <M>0</M> than to <M>-1</M> in the complex plane.
<P/>

Now notice that 
<D>
I + L_1+L_1' = D^{-1/2} A D^{-1/2}
</D>
is a p.d. matrix. <BECAUSE><M>D^{-1/2}</M> is a nonsingular
symmetric matrix, and for any nonsingular matrix <M>P</M> the
matrix <M>P'AP</M> must be p.d.</BECAUSE>  So 
<D>
\bx^*(I + L_1+L_1')\bx = 1+z+\zbar > 0.
</D>
So <M>Re(z) > -\frac12,</M> or <M>z</M> is closer to 0 than
to <M>-1,</M> completing the proof. 
</PF>

<HEAD2>Successive over relaxation</HEAD2>
The Gauss-Seidel and Gauss-Jacobi methods are special cases of a
class of methods called <B>successive over relaxation (SOR)</B>
method. Here we choose some <M>w>0</M> and then write the
system <M>A\bx=\bb</M> as <M>wA\bx=w\bb,</M> and then
split <M>A</M> into its diagonal and strict triangular halves
<D>
A = L+D+U
</D> 
to get
<D>
w(L+D+U)\bx = w\bb.
</D>
We rearrange this to get the iterative scheme
<D>
(D+wL)\bx_{n+1} = w\bb - (wU-(w-1)D)\bx_n.
</D>
This system is easily solved by forward substitution
since <M>D+wL</M> is lower triangular. Suitable choice
for <M>w</M> (not always easy to obtain) speeds up convergence. 

<PROJ id="soap">
Find the natural shape of the soap film where
the base is the unit square, and  the boundaries are the
graphs of the functions <M>0, </M> <M>x,</M> <M>1</M>
and <M>x^3.</M> Use 50 subdivisions for each side.
[Hint: Don't worry. The final algorithm is <I>very</I> simple and intuitive!]
</PROJ>
<HEAD1><M>LU</M> decompositions</HEAD1>
We say that a nonsingular matrix has <M>LU</M> decomposition if it can be
written as
<D>
A = LU,
</D>
where <M>L</M> is a lower triangular and <M>U</M> is an upper triangular
matrix. 

<EXR>
Show that such a factorization need not be unique even if one exists.
</EXR>

If <M>L</M> has 1's on its diagonals then it is called Doolittle
decomposition and if <M>U</M> has 1's on its diagonals, it is called
Crout's factorization. If <M>L = U'</M> then we call it Cholesky
decomposition (read Cholesky as Kolesky.)

We shall work with Crout's decomposition as a representative <M>LU</M>
decomposition. The others are similar. 

<HEAD2>Application</HEAD2>
<M>LU</M> decomposition is mainly used as a substitute for
matrix inversion. If <M>A=LU</M> then you can
solve <M>A\bx=\bb</M> as follows.

First write the system as two triangular systems
<D>
L\by = \bb, \text{ where } \by = U\bx.
</D> 
Being triangular, the systems can be solved by forward or
backward substitution.
Apply forward substitution to solve for <M>\by</M> from the first
equation, and then apply backward substitution to solve
for <M>\bx</M> from the second equation.
 
Notice that, unlike Gaussian/Gauss-Jordan elimination, we do not
need to know <M>\bb</M> while computing the <M>LU</M>
decomposition. This is useful when we want to solve many systems
of the form <M>A\bx=\bb</M> where <M>A</M> is always the same,
but <M>\bb</M> will change later depending on the situation. 
Then the <M>LU</M> decomposition needs to be computed once and
for all. Only the two substitutions are to be done afresh for
each new <M>\bb.</M> 
<HEAD2>Algorithm</HEAD2>
From definition of matrix
multiplication we have
<D>
a_{ij} = \sum_{k=1}^n l_{ik} u_{kj}.
</D> 
Now, <M>l_{ik}=0</M> if <M>k>i,</M> and <M>u_{kj}=0</M> if <M>k<  j.</M>
So the above sum is effectively
<D>
a_{ij} = \sum_{k=1}^{\min\{i,j\}} l_{ik} u_{kj}.
</D> 
You can compute <M>l_{i1}</M> 's for <M>i\geq
1</M> by considering 
<D>
a_{i1} = l_{i1}u_{11} = l_{i1},
</D>
since diagonal entries of <M>U</M> are 1. Once <M>l_{11}</M> has been
computed you can compute <M>u_{1i}</M>'s for <M>i\geq
2</M> by considering
<D>
u_{1i} = a_{1i}/l_{11}.
</D>
Next you will compute <M>l_{i2}</M>'s and after that <M>u_{2i}</M>'s, and
so on. The order in which you compute the <M>l_{ij}</M>'s and
<M>u_{ij}</M>'s is shown in the diagram below.

<CIMG web="lu.png"><M>LU</M> decomposition computation order</CIMG>
 
The general formulas to compute <M>l_{ij}</M> and <M>u_{ij}</M> are
<MULTILINE>
l_{ij} &  = a_{ij} - \sum_{k=1}^{j-1}l_{ik} u_{kj}& ~~~(i\geq j)\\
u_{ij}&  = \frac{1}{l_{ii}}\left(a_{ij} - \sum_{k=1}^{i-1}l_{ik}
u_{kj}\right)& ~~~(i<  j). 
</MULTILINE>
The following diagram might help to understand the computation of
the <M>l_{ij}</M>'s:
<CIMG web="lucomp.png"/>
In order to compute the yellow part of <M>L,</M> subtract a
linear combination from the yellow part of <M>A.</M> The linear
combination is made of the corresponding parts of <M>L</M>
computed earlier, and the coefficients come from <M>U.</M>

<P/>
A similar diagram for the <M>u_{ij}</M>'s is:
<CIMG web="lucomp2.png"/>
<J>
r=:(<:@[){]
c=:(<:@[){"1 ]
]a=:?. 4 4 $ 0
]l1=:1 c a
]u1=:({. l1) %~ 1 r 2 3 4 c a
]l2=: (2 3 4 r 2 c a) - ({.u1) * }. l1
]u2=:({. l2) %~ 2 r  3 4 c a
</J>
<EXR ref="" paper="" marks="">
What should we do if for some <M>i</M> we have <M>l_{ii}=0?</M> Does this
necessarily mean that <M>LU</M> decomposition does not exist in this case?
</EXR>


<HEAD2>Efficient implementation</HEAD2>
Notice that <M>L</M> and <M>U</M> have nonzero elements at different
locations. The only place where both has nonzero elements is the diagonal,
where <M>U</M> has only 1's. So we do not need to explicitly store the
diagonal entries of <M>U.</M> This lets us store <M>L</M> and <M>U</M> in
a single <M>n\times n</M> matrix. 

Also, observe that <M>a_{ij}</M> for <M>i< j</M> is required to compute
only <M>u_{ij}.</M> Similarly <M>a_{ij}</M> for <M>i\geq j</M> is required to compute
only <M>l_{ij}.</M> Thus, once <M>u_{ij}</M> is computed (for
<M>i< j</M>) we can throw away <M>a_{ij}.</M> Similarly, for the case 
<M>i\geq j.</M> This suggests that we overwrite <M>A</M> with <M>L</M> and
<M>R.</M> Here is how the algorithm overwrites <M>A:</M>
<CIMG web="croutpack.png">Snapshot of <M>A</M> during Crout's decomposition</CIMG>

<PROJ id="lu">Implement the efficient version of Crout's decomposition
  discussed above. Your software should also be able to solve a
  system <M>A\bx = \bb</M> by forward and backward substitution.</PROJ> 

<HEAD2>Some theory</HEAD2>

<EXR ref="" paper="" marks="">
Show that if all the leading principal minors are nonzero then all the
<M>l_{ii}</M>'s will be nonzero. In fact, if <M>i</M> is the smallest
number such that the <M>i</M>-th leading principal minor is zero, then
<M>i</M> is also the smallest number with <M>l_{ii}=0.</M> [Hint: If 
<M>A = LU</M> and you partition <M>A</M> as
<D>
A = <MAT>A_{ii} &  B\\ C &  D</MAT>,
</D>
where <M>A_{ii}</M> is <M>i\times i,</M> then what is the <M>LU</M> decomposition of
<M>A_{ii}?</M> Now apply the formula for determinant of partitioned matrix
to show that 
<D>
l_{ii} = |A_{ii}|/|A_{i-1,i-1}|.
</D>
</EXR>

<EXR ref="" paper="" marks="">
Use the above exercises to characterize all square matrices having
<M>LU</M> decomposition. 
</EXR>

<HEAD1>Eigenanalysis</HEAD1>
<HEAD2>Given's rotation matrix</HEAD2>
If we rotate a vector <M><MAT>x\\y</MAT></M> by an angle <M>\theta</M> in
the clockwise direction we arrive at the vector
<D>
<MAT>\cos(\theta)x-\sin(\theta)y\\\sin(\theta)x+\cos(\theta)y</MAT>
 =
 <MAT>\cos(\theta)& -\sin(\theta)\\\sin(\theta)& \cos(\theta)</MAT>
<MAT>x\\y</MAT>.
</D>
The matrix
<D>
<MAT>\cos(\theta)& -\sin(\theta)\\\sin(\theta)& \cos(\theta)</MAT>
</D>
is called the Given's matrix for rotation by angle <M>\theta.</M> It is
 trivial to check that it is an orthogonal matrix, and the Given's matrix
 for rotation by <M>-\theta </M> is its transpose (as well as inverse.)

<EXR>
 For any 2-dimensional vector 
<D>
<MAT>x_1\\x_2</MAT>
</D> 
we can find a Given's rotation matrix <M>G(a,b)</M> such that
<D>
G(a,b)<MAT>a\\b</MAT> = <MAT>\sqrt{a^2+b^2}\\0</MAT>.
</D>
</EXR>

Then for any two vectors <M>{\mathbf u}_{m\times 1}</M> and 
<M>{\mathbf v}_{k\times 1},</M> we have
<D>
<MAT>I_m& 0& 0\\0& G(a,b)& 0\\0& 0& I_k</MAT>
<MAT>{\mathbf u}\\a\\b\\{\mathbf v}</MAT> = 
<MAT>{\mathbf u}\\\sqrt{a^2+b^2}\\0\\{\mathbf v}</MAT>.
</D>

We shall denote the matrix 
<D>
<MAT>I_m& 0& 0\\0& G(a,b)& 0\\0& 0& I_k</MAT>
</D>
by <M>R(m,k;a,b).</M>
Notice that premultiplication by <M>R(m,k;a,b)</M> changes only two rows
of a matrix. 

<HEAD2>Jacobi method</HEAD2>
Here we shall learn a method to find all eigenvalues and
eigenvectors of a given
real symmetric matrix. The main reason why real symmetric
matrices are easier to deal with 
than  general square matrices is the following theorem.

<THM>A real symmetric matrix is guaranteed to have real eigenvalues and a
full set of eigenvectors (<I> i.e.,</I> if the matrix is <M>n\times n</M>
then there are <M>n</M> independent eigenvectors. In fact, the eigen
vectors can be chosen to be mutually orthogonal.</THM>
<PF>You should know the proof from your linear algebra course.</PF>

<P/>
The idea is to keep on applying orthogonal similarity
transformations to the matrix until the matrix converges to a
diagonal matrix.

<P/>
We first locate the off-diagonal entry that is farthest away
from <M>0</M>, i.e., has the maximum absolute value. Say, it is
the <M>(i,j)</M>-th entry. Then we construct the Given's matrix 
<M>G(i,j,\theta),</M> which is the identity matrix, except that
the <M>\{i,j\}\times\{i,j\}</M> submatrix is <M>G(\theta).</M>
For example, 
<D>
G(2,4,\theta) = <MAT>
1 & 0 & 0 & 0\\
0 & \cos \theta & 0 & -\sin \theta\\
0 & 0 & 1 & 0\\
0 & \sin \theta & 0 & \cos \theta
</MAT>,
</D>
where <M>\tan(2 \theta ) = [[2a_{ij}][a_{jj}-a_{ii}]].</M>
<P/>
Then it may be easily checked
that <M>G(i,j,\theta)AG(i,j,\theta)'</M> has the <M>(i,j)</M>-th
(and <M>(j,i)</M>-th) entries equal to <M>0.</M>
<P/>
If we keep on applying this transformation repeatedly, the
resulting matrix converges to a diagonal matrix.
<R>
jacobi = function(A) {
  n = nrow(A)
  mmx = abs(A[2,1])
  mi = 2; mj = 1;
  for(i in 2:n) {
    for(j in 1:(i-1)) {
      if(mmx < abs(A[i,j])) {
        mi = i; mj = j; mmx = abs(A[i,j]);
      }
    }
  }

  cat(mmx,'\n')

  theta = atan2(2*A[mi,mj], A[mj,mj]-A[mi,mi])/2
  sn = sin(theta); cs = cos(theta)
  gv = diag(n); gv[c(mi,mj),c(mi,mj)] = c(cs,sn,-sn,cs)
  gv %*% A %*% t(gv)
}

A = matrix(sample(100,25),5,5)
A = A+ t(A)
val = numeric(100)
for(i in 1:100) A = jacobi(A)
</R>

<J>
mp=.+/ . *
A=: 0.5 -~? 5 5 $ 0
]A=.A mp |:A
]index=:,/(i.5),"0/i.5
off=:(~:/"1 # ]) index

f=: monad define
  amax=.(>./ i.~ ])(;/off){|y
  'i j'=.w=.,amax { off
  d1=. y{~ <i, i
  d2=. y{~ <j ,j
  o=. y{~ <i, j
  theta=.0.5 * _3 o. (2*o) % d2 - d1
  's c'=. (sin, cos) theta
  G=.(c,(-s),s, c) (;/,/w,"0/ w)} e. i.5
  G mp y mp |: G
)
</J>

<HEAD3>Proof</HEAD3>
We shall present the proof as a sequence of exercises.

<EXR>Find <M>\theta</M> such that the off-diagonal entries
of <M>G(\theta) A G(\theta)'</M> is zero, where <M>A
= <MAT>a_{11} & a_{12}\\a_{21}&a_{22}</MAT>.</M>
</EXR>

<EXR>Show that the sum of squares of all entries in a matrix
does not change if the matrix is pre- or post-multiplied by an
orthogonal matrix.</EXR>

<EXR>Let <M>f(A)</M> denote the sum of squares of all the
off-diagonal entries in a symmetric matrix <M>A.</M> Show that
if <M>\theta</M> is chosen so that the <M>(i,j)</M>-th entry
of <M>B=G(i,j,\theta) A G(i,j,\theta)'</M> is zero, then <M>f(B)
= f(A) - 2a_{ij}^2.</M></EXR>

<EXR>Let the <M>(i,j)</M>-th entry of <M>A</M> be the largest
absolute off-diagonal entry of <M>A.</M>  Let <M>B=G(i,j,\theta)
A G(i,j,\theta)'</M> have the <M>(i,j)</M>-th entry <M>0.</M> Show that <M>f(B)\leq(*(1-[[1N]])*) f(A)</M>, where <M>2N</M> is the number of
off-diagonal entries in <M>A</M> (i.e., if <M>A</M>
is <M>n\times n,</M> then <M>2N=n^2-n</M>).</EXR>

<EXR>Use the above exercises to argue that the Jacobi iterations
converge to a diagonal matrix.</EXR>

<HEAD3>Gerschghorin's theorem</HEAD3>
There is a final catch in the algorithm presented so far. We know
that the eigenvalues of a diagonal matrix are the diagonal
entries. But is it true that the eigenvalues of
an <I>approximately</I> diagonal matrix are <I>approximately</I>
the diagonal entries? After all, the entries of a matrix
determine the coefficients of the characteristic polynomial,
while the eigenvalues are the zeros of that polynomial. It is
well known fact that the zeroes of a polynomial
are <I>discontinuous</I> functions of the coefficients of the
polynomial. Even the quadratic root formula 
<D>
[[-b\pm\sqrt{b^2-4ac}][2a]]
</D>
has <M>a</M> in the denominator, and so depends on <M>a</M>
discontinuously. So there is reason to be worried about accuracy
of  Jacobi's algorithm. 
<P/>
Fortunately, a theorem called  Gerschghorin's theorem comes to
our rescue. Basically it says that the eigenvalues of an
approximately diagonal matrix are indeed approximately equal to
the diagonal entries. The precise statement is as follows.

<THM name="Gerschghorin's theorem">
Let <M>A_{n\times n}</M> be any (possibly complex) square matrix. Then all
its eigenvalues must lie inside the union of the open
disks <M>D_1,...,D_n,</M> where 
<D>
D_k = {*{ z\in\cc~:~ |z-a_{k k}| < \sum_{j\neq k} |a_{kj}| }*}.
</D>
</THM>
<PF>
Let <M>\lambda</M> be any eigenvalue of <M>A.</M> Pick any
corresponding eigenvector <M>\bv</M>. Let <M>v_k</M> be a
component with maximum modulus. Clearly, <M>v_k\neq 0,</M> since
otherwise <M>\bv=\bz</M> (impossible, by definition of
eigenvectors). 
<P/>
Consider the <M>k</M>-th component of the equality 
<D>
A\bv = \lambda \bv
</D>
to get 
<D>
\sum_j a_{kj} v_j = \lambda v_k,
</D>
or 
<D>
\sum_{j\neq k} a_{kj} v_j = (\lambda-a_{k k}) v_k.
</D>
So, by the triangle inequality,
<D>
|\lambda-a_{k k}|\cdot |v_k|\leq \sum_{j\neq k} |a_{kj}|\cdot |v_j|.
</D>

Dividing by <M>|v_k|,</M> we get <M>\lambda\in D_k,</M>
completing the proof.
</PF>
The <M>D_k</M>'s are centred around the diagonal entries. Also, 
for an approximately diagonal matrix, the radius of <M>D_k</M>'s
are small. For Jacobi's algorithm we also know that the
eigenvalues are real numbers. So we may replace the <M>D_k</M>'s
with open intervals.  

<HEAD3>Stronger version of Gerschghorin's theorem</HEAD3>
In the version that we have given we can only claim that all the
eigenvalues lie in the union of the disks (or, intervals, since
the eigenvalues are known to be real). Thus, if our approximately
diagonal matrix is
<D>
<MAT>
1 & 10^{-13} &  10^{-13}\\
10^{-13} &  2 & 10^{-13}\\
10^{-13} &  10^{-13} &  3
</MAT>,
</D>
then all that we can say is that the three eigenvalues will lie
in 
<D>
(1-\epsilon, 1+\epsilon)\cup(2-\epsilon, 2+\epsilon)\cup(3-\epsilon, 3+\epsilon),
</D>
where <M>\epsilon = 2\times 10^{-13}.</M> In particular, we are
allowing the possibility that all the three eigenvalues are
in <M>(1-\epsilon,1+\epsilon),</M> while there are no eigenvalues
in <M>(2-\epsilon,2+\epsilon)</M>
and <M>(3-\epsilon,3+\epsilon).</M> So the theorem does not allow
us to express the output in the desirable form:
<Q>there are three eigenvalues that are approximately <M>1</M>,
2 and <M>3.</M></Q>

<P/>
However, there is a stronger version of Gerschghorin's theorem,
that indeed allows us to make this claim. It says that if for
an <M>n\times n</M> case the union of the Gerschghorin disks
have <M>k</M> connected components 
<D>
D_{n_0}\cup \cdots D_{n_1},~~...,~~D_{n_{k-1}+1}\cup \cdots D_{n_k},
</D>
where <M>1=n_0 < \cdots < n_k = n,</M> then each connected
component must have exactly as many eigenvalues as there are
disks in it. For example, if <M>n=5,</M> and the connected
components are 
<D>
D_1\cup D_2,~~D_2\text{ and } D_3\cup D_4\cup D_5,
</D>
then the first component must contain exactly 2 eigenvalues, the
second exactly one eigenvalue, and the third exactly threee
eigenvalues. 
<P/>
In particular, if all the disks are disjoint (as should be the
case for distinct diagonal entries if the off-diagonals are very
small), then each disk contains excatly one eigenvalue.
<P/>
The proof the strong version of Gerschghorin's theorem is a
simple conseqence of weak version once we use a result from
complex analysis that ensures continuity of the zeroes of a
polynomial as functions of the coefficients. Unfortunately, that
result is rather complicated to state (let alone prove) at this
stage. 


<P/>
However, here is a simpler proof for a weaker result due to
Mrinal Saini and Aniket Jain (B-I, 2020).

<DEFN name="Boundedly almost diagonal (BAD)">
Call a matrix <M>A_{n\times n}</M> <B>boundedly almost diagonal (BAD)</B> of
order <M>M, \delta>0</M> if <M>\forall i\neq
j~~|a_{ij}|<\delta</M> and <M>\forall i~~|a_{ i i }| < M.</M>
We denote the set of all such matrices by <M>BAD(M,\delta).</M>
</DEFN>

<THM name="Saini, Jain">
<D>
\forall M > 0~~\forall \epsilon >0~~ \exists \delta>0~~ \forall A\in
BAD(M,\delta)~~\forall i\in\{1,...,n\}~~\exists
\text{eigenvalue}\in  (a_{i^* i^*}-\epsilon, a_{i^* i^*}+\epsilon).
</D>
</THM>
Notice that this result is slightly weaker than strong
Gerschghorin's theorem, because it does not
express <M>\delta</M> in terms of the off-diagonals. Also, we
need a boundedness condition on the diagonals.

<PF>
We shall prove the result by contradiction. Let, if possible, the
negation be true:
<D>
\exists M>0~~\exists \epsilon >0~~ \forall  \delta>0~~ \exists  A\in
BAD(M,\delta)~~\exists  i^*\in\{1,...,n\}~~ \not \exists 
\text{eigenvalue}\in  (a_{i^* i^*}-\epsilon, a_{i^* i^*}+\epsilon).
</D>
For any <M>\delta >0</M> we are promised
an <M>A\in BAD(M,\delta).</M> Note that this may depend
of <M>\delta.</M> Consider its characteristic
polynomial, <M>\chi_A(\lambda) = det(\lambda I-A).</M> 
<P/>
If we expand it entrywise, we shall get <M>n!</M> terms exactly
one of which will contain no off-diagonal entries. All the other
terms must have at least one off-diagonal entry. 
<P/>
So 
<D>
\chi_A(\lambda) = \prod_{i=1}^n (\lambda-a_{i i}) + \delta
\times \text{a bounded quantity}.
</D>
Now we shall put <M>\lambda = a_{i^* i^*}.</M>
<P/>
Then
<D>
\chi_A(a_{i^* i^*}) = \delta
\times \text{a bounded quantity}.
</D> 
Now, if the eigenvalues of <M>A</M>
are <M>\lambda_1,...,\lambda_n,</M> then the lhs
is <M>\prod_{i=1}^n (a_{i^*i^*}-\lambda_i).</M> Since all
the <M>\lambda_i</M>'s are outside <M>(a_{i^* i^*}-\epsilon,
a_{i^* i^*}+\epsilon),</M> hence <M>|\chi_A(a_{i^* i^*})|\geq \epsilon^n.</M>
<P/>
So we are getting <M>\exists \epsilon>0~~\forall \delta>0~~\epsilon^n\leq
\delta\times</M>a bounded quantity, which is impossible.
</PF>

To use it in the context of Jacobi's algorithm, observe that the
total sum of squares of all entries in the matrix is preserved by
the Jacobi steps. So, if <M>M>0</M> is the square root of the sum
of squares of all entries of the origial matrix, then the final
output of the algorithm is a <M>BAD(M,\delta)</M> matrix,
where <M>\delta>0</M> is the convergence criterion.

<DISQUSE id="mat2" url="https://www.isical.ac.in/~arnabc/numana/mat2.html"/>
@}
</NOTE>
