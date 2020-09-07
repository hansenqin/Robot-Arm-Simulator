function IK = J_transpose_kinematics(q, w, init_theta, M, config_desired)
    error = 0.01;
    FK = FK_space(q,w, init_theta, M); 
    Js = J_space(q,w, init_theta, M);
    Tbd = invT(FK)*config_desired; %body to desired config transformation
    Vb = logmat(Tbd);%error
    Jb = invAdjoint(FK)*Js;%body jacobian
    theta = init_theta';
    alpha = 0.1; %gain
    
    while norm(Vb(1:3)) > error || norm(Vb(1:3)) > error
        theta = theta + alpha*transpose(Jb)*Vb;
        FK = FK_space(q,w, theta, M);
        Js = J_space(q,w, theta, M);
        Tbd = invT(FK)*config_desired;
        Vb = logmat(Tbd);
        Jb = invAdjoint(FK)*Js;  
        disp(norm(Vb(1:3)));
    end
    IK = theta;