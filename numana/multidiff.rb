 <NOTE>
@{<UPDT>TUE APR 14 IST 2020</UPDT>
<M>\newcommand{\v}{\vec}</M>
<HEAD1>Multivariate differentiation</HEAD1>
<HEAD2>The definition</HEAD2>
Suppose that you have a function <M>f:\rr^n\to\rr^m.</M> Then we
say that it is differentiable at some <M>\v a\in\rr^n</M> if 
locally at <M>\v a</M> the function may be "well approximated" by an
(affine) linear function passing through <M>(\v a, f(\v a)).</M> Such a
function has the form 
<D>
g(\v x) = f(\v a) + D (\v x -\v a),
</D>
where <M>D</M> is a <M>m\times n</M> matrix.
This
linear function is what we call the tangent if <M>m=n=1</M> and the
tangent plane if <M>m=1,~n=2.</M>
<P/>
This <M>D</M> is
called the derivative of <M>f</M> at <M>\v a.</M> More commonly,
it is also called the <B>Jacobian</B> of <M>f</M> at <M>\v a.</M>
If <M>m=1</M> and <M>n>1</M> then it is often denoted
by <M>\nabla f</M> and called "grad <M>f</M>". 
<P/>
If you are curious about what is meant by "well approximated",
then here it is:
<D>
[[f(\v x)-g(\v x)][\|\v x - \v a\|]]\to \v 0\mbox{ as } \v x\to\v a.
</D>
The <M>\|\cdots\|</M> is the length in <M>\rr^n.</M>
<P/>
Check that
for <M>n=1</M> this is same as our familiar concept of differentiation.

<HEAD2>Computing the derivative matrix</HEAD2>
The derivative of <M>f:\rr^n\to\rr^n</M> at any given <M>\v
a\in\rr^n</M> is an <M>m\times n</M> matrix <M>D.</M>
Its <M>(i,j)</M>-th entry is given by 
<D>
[[\partial f_i][\partial x_j]] (\v a).
</D>

<EXM>
If <M>f(x_1,x_2,x_3) = 4x_1x_2 - x_3^2,</M> then direct
computation shows
<D>
\nabla f = (4x_2, 4x_1, -2x_3).
</D>

</EXM>

<HEAD2>Two special cases</HEAD2>
<HEAD3>Linear transformation</HEAD3>
If <M>f:\rr^n\to\rr^m</M> is of the form <M>f(\v x) = A\v x</M>
for some constant matrix <M>A,</M> then the derivative will
be <M>A</M> itself.

<HEAD3>Differentiaing a quadratic form</HEAD3>
If
<M>f:\rr^n\to\rr</M> is of the form 
<D>
f(\v x) = \v x' M \v x
</D>
for some <I>symmetric</I> matrix <M>M,</M> then 
<D>
\nabla f = 2\v x' M.
</D>
This is the formula we have used in the soap film example. 

<HEAD2>Application</HEAD2>

Just like the familiar 1-dim derivative, the higher dimensional
derivatve also vanishes if <M>f</M> attains a local max/min (for <M>m=1</M>). We
also have an analogous second order derivative check, but we
shall not go into that here. 

<HEAD2>Chain rule</HEAD2>

Let <M>f:\rr^m\to\rr^n</M> and <M>g:\rr^n\to\rr^p</M> be both
differentiable with derivatives <M>D_f</M> and <M>D_g,</M>
respectively. Let <M>h:\rr^n\to\rr^p</M> is defined as <M>h =
g\circ f,</M> then <M>h</M> must be differentiable with
derivative at any <M>\va\in\rr^n</M> given by
<D>
D_h = D_g( f(\v a)) D_f(\v a). 
</D>

<HEAD2>1st order Taylor expansion</HEAD2>
For a function <M>f:\rr^m\to\rr^n</M> that is differentiable at
some <M>\v a\in\rr^n, </M> we know that <M>f</M> is well
approximated by the affine linear function 
<D>
g(\v x) = f(\v a) + D (\v x -\v a),
</D>
where <M>D</M> is the derivative of <M>f</M> at <M>\v a.</M> This
is called the 1st order Taylor approximation of <M>f.</M> Under
suitable assumptions (related to existence and continuity of the second
partial derivatives of <M>f</M>), the error involved in this
approximation is of quadratic order.

<HEAD1>Trouble with tangent plane</HEAD1>
If <M>f:\rr^2\to\rr</M> is differentiable at
some <M>(x_0,y_0)</M> then the tangent plane is given by 
<D>
z = f(x_0,y_0) + f_1(x_0,y_0)(x-x_0) + f_2(x_0,y_0)(y-y_0),
</D>
where <M>f_i</M> is the partial derivative of <M>f</M>
w.r.t. the <M>i</M>-th argument. 
<P/>
In particular, the partial derivatives must exist if <M>f</M> is differentiable.
<P/>
However, the converse is not true. It is possible that the
partial derivatives exist at some <M>(x_0,y_0)</M> (and so the
above plane is well defined), but still <M>f</M> is not
differentiable there. Thus, even if the plane exists, it need not
be the tangent plane. One such example is given by the function 
<D>
f(x,y) = <CASES>-y<IF>x\neq 0</IF>0<IF>x=0</IF></CASES>.
</D>
The graph is shown below:
<CIMG web="badtan.png">Not differentiable at <M>(0,0)</M></CIMG>
Here <M>f_1(0,0) = f_2(0,0) = 0,</M> and so the plane is just
the <M>xy</M>-plane, but clearly it is not tangent to the
surface.  
<DISQUSE id="multidiff" url="https://www.isical.ac.in/~arnabc/numana/multidiff.html"/>@}
</NOTE>
