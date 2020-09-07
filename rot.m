function [R] = rot(axis, theta)
    I = eye(3);
    wss=[0 -axis(3) axis(2); 
          axis(3) 0 -axis(1);
          -axis(2) axis(1) 0];
    R = I+wss*sin(theta)+wss^2*(1-cos(theta));