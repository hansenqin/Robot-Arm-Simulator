function [FK, T_space] = FK_space(q, w, theta, M)
    n = size(q);
    v = zeros(n(1),3);
    s = zeros(n(1),6);
    T = zeros(4,4,n(1));
    T_space = zeros(4,4,n(1)+1);
    FK = eye(4);
    for i = 1: n(1)
        v(i,:) = cross(-w(i,:),q(i,:));
        s(i,:) = [w(i,:), v(i,:)];
        T(:,:,i) = getT(w(i,:),v(i,:),theta(i));
        FK = FK*T(:,:,i);
        T_space(:,:,i) = eye(4);
        for j = 1:i
            T_space(:,:,i) = T_space(:,:,i)*T(:,:,j);
        end
        T_space(:,:,i) = T_space(:,:,i)*M(:,:,i);
    end
    
    FK = FK*M(:,:,n(1)+1);
    T_space(:,:,n(1)+1) = FK;
   
    %drawRoboArm(T_space);
    
  