function [FK] = FK_body(q, w, theta, M)
    n = size(q);
    v = zeros(n(1),3);
    s = zeros(n(1),6);
    b = zeros(n(1),6);
    T = zeros(4,4,n(1));
    T_body = zeros(4,4,n(1)+1);
    FK = M(:,:,n(1)+1);
    
    Ad_m = invAdjoint(M(:,:,n+1));
    for i = 1: n(1)
        v(i,:) = cross(-w(i,:),q(i,:));
        s(i,:) = [w(i,:), v(i,:)];
        
        b(i,:) = Ad_m*s(i,:)';
        w_b = b(i,1:3);
        v_b = b(i,4:6);
        
        T(:,:,i) = getT(w_b,v_b,theta(i));
        FK = FK*T(:,:,i);
        
        T_body(:,:,i) = eye(4);
        for j = 1:i
            T_body(:,:,i) = T_body(:,:,i)*T(:,:,j);
        end
        T_body(:,:,i) = M(:,:,i)*T_body(:,:,i);
    end
    
    T_body(:,:,n(1)+1) = FK;
    drawRoboArm(T_body);