%define config desired
config_desired = [1         0         0    0.1000;
                  0        -1         0    0.3000;
                  0         0        -1    0.5000;
                  0         0         0    1.0000];
              
%define guess theta            
init_theta = [1 1 1 1 0 0 0];
              
J_inverse_kinematics(q, w, init_theta, M, config_desired);
J_transpose_kinematics(q, w, init_theta, M, config_desired);
