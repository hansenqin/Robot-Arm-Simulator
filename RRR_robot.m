m1 = 0.25+0.7;     %kg
m2 = 0.25+0.7+1.5; %kg
L1 = 0.254;        %m
L2 = 0.254;        %m
theta1 = 0;
theta2 = 0;
theta1dot = 0.01;
theta2dot = 0;
theta1dot2 = 0.01;
theta2dot2 = 0;
thetadot2 = [theta1dot2;theta2dot2];

n = 100;
theta1 = linspace(0,2*pi,100);
torque = zeros(2,n);

for i = 1:n
    M = [m1*L1^2+m2*(L1^2+2*L1*L2*cos(theta2)+L2^2) m2*(L1*L2*cos(theta2)+L2^2);
        m2*(L1*L2*cos(theta2)+L2^2) m2*L2^2];

    c =[-m2*L1*L2*sin(theta2)*(2*theta1dot*theta2dot+theta2dot^2);
        m2*L1*L2*theta1dot^2*sin(theta2)];

    gmat = [(m1+m2)*L1*9.81*cos(theta1(i))+m2*9.81*L2*cos(theta1(i)+theta2);
           m2*9.81*L2*cos(theta1(i)+theta2)];
       
    torque(:,i) = M*thetadot2+c+gmat;
end
  
  
  plot(theta1, torque)
  xlabel("theta1(radians)")
  ylabel("torque")
   
   

