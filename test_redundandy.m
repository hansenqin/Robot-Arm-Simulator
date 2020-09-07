%this script allows you to compare the result between redundancy_resolution
%and inv_kinematic

%define config desired
config_desired = [1         0         0    0.1000;
                  0        -1         0    0.3000;
                  0         0        -1    0.5000;
                  0         0         0    1.0000];
              
%define guess theta            
init_theta = [1 1 1 1 0 0 0];

theta_inv = J_inverse_kinematics(q, w, init_theta, M, config_desired);
theta_redund = redundancy_resolution(q, w, init_theta, M, config_desired);

J1 = J_space(q,w,theta_inv,M);
J2 = J_space(q,w,theta_redund,M);

w_inv = sqrt(det(J1*J1'));
w_redund = sqrt(det(J2*J2'));

disp(w_inv);
disp(w_redund);