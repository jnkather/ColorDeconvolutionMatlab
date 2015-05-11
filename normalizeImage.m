% color deconvolution project by Jakob Nikolas Kather, 2015
% contact: www.kather.me

function imageOut = normalizeImage(imageIn, opt)

	imageOut = imageIn;
	for i=1:size(imageIn,3)
		Ch = imageOut(:,:,i);

        % normalize output range to 0...1
		imageOut(:,:,i) = (imageOut(:,:,i)-min(Ch(:)))/(max(Ch(:)-min(Ch(:))));
		
        % invert image
        imageOut(:,:,i) = 1 - imageOut(:,:,i);

        % optional: stretch histogram
        if strcmp(opt,'stretch')
        	imageOut(:,:,i) = imadjust(imageOut(:,:,i),stretchlim(imageOut(:,:,i)),[]);
        end
	end

end