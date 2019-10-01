function N=asm_ShapeNormals(X)
    x = X(1:2:end);
    y = X(2:2:end);
    V = [x y];
    L = [(1:length(x))' [(2:length(x)) 1]'];

    DT=V(L(:,1),:)-V(L(:,2),:);
    D1=zeros(size(V));
    D2=zeros(size(V));
    D1(L(:,1),:)=DT;
    D2(L(:,2),:)=DT;
    D=D1+D2;
    Ds=sqrt(D(:,1).^2+D(:,2).^2);
    N(:,1)= D(:,2)./Ds;
    N(:,2)=-D(:,1)./Ds;
end