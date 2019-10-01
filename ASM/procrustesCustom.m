function procrustesList = procrsutesCustom(shapesMat)
    % Input is a matrix of k*2n dimension.
    % k is number of shapes
    % In 2n columns 1:2:end are x-coordinates and 2:2:end are y-coordinates
    
    numPts = size(shapesMat,2)/2;
    k = size(shapesMat,1);

    procrustesList = zeros(k,2*numPts);

    % Translation
    center  = [sum(shapesMat(:,1:2:end),2)./numPts,sum(shapesMat(:,2:2:end),2)./numPts];
    centerMat = repmat(center,[1 numPts]);
    shapesMat = shapesMat - centerMat;

    % Isomorphic scaling
    scl = sqrt((sum(shapesMat.^2,2))./numPts);
    shapesMat = shapesMat.*(1./scl);

    meanShape = mean(shapesMat);
    meanShape = [meanShape(1:2:end);meanShape(2:2:end)];

    % Rotation
    % Finding the rotation matrix by using solution to the orthogonal procrustes problem
    for i = 1:k
        p = shapesMat(i,:);
        p = [p(1:2:end);p(2:2:end)];
        [U S V] = svd(p*meanShape');
        R = V*(U)';
        if(det(R) == -1)
            R = V*diag([1 -1])*(U)';
        end
        rotatedShape = R*p;
        procrustesList(i,:) = rotatedShape(:)';    
    end
end