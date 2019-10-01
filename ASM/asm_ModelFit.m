function [b,t,s,theta] = asm_ModelFit(x_mean,Y,P)
    % Initialize b = 0
    b = zeros(size(P,2),1);
    b1 = b;
    n = length(Y)/2;
    Y_center = [sum(Y(1:2:end))/n ; sum(Y(2:2:end))/n];
   % for i=1:10
    while true
        b1 = b;

        % Finding new model x
        x = x_mean + P*b1;
        
        % Say transformation T(t,s,theta)
        % Finding t,s,theta to mininize error
        % i.e. argmin(|Tx - Y|) for (t,s,theta)

        % Find translation t
        x_center = [sum(x(1:2:end))/n ; sum(x(2:2:end))/n];
        t = Y_center - x_center;
        
        % Find scale s and acw rotation angle theta
        [s , theta] = asm_AlignShapes(x-repmat(x_center,[n 1]),Y-repmat(Y_center,[n 1]));
        
        % Do inverse Transform on Y  y=inv_T.Y  to project Y to model-frame(x)
        y = Y - repmat(t,[n 1]);
        y = s.*[cos(theta) -sin(theta) ; sin(theta) cos(theta)]*[y(1:2:end)' ; y(2:2:end)'];
        y = y(:); 
        
        % Project y to tangent plane to x_mean by scaling
        y1 = y./(dot(y,x_mean));
        
        % Update model parameters b
        b = P'*(y1-x_mean);
        if(nnz(b) == 0 | sum(abs(b-b1)) < 0.000009)
            break;
        end
    end
end