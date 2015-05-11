% color deconvolution project by Jakob Nikolas Kather, 2015
% contact: www.kather.me

% caution: recombination of low contrast images does not preserve 
% low contrast, but enhances contrast in each channel. This should
% be corrected.

function imageOut = RecombineStains(imageIn, Matrix)

	lo = min(imageIn(:));
	hi = max(imageIn(:));

	if ~(lo>0) && ~(hi<1) % image range is 0...1 -> continue
		if strcmp(class(imageIn),'double') % image is double -> continue
			% input is alright, continue
			imageOut = -reshape(imageIn,[],3) * Matrix;
			imageOut = exp(imageOut);
			imageOut = reshape(imageOut, size(imageIn));
			imageOut = normalizeImage(imageOut, 'stretch');
		else % image is not double
			warning('image is not double')
			imageOut = imageIn;
		end	
	else % image range is below 0 or above 1
		warning('image out of bounds')
		imageOut = imageIn;
	end	
end
