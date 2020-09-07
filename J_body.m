function J = J_body(q, w, theta,M)
    n = size(q);
    v = zeros(n(1),3);
    s = zeros(n(1),6);
    T = zeros(4,4,n(1));
    q_nonhome = zeros(n(1),3);
    w_nonhome = zeros(n(1),3);
    FK = eye(4);
    for i = 1: n(1)
        v(i,:) = cross(-w(i,:),q(i,:));
        T(:,:,i) = getT(w(i,:),v(i,:),theta(i));
        FK = FK*T(:,:,i);
        T_space = eye(4);
        for j = 1:i
            T_space = T_space*T(:,:,j);
        end
        q_temp = T_space*M(:,:,i)*[0;0;0;1];
        q_nonhome(i, :) = q_temp(1:3);
        w_temp = T_space(1:3,1:3)*w(i,:)';
        w_nonhome(i, :) = w_temp;
        v(i,:) = cross(-w_nonhome(i, :), q_nonhome(i,:));
        s(i,:) = [w_nonhome(i, :), v(i,:)];
    end
    FK = FK*M(:,:,n(1)+1);
    Ad_bs = invAdjoint(FK);
    J = Ad_bs*s';