function [T] = getTsyms(angV, linV, theta)
    T = sym(zeros(4,4));
    angV_so3 =[0 -angV(3) angV(2) ; angV(3) 0 -angV(1); -angV(2) angV(1) 0 ];
    rotation = eye(3)+angV_so3*sin(theta)+angV_so3^2*(1-cos(theta));
    translation = (eye(3)*theta+(1-cos(theta))*angV_so3+(theta-sin(theta))...
                  *angV_so3^2)*transpose(linV);
    %translation = linV;
    T(1:3,1:3) = rotation;
    T(1:3,4) = translation;
    T(4,1:4) = [0 0 0 1];