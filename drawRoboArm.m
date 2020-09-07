function drawRoboArm(T_space)
    
    n = size(T_space);
    n = n(3);
    
    %plot origin
    plot3([0 1*0.05],[0 0],[0 0], 'r',...
          [0 0],[0 1*0.05],[0 0], 'b',...
          [0 0],[0 0],[0 1*0.05], 'g')
      
    %plot joints
    hold on
    for i = 1: n
        plot3([T_space(1,4,i) T_space(1,4,i)+ T_space(1,1,i)*0.05],[T_space(2,4,i) T_space(2,4,i)+ T_space(2,1,i)*0.05],[T_space(3,4,i) T_space(3,4,i)+ T_space(3,1,i)*0.05],'r',...
              [T_space(1,4,i) T_space(1,4,i)+ T_space(1,2,i)*0.05],[T_space(2,4,i) T_space(2,4,i)+ T_space(2,2,i)*0.05],[T_space(3,4,i) T_space(3,4,i)+ T_space(3,2,i)*0.05],'b',...
              [T_space(1,4,i) T_space(1,4,i)+ T_space(1,3,i)*0.05],[T_space(2,4,i) T_space(2,4,i)+ T_space(2,3,i)*0.05],[T_space(3,4,i) T_space(3,4,i)+ T_space(3,3,i)*0.05],'g')
        axis([-1 1 -1 1 -1 1.5]);
        hold on
    end
    
    %plot arms
    p = plot3([0, T_space(1,4,1)],[0, T_space(2,4,1)],[0, T_space(3,4,1)],'k');
    p.LineWidth = 3;
    for i = 1: n-1
    p = plot3([T_space(1,4,i), T_space(1,4,i+1)],[T_space(2,4,i) T_space(2,4,i+1)],[T_space(3,4,i) T_space(3,4,i+1)],'k');
    p.LineWidth = 3;
    end
   
    
    
    
    hold off
    