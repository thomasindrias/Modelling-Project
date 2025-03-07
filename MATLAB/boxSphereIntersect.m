function [collision, x, y] = boxSphereIntersect(spherePos, sphereRadius, boxPos, boxSize) % Example: (ball1.pos, ball1.radius, box1.pos, box1.size)
%%%%%%%%%%%%%%%%%%%%
% Collision intersection between box
% INPUT:
% spherePos = an array of the sphere position (x,y)
% sphereRadius = Radius of the sphere
% boxPos = an array of the box position (x,y)
% boxSize = an array of the box size (x,y)
% OUTPUT:
% collision = Returns a boolean if A is inside B
%%%%%%%%%%%%%%%%%%%


%Box border declaration
boxMinX = boxPos.x - boxSize.x/2;
boxMaxX = boxPos.x + boxSize.x/2;
boxMinY = boxPos.y - boxSize.y/2;
boxMaxY = boxPos.y + boxSize.y/2;

%get box closest point to sphere center by clamping
x = max(boxMinX, min(spherePos.x, boxMaxX));
y = max(boxMinY, min(spherePos.y, boxMaxY));

distance = (x - spherePos.x)^2 + (y - spherePos.y)^2;
collision = distance < (sphereRadius*sphereRadius); % sphereRadius^2

end