function adjt = invAdjoint(T)
    adjt = zeros(6);
    R = T(1:3, 1:3);
    p = T(1:3, 4);
    adjt(1:3, 1:3) = R';
    adjt(4:6, 1:3) = -R'*skewSym(p);
    adjt(4:6, 4:6) = R';