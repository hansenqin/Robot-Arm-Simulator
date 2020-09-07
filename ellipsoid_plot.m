function ellipsoid_plot(J)
    Jw = J(1:3,:);
    Jv = J(4:6,:);
    Aw = Jw*Jw';
    Av = Jv*Jv';
    [eigvectw, eigw] = eig(Aw);
    [eigvectv, eigv] = eig(Av);
   
    %check whether the matrix is in SO(3)
    if sign(det(eigvectw)) == -1
       eigvectw(:,1) = -eigvectw(:,1);
    end
    
    if sign(det(eigvectv)) == -1
       eigvectv(:,1) = -eigvectv(:,1);
    end
    
    %obtain theta and axis for rotation of the ellispoid later
    [theta1, axis1] = getRotationReps(eigvectw);
    [theta2, axis2] = getRotationReps(eigvectv);
   
    %plot angular velocity ellipsoid axes
     plot3([-eigvectw(1,1)*3  eigvectw(1,1)*3], [-eigvectw(2,1)*3 eigvectw(2,1)*3], [-eigvectw(3,1)*3 eigvectw(3,1)*3], 'b',...
           [-eigvectw(1,2)*3  eigvectw(1,2)*3], [-eigvectw(2,2)*3 eigvectw(2,2)*3], [-eigvectw(3,2)*3 eigvectw(3,2)*3], 'b',...
           [-eigvectw(1,3)*3  eigvectw(1,3)*3], [-eigvectw(2,3)*3 eigvectw(2,3)*3], [-eigvectw(3,3)*3 eigvectw(3,3)*3], 'b')
     axis([-3 3 -3 3 -3 3]);
     hold on
     
    %plot linear velocity ellipsoid axes
     plot3([-eigvectv(1,1)*3  eigvectv(1,1)*3], [-eigvectv(2,1)*3 eigvectv(2,1)*3], [-eigvectv(3,1)*3 eigvectv(3,1)*3], 'r',...
           [-eigvectv(1,2)*3  eigvectv(1,2)*3], [-eigvectv(2,2)*3 eigvectv(2,2)*3], [-eigvectv(3,2)*3 eigvectv(3,2)*3], 'r',...
           [-eigvectv(1,3)*3  eigvectv(1,3)*3], [-eigvectv(2,3)*3 eigvectv(2,3)*3], [-eigvectv(3,3)*3 eigvectv(3,3)*3], 'r')
       
     [xw, yw, zw]= ellipsoid(0,0,0,real(sqrt(eigw(1,1))),real(sqrt(eigw(2,2))),real(sqrt(eigw(3,3))),30);
     [xv, yv, zv]= ellipsoid(0,0,0,real(sqrt(eigv(1,1))),real(sqrt(eigv(2,2))),real(sqrt(eigv(3,3))),30);
    
    S1 = surf(xw, yw, zw,'facealpha', 0.1, 'facecolor', 'blue','Edgealpha','0.5');
    S2 = surf(xv, yv, zv,'facealpha', 0.1, 'facecolor', 'red','Edgealpha','0.5');
    rotate(S1,axis1,rad2deg(theta1));
    rotate(S2,axis2,rad2deg(theta2));
