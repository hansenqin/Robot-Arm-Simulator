function IK = redundancy_resolution(q, w, init_theta, M, config_desired)
    error = 0.001;
    FK = FK_space(q,w, init_theta, M);
    Js = J_space(q,w, init_theta, M);
    n = size(q);
    delta = 0.1;
    Tbd = invT(FK)*config_desired;
    Vb = logmat(Tbd);
    Jb = invAdjoint(FK)*Js;
    theta = init_theta';
    first_time = true; 
    theta_final = zeros(1,n(1));
    counter = 1;
    
    while norm(Vb(1:3)) > error || norm(Vb(4:6)) > error
  
        theta = theta + pinv(Jb)*Vb;
        FK = FK_space(q,w, theta, M);
        Js = J_space(q,w, theta, M);
        Tbd = invT(FK)*config_desired;
        Vb = logmat(Tbd);
        Jb = invAdjoint(FK)*Js;       
        volume = sqrt(det(Js*Js'));
        
        if counter < 30
            for i = 1: n(1)
                theta_temp = theta;
                theta_temp(i) = theta_temp(i)+delta;
                J_1 = J_space(q,w, theta_temp, M);
                d_volume = sqrt(det(J_1*J_1')) - volume;
                gradient =  d_volume/delta;
                if first_time == true

                    if sign(gradient) == 1
                        theta_final(i) = +delta;
                    else
                        theta_final(i) = -delta;
                    end

                else
                    if sign(gradient) ~= sign(theta_final(i))
                        theta_final(i) = 0;
                    end
                end 
            end
            first_time = false;
            theta = theta+theta_final';
        end
        counter = counter+1;
   
    end
    IK = theta;
    disp(sqrt(det(Jb*Jb')))
    