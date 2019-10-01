function [s, theta] = asm_AlignShapes(x1,x2)
    % x1 and x2 are 2n*1 column matrices
    % Say T(s,theta) is a tranformation function
    % such that Tx scales x by s and rotates acw by theta
    % Then this function tries to minimize |Tx1 - x2|
    % i.e. the scale and rotation required on x1 to bring it closer to x2
    x1_mag = (norm(x1)).^2;

    a = (x1'*x2)/x1_mag;
    b = sum(x1(1:2:end).*x2(2:2:end) - x1(2:2:end).*x2(1:2:end))/x1_mag;

    s = sqrt(a.^2 + b.^2);
    theta  = atan(b/a);
end