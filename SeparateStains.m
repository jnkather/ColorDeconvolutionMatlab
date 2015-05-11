% color deconvolution project by Jakob Nikolas Kather, 2015
% contact: www.kather.me

function imageOut = SeparateStains(imageRGB, Matrix)

    % convert input image to double precision float
    % add 2 to avoid artifacts of log transformation
    imageRGB = double(imageRGB)+2;

    % perform color deconvolution
    imageOut = reshape(-log(imageRGB),[],3) * Matrix;
    imageOut = reshape(imageOut, size(imageRGB));

    % post-processing
    imageOut = normalizeImage(imageOut,'no-stretch');
end
