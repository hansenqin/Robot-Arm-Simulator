J = J_space(q,w,theta,M);

%plot ellipsoid
ellipsoid_plot(J);
eigen_w = eig(J(1:3,:)*J(1:3,:)');
eigen_v = eig(J(4:6,:)*J(4:6,:)');

%angular ellipsoid parameters
condition_w = J_condition(eigen_w);
volume_w = J_ellipsoid_volume(J(1:3,:)*J(1:3,:)');
isotropy_w = J_condition(eigen_w);

%linear ellipsoid parameters
condition_v = J_condition(eigen_v);
volume_v = J_ellipsoid_volume(J(4:6,:)*J(4:6,:)');
isotropy_v = J_condition(eigen_v);
