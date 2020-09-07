function [J] = J_space(q, w, theta, M)

%---------------------------Initialization--------------------------------

    n = size(q); %number of joints,  7x3 matrix
    v = zeros(n(1),3); %linear velocity, 7x3 matrix
    s = zeros(n(1),6); %screw axis, 7x6 matrix
    T = zeros(4,4,n(1));% transformation matrix represented by each joint,         
                        % like T12, T23, T34, etc.
    q_nonhome = zeros(n(1),3); %position of each joint at nonhome config
    w_nonhome = zeros(n(1),3); %rotation at nonhome config
    
    % Note: nonhome config just means the position is not constant and changes
    % with theta. It equals the home config when all the thetas are 0. 

    
    
%-----------------------------Calculate Jacobian---------------------------

    for i = 1: n(1) %repeated 7 times, one for each joint
        v(i,:) = cross(-w(i,:),q(i,:)); %Calculate linear velocity
        T(:,:,i) = getT(w(i,:),v(i,:),theta(i)); %Calculate transformation matrix using screw axis
        T_compound = eye(4);  %Tcompound is the compound transformation for each joint, so
                              %for example T14 = T12*T23*T34  
                              
        for j = 1:i
            T_compound = T_compound*T(:,:,j); %calculate compound transformation
        end
        q_temp = T_compound*M(:,:,i)*[0;0;0;1]; %temporary variable, calculates q-nonhome by
                                                %multiplying Tcompound*home configuration of each joint *[0, 0, 0, 1]
        q_nonhome(i, :) = q_temp(1:3);  %convert from homogenous coord to xyz coord       
        w_nonhome(i, :) = T_compound(1:3,1:3)*w(i,:)';  %calculate screw axis by extracting R from T first then 
                                                        %multiply it by the home-config screw axis
                               
        v(i,:) = cross(-w_nonhome(i, :), q_nonhome(i,:)); %get v
        s(i,:) = [w_nonhome(i, :), v(i,:)];               %get non-home screw axis
    end
     
    J = s'; %Jacobian's made out of screw axes at each joint
