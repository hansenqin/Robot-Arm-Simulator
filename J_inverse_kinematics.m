function IK = J_inverse_kinematics(q, w, init_theta, M, config_desired)
    error = 0.0001;
    FK = FK_space(q,w, init_theta, M);
    Js = J_space(q,w, init_theta, M);
    Tbd = invT(FK)*config_desired;
    Vb = logmat(Tbd);
%     Vb_temp = logm(Tbd);
%     aVb = T2screw(Vb_temp);
    Jb = invAdjoint(FK)*Js;
    theta = init_theta';
    t = 1;
    while norm(Vb(1:3)) > error || norm(Vb(4:6)) > error
        theta = theta + pinv(Jb)*Vb;
        FK = FK_space(q,w, theta, M);
        Js = J_space(q,w, theta, M);
        Tbd = invT(FK)*config_desired;
        Vb = logmat(Tbd);
%         Vb_temp = logm(Tbd);
%         Vb = T2screw(Vb_temp);
        disp([norm(Vb(1:3)), norm(Vb(4:6))]);
        disp(Vb(1:3));
        Jb = invAdjoint(FK)*Js;  
    
        
  
    end
    IK = theta;
    %disp(sqrt(det(Jb*Jb')))
    