function [condition] = J_condition(eigen)
    eigenmax = max(eigen(:));
    eigenmin = min(eigen(:));
    condition = real(eigenmax)/real(eigenmin);