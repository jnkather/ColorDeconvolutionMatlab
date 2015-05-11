% color deconvolution function by Jakob Nikolas Kather, 2015
% contact: www.kather.me

function imageOut = SeparateStains(imageRGB, convMatrix)

    % convert input image to double precision float, avoid zeros
    imageRGB = (double(imageRGB)+1)/256;

    % perform color deconvolution
    imageOut = reshape(-log(imageRGB),[],3) * convMatrix;
    imageOut = reshape(imageOut, size(imageRGB));

    % post-processing
	for i=1:3
		Ch = imageOut(:,:,i);

        % normalize output range to 0...1
		imageOut(:,:,i) = (imageOut(:,:,i)-min(Ch(:)))/(max(Ch(:)-min(Ch(:))));
		
        % invert image
        imageOut(:,:,i) = 1 - imageOut(:,:,i);

        % optional: stretch histogram
        % imageOut(:,:,i) = imadjust(imageOut(:,:,i),stretchlim(imageOut(:,:,i)),[]);
	end
end
