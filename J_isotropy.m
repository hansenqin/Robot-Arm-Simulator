function [isotropy] = J_isotropy(eigen)
    
    eigenmax = max(eigen(:));
    eigenmin = min(eigen(:));
    isotropy = sqrt(real(eigenmax))/sqrt(real(eigenmin));