<NOTE>
@{
<M>\newcommand{\v}{\vec}</M>
<HEAD1>Multivariate differentiation</HEAD1>
<HEAD2>The definition</HEAD2>
Suppose that you have a function <M>f:\rr^n\to\rr.</M> Then we
say that it is differentiable at some <M>\v a\in\rr^n</M> if 
locally at <M>\v a</M> the function may be "well approximated" by a
linear function passing through <M>(\v a, f(\v a)).</M> Such a
function has the form 
<D>
g(\v x) = f(\v a) + D (\v x -\v a),
</D>
where <M>D</M> is a <M>1\times n</M> matrix (i.e., a row vector).
This
linear function is what we call the tangent if <M>n=1</M> and the
tangent plane if <M>n=2.</M> When this happens, <M>D</M> is
called the derivative of <M>f</M> at <M>\v a.</M> It is denoted
by <M>\nabla f</M> and called "grad <M>f</M>". 
<P/>
If you are curious about what is meant by "well approximated",
then here it is:
<D>
[[f(\v x)-g(\v x)][\|\v x - \v a\|]]\to 0\mbox{ as } \v x\to\v a.
</D>
The <M>\|\cdots\|</M> is the length in <M>\rr^n.</M>
<P/>
Check that
for <M>n=1</M> this is same as our familiar concept of differentiation.

<HEAD2>Computing</HEAD2>
If <M>f:\rr^n\to\rr</M> is differentiable at some <M>\v
a\in\rr^n</M>, then we may compute the derivative easily as
follows.
<D>
\nabla f(\v a)= (f_1(\v a),...,f_n(\v a)),
</D>
where <M>f_i</M> is the <M>i</M>-th partial derivative
of <M>f.</M>

<EXM>
If <M>f(x_1,x_2,x_3) = 4x_1x_2 - x_3^2,</M> then direct
computation shows
<D>
\nabla f = (4x_2, 4x_1, -2x_3).
</D>

</EXM>

<HEAD2>Differentiaing a quadratic form</HEAD2>
We know that derivative of <M>mx^2</M> is <M>2mx.</M> There is an
elegant generalisation of this for higher dimension. If 
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
derivatve also vanishes if <M>f</M> attains a local max/min. We
also have an analogous second order derivative check, but we
shall not go into that here. 
@}
</NOTE>
