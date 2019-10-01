function im_ce = LCE(im,lambda)
    % Converting to grayscale
    sz3 = size(im,3);
    if(sz3 == 3)
        im = rgb2gray(im);
    end
    % Scaling intensities to (0,1]
    f = double(im+1)./256;
    h = size(f,1);
    w = size(f,2);
    im_ce = f;
    
    for i=2:h-1
        for j=2:w-1
            % Finding entropies along vertical, horizontal, diagonal and auxillary diagonal directions
            x_vertical = [f(i,j-1);f(i,j);f(i,j+1)];
            m1 = sum(x_vertical);
            y_vertical = x_vertical./m1;
            E1 = (-1)*sum(y_vertical.*log(y_vertical));
            
            x_horizontal = [f(i-1,j);f(i,j);f(i+1,j)];
            m2 = sum(x_horizontal);
            y_horizontal = x_horizontal./m2;
            E2 = (-1)*sum(y_horizontal.*log(y_horizontal));
            
            x_diagonal = [f(i-1,j-1);f(i,j);f(i+1,j+1)];
            m3 = sum(x_diagonal);
            y_diagonal = x_diagonal./m3;
            E3 = (-1)*sum(y_diagonal.*log(y_diagonal));
            
            x_auxDiagonal = [f(i-1,j+1);f(i,j);f(i+1,j-1)];
            m4 = sum(x_auxDiagonal);
            y_auxDiagonal = x_auxDiagonal./m4;
            E4 = (-1)*sum(y_auxDiagonal.*log(y_auxDiagonal));
            
            % Dynamic non-linear transformation to enhance local contrast
            E = [E1;E2;E3;E4];
            p = abs(max(E)-min(E));
            v = (sum(sum(f(i-1:i+1,j-1:j+1))))./9;
            F = (abs(f(i,j)-v)./(f(i,j)+v));
            Z = lambda.*(1-p);
            F1 = F.^Z;
            
            % Calculating new memebership degree after contrast enhancement
            if(f(i,j) <= v)
                im_ce(i,j) = ((v.*(1-F1))./(1+F1));
            else
                im_ce(i,j) = ((v.*(1+F1))./(1-F1));
            end
        end
    end
    % Scaling the output image to [0,255]
    m = min(min(im_ce));
    M = max(max(im_ce));
    im_ce = uint8(floor(255*(im_ce-m)/(M-m)));        
end