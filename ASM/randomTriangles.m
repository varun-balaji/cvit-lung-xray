function triList = randomTriangles(numTri,a,p,scl)
    % Random coordinates generated with the formula a+p*rand()
    tempList1 = [a + p.*rand(numTri,2),scl.*rand(numTri,2)];
    thetaList = -180 + 360.*rand(numTri,1);
    triList = [];
    for i=1:numTri
        buildTri = tempList1(i,:);
        tempTri = [buildTri([1 2]);buildTri([1 2]) + [buildTri(3) 0];buildTri([1 2]) + [0 buildTri(4)]];
        tempRotTri = [];
        theta = thetaList(i);
        for j=1:3
            center = sum(tempTri)./3;
            tempRotTri =[tempRotTri;center'+[cosd(theta) -sind(theta);sind(theta) cosd(theta)]*(tempTri(j,:)-center)'];
        end
        triList = [triList;tempRotTri'];
    end
end