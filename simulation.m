step = 25; 
FK_array = zeros(4,4,step);
theta1 = [3 0.5 0 0 0 0 0];
dtheta = (theta1 - theta)/step;  

T_space_array = zeros(4,4,8,step);
J_array = zeros(6,7,step);
FK_array = zeros(4,4,step);
            
            
for i = 1:step
    [FK_array(:,:,i), T_space_array(:,:,:,i)] = FK_space(q, w, theta + i*dtheta, M);
end

for i = 1:step
    drawRoboArm(T_space_array(:,:,:,i));
    %manip_ellip(app, J_array(:,:,i), FK_array(:,:,i));
    drawnow;
end