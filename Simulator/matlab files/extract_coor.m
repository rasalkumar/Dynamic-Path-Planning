function [ verti ] = extract_coor(image_object )

% Function to extract vertices of objects from the image map given


dim = size(image_object);
image_binary = zeros(dim(1:2));      
for i=1:dim(1)
    for j=1:dim(2)
        if(image_object(i,j,1)>200)           % conversion of black&white image into logical image
            image_binary(i,j) = 1;
        end
    end
end

[image_binary_label,count] = bwlabel(image_binary);        % putting labels to logical image
stats = regionprops(image_binary_label,'BoundingBox');                    % applying BoundingBox regionprops to labelled image
BBox = zeros(count,4);
for i=1:count
BBox(i,:) = stats(i).BoundingBox;
end
verti = zeros(count-1,8);
for i=1:count-1
verti(i,1) = BBox(i+1,1);
verti(i,2) = BBox(i+1,2);
verti(i,3) = BBox(i+1,1)+ BBox(i+1,3);
verti(i,4) = BBox(i+1,2);                                 % conversion of vertices given in regionprops format to Eucidian format.
verti(i,5) = BBox(i+1,1);
verti(i,6) = BBox(i+1,2)+BBox(i+1,4);
verti(i,7) = BBox(i+1,1)+BBox(i+1,3);
verti(i,8) = BBox(i+1,2)+BBox(i+1,4);
end
end
 

