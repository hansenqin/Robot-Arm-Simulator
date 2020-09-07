function S = logmat(T)
    w = zeros(3,1);
    v = zeros(3,1);
    R = T(1:3, 1:3);
    p = T(1:3, 4);
    
    if R == eye(3)
        w = zeros(3,1);
        v = p/norm(p);
        S = [w;v];
    else
        [theta, axis] = getRotationReps(R);
        skewaxis = skewSym(axis'/norm(axis'));
        Ginv = eye(3)-theta/2*skewaxis+theta*(1/theta-1/2*cot(theta/2))*skewaxis*skewaxis;
        v = Ginv*p;
        S = [axis;v];
    end
    