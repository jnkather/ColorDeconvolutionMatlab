function [rgbout, currstats] = mask9toRGB(mask,colors)

rgbout = zeros(size(mask,1),size(mask,2),3);

numchannel = size(mask,3);
currstats = nan(numchannel,1);

% iterate channels
for i=1:numchannel
    
    
    basecolor = zeros(1,1,3);
    basecolor(1,1,:) = colors(i,:);
    currActivation = mask(:,:,i);
    addRGB = currActivation .* basecolor;
    
    rgbout = rgbout + addRGB;
    
    % calculate mean activation for each class
    currstats(i) = mean(currActivation(:));
    
end

end