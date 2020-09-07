function IK = redundancy_resolution2(q, w, init_theta, M, config_desired)
    error = 0.005;
    FK = FK_space(q,w, init_theta, M);
    Js = J_space(q,w, init_theta, M);
    n = size(q);
    delta = 0.001;
    Tbd = invT(FK)*config_desired;
    Vb = logmat(Tbd);
    Jb = invAdjoint(FK)*Js;
    theta = init_theta';
    gradient = zeros(1,n(1));
    volume = round(sqrt(det(Jb*Jb')),4);
    volume = real(volume);
    
    while norm(Vb(1:3)) > error || norm(Vb(4:6)) > error
            for i = 1: n(1)
                theta_temp = theta;
                theta_temp(i) = theta_temp(i)+delta;
                Js = J_space(q,w, theta_temp, M);
                FK = FK_space(q,w, theta_temp, M);
                Jb = invAdjoint(FK)*Js;
                d_volume = sqrt(det(Jb*Jb')) - volume;
                gradient_i =  real(d_volume)/delta;
                gradient(i) = gradient_i;
            end
         
        if volume < 0.01
          theta = theta + 10*gradient';%300*(0.01-volume)*gradient';
        end
 
        
        FK = FK_space(q,w, theta, M);
        Js = J_space(q,w, theta, M);
        Tbd = invT(FK)*config_desired;
        Vb = logmat(Tbd);
        Jb = invAdjoint(FK)*Js;  
        theta = theta + pinv(Jb)*Vb;
        volume = round(sqrt(det(Jb*Jb')),4);
        volume = real(volume);
        
         
        disp(norm(Vb(1:3)));
        %end
        %counter = counter+1;

    end
    IK = theta;
    %disp(sqrt(det(Jb*Jb')));