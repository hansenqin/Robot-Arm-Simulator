function [theta, rotation_axis, quat, ZYZ, ZYX] = getRotationReps(R)
    I = eye(3);
    %________________________Axis-angle_____________________
    if R == I
        disp('axis-angle representation not defined');
    elseif trace(R) == -1 
        theta = pi;
        axis1 = 1\sqrt(2*(1+R(3,3)))*[R(1,3);R(2,3);1+R(3,3)];
        axis2 = 1\sqrt(2*(1+R(2,2)))*[R(1,2);1+R(2,2);R(3,2)];
        axis3 = 1\sqrt(2*(1+R(1,1)))*[1+R(1,1);R(2,1);R(3,1)];
        
        if any(axis1 > 0)
            rotation_axis = axis1;
        elseif any(axis2 > 0)
             rotation_axis = axis2;    
        else
            rotation_axis = axis3; 
        end
    else
        theta = acos(1/2*(trace(R)-1));
        rotation_axis_matrix = theta/(2*sin(theta))*(R-R');
        rotation_axis =[-rotation_axis_matrix(2,3);rotation_axis_matrix(1,3);-rotation_axis_matrix(1,2)];
    end
   
%     %rotation_axis =[-rotation_axis_matrix(2,3) rotation_axis_matrix(1,3) -rotation_axis_matrix(1,2)];
%     
%     %________________________Quarternion_____________________
%     quat = [cos(theta/2);rotation_axis*sin(theta/2)];     
% 
%     %________________________ZYZ_____________________
%     phi_zyz = atan2(R(2,3),R(1,3));
%     theta_zyz = atan2(sqrt(R(1,3)^2+R(2,3)^2),R(3,3));
%     psi_zyz = atan2(R(3,2),-R(3,1));
%     ZYZ = [phi_zyz, theta_zyz, psi_zyz];
%     
%     %________________________ZYX_____________________
%     if -pi/2< theta< pi/2
%         phi_zyx = atan2(R(2,1),R(1,1));
%         theta_zyx = atan2(-R(3,1),sqrt(R(3,2)^2+R(3,3)^2));
%         psi_zyx = atan2(R(3,2),R(3,3));
%     elseif pi/2<= theta<= 3*pi/2
%         phi_zyx = atan2(-R(2,1),-R(1,1));
%         theta_zyx = atan2(-R(3,1),-sqrt(R(3,2)^2+R(3,3)^2));
%         psi_zyx = atan2(-R(3,2),-R(3,3));
%     end
%     ZYX = [phi_zyx, theta_zyx, psi_zyx];
    
    