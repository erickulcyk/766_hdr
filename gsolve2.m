function [ g ] = gsolve2( Z, Time, lambda, weight )

%
% gsolve2.m − Solve for imaging system response function and create hdr image
%
% Given a set of pixel values observed for several pixels in several
% images with different exposure times, this function returns the
% imaging system’s response function g as well as the log film irradiance
% values for the observed pixels.
%
% Assumes:
%
% Zmin = 0
% Zmax = 255
%
% Arguments:
%
% Z(i,j) is the pixel values of pixel location number i in image j
% Time(j) is the log delta t, or log shutter speed, for image j
% lambda is the constant that determines the amount of smoothness
% weight(z) is the weighting function value for pixel value z
%
% Returns
%
% g(z) is the log exposure corresponding to pixel value z

n = 256;
pixel_count = size(Z,1);
img_count = size(Z,2);
A = zeros(pixel_count*img_count+n+1,n+pixel_count);
b = zeros(size(A,1),1);
%% Include the data−fitting equations
index = 1;

for i=1:pixel_count
    for j=1:img_count
        val = Z(i,j);
        wij = weight(val+1);
        A(index,val+1) = wij;
        A(index,n+i) = -wij;
        b(index,1) = wij * Time(j);
        index=index+1;
    end
end
%% Fix the curve by setting its middle value to 0
A(index,129) = 1;
index=index+1;
%% Include the smoothness equations
for i=1:n-2
    A(index,i)=lambda*weight(i+1);
    A(index,i+1)=-2*lambda*weight(i+1);
    A(index,i+2)=lambda*weight(i+1);
    index=index+1;
end
%% Solve the system using SVD
x = A\b;
g = x(1:n);
end