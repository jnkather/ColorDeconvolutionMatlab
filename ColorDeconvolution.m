% color deconvolution function by Jakob Nikolas Kather, 2015
% contact: www.kather.me

% initialize
format compact, close all, clear all, clc;

% specify source image
% this image is from www.proteinatlas.com, used in accordance with the license
% found under http://www.proteinatlas.org/about/datausage
imageURL = 'http://www.proteinatlas.org/images/20416/45828_A_4_7_rna_selected.jpg';
imageRGB = imread(imageURL);

% set of standard values for stain vectors (from python scikit)
He = [0.65; 0.70; 0.29];
Eo = [0.07; 0.99; 0.11];
DAB = [0.27; 0.57; 0.78];

% alternative set of standard values (HDAB from Fiji)
% He = [ 0.6500286;  0.704031;    0.2860126 ];
% DAB = [ 0.26814753;  0.57031375;  0.77642715];
% Eo = [ 0.7110272;   0.42318153; 0.5615672 ]; % residual

% combine stain vectors to deconvolution matrix
HEDtoRGB = [He/norm(He) Eo/norm(Eo) DAB/norm(DAB)]';
RGBtoHED = inv(HEDtoRGB);
    
% call stain separation functions, stop time
tic
imageHED = SeparateStains(imageRGB,RGBtoHED);
toc

% show images
fig1 = figure();
hold on;
subplot(2,4,1); imshow(imageRGB); title('Orig');
subplot(2,4,2); imshow(imageHED(:,:,1),[]); title('He');
subplot(2,4,3); imshow(imageHED(:,:,2),[]); title('Eo');
subplot(2,4,4); imshow(imageHED(:,:,3),[]); title('DAB');

subplot(2,4,5); imhist(rgb2gray(imageRGB)); title('Orig');
subplot(2,4,6); imhist(imageHED(:,:,1)); title('He');
subplot(2,4,7); imhist(imageHED(:,:,2)); title('Eo');
subplot(2,4,8); imhist(imageHED(:,:,3)); title('DAB');
