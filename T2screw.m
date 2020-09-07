function S = T2screw(T)
   w_ss = T(1:3,1:3);
   v = T(1:3,4);
   w = [-w_ss(2,3);w_ss(1,3);-w_ss(1,2)];
   S = [w;v];
   
   