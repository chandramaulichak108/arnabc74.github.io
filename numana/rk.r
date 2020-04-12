pendulum = function(initTheta,n,h) {
  theta = rep(0,n);
  omega = rep(0,n);
  theta[1] = initTheta;
  omega[1] = 0;

  #theta' = omega
  #omega' = -C*sin(theta)

  #f1(t,theta, omega) = omega
  #f2(t,theta, omega) = -C*sin(theta)
  
  h2 = h/2;
  h6 = h/6;
  C = 9.8/1;

  for(i in 1:(n-1)) {
    k1 = omega[i];
    j1 = -C*theta[i];
    k2 = omega[i]+h2*j1;
    j2 = -C*(theta[i]+h2*k1);
    k3 = omega[i]+h2*j2;
    j3 = -C*(theta[i]+h2*k2);
    k4 = omega[i]+h2*j3;  
    j4 = -C*(theta[i]+h2*k3);

    theta[i+1] = theta[i] + h6*(k1+2*(k2+k3)+k4);  
    omega[i+1] = omega[i] + h6*(j1+2*(j2+j3)+j4);
  }
  tm = seq(0,length=n,by=h);
  
  plot(tm,theta,type="l");
  lines(tm,initTheta*cos(sqrt(C)*tm),col="red")
  dev.new();
  plot(theta,omega,type="l")
}
