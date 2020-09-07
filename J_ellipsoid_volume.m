function [volume] = J_ellipsoid_volume(A)
    volume = sqrt(det(A));