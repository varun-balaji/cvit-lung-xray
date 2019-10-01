function mask = asmCustom(shapesMat,im,iter,r)%initialModel
    % shapesMat is a m x 2n dimensional matrix
    % m is number of shapes
    % n is number of landmark points. x,y coordinates are saved as [x1,y1,x2,y2...] to get 2n dimensions

    h = size(im,1);
    w = size(im,2);

    m = size(shapesMat,1);
    n = size(shapesMat,2)/2;
    
    % Performing PCA of shapesMat
    dx = shapesMat - mean(shapesMat);       % Deviation matrix
    covMat = (dx'*dx)./(m-1);               % Covariance matrix : Finding covariance amongst the 2n dimensions
    [V D] = eig(covMat);                    % Finding eigenvectors of covMat
    
    [~,idx] = sort(diag(D),'descend');      % Sorting eigenvalues in descending order to get principal eigenvectors
    D = D(idx,idx);
    V = V(:,idx);  
    D = diag(D);
    D_total = sum(D);
    k = 0;
    D_sum = 0;
    while D_sum <= 0.98
        k = k+1;
        D_sum = D_sum + D(k)/D_total;
    end
    P = V(:,1:k);
    D = D(1:k);
    bLim = [-3.*sqrt(D), 3.*sqrt(D)];

    %shapesMat = shapesMat + repmat([floor(w/4) floor(h/2)],[m n]);
    x_mean = mean(shapesMat)';

    t = [floor(w/4);floor(h/2)];                      % Initial shape estimate
    b = zeros(k,1);                                 
    s = floor(h/4)+20;
    theta = 0;
    plt_X = 1;
    plt_Y = 1;
    imshow(im);
    hold on
    for i=1:iter
        x = x_mean + P*b;
        x_center = mean([x(1:2:end)';x(2:2:end)'],2);
        xi = x(1:2:end) - repmat(x_center(1),[n 1]);
        yi = x(2:2:end) - repmat(x_center(2),[n 1]);
        X = s.*[cos(theta) -sin(theta) ; sin(theta) cos(theta)]*[xi';yi'];
        X = X(:);
        X = X + repmat(t,[n 1]);
        %delete(plt_X);
        plt_X = plot([X(1:2:end);X(1)], [X(2:2:end);X(2)],'g-');
        N = asm_ShapeNormals(X);
        xi = X(1:2:end);
        yi = X(2:2:end);                                                    
        normal_x = vectorLinspace(xi - r.*N(:,1),xi + r.*N(:,1),2.*r+1);            % Getting normals of landmarks
        normal_y = vectorLinspace(yi - r.*N(:,2),yi + r.*N(:,2),2.*r+1);            % Sampling points on normals
        normalMag = zeros(n,2.*r+1);
        for a=1:n
            for b=1:2.*r+1
                normalMag(a,b) = im(floor(normal_x(a,b)),floor(normal_y(a,b)));     % Finding magnitude of image at
            end                                                                     % points sampled on normals
        end
        [~,id] = max(normalMag,[],2);                                               % Finding max edge
        n_x = zeros(1,n);
        n_y = zeros(1,n);
        for a=1:n
            n_x(a) = normal_x(a,id(a));
            n_y(a) = normal_y(a,id(a));
        end
        Y = [n_x;n_y];
        %delete(plt_Y);
        plt_Y = scatter(Y(1,:),Y(2,:),'r');
        Y = Y(:);                                                                   % Y is the next model estimate
        [b,t,s,theta] = asm_ModelFit(x_mean,Y,P);
        b(b>bLim(:,2)) = bLim(b>bLim(:,2));
        b(b<bLim(:,1)) = bLim(b<bLim(:,1));
    end
    x = x_mean + P*b;
    x_center = mean([x(1:2:end)';x(2:2:end)'],2);
    xi = x(1:2:end) - repmat(x_center(1),[n 1]);
    yi = x(2:2:end) - repmat(x_center(2),[n 1]);
    X = s.*[cos(theta) -sin(theta) ; sin(theta) cos(theta)]*[xi';yi'];
    X = X(:);
    X = X + repmat(t,[n 1]);
    plt_X = plot([X(1:2:end);X(1)], [X(2:2:end);X(2)],'y-');
    hold off
    mask = X;
end