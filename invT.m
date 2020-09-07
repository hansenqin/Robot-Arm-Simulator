function Tinv = invT(T)
   Tinv = eye(4);
   R = T(1:3,1:3);
   p = T(1:3, 4);
   Tinv(1:3, 1:3) = R';
   Tinv(1:3, 4) = -R'*p;
   