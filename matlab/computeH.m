function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points

A = [];
for i = 1:size(x1, 1)
    A(2*i - 1, :) = [-x1(i, 1), -x1(i, 2), -1, 0, 0, 0, x1(i, 1)*x2(i, 1), x1(i, 2)*x2(i, 1), x2(i, 1)];
    A(2*i, :) = [0, 0, 0, -x1(i, 1), -x1(i, 2), -1, x1(i, 1)*x2(i, 2), x1(i, 2)*x2(i, 2), x2(i, 2)];
end

if(size(x1, 1) <= 4)
    [U, S, V] = svd(A);
else
    [U, S, V] = svd(A, 'econ');
end

H2to1 = (reshape(V(:, 9), 3, 3))';
% H2to1 = H2to1./H2to1(3, 3);

end

