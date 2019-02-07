function collision = boxBoxIntersect(box1Pos, box1Size, box2Pos, box2Size) % Example: (box1.pos, box1.size, box2.pos, box2.size)
%%%%%%%%%%%%%%%%%%%%
% INPUT:
% boxSize = an array of the box size (x,y)
% boxPos = an array of the box position (x,y)
% OUTPUT:
% collision = Returns a boolean if A is inside B
%%%%%%%%%%%%%%%%%%%


%Box border declaration
box1MinX = box1Pos.x - box1Size.x;
box1MaxX = box1Pos.x + box1Size.x;
box1MinY = box1Pos.y - box1Size.y;
box1MaxY = box1Pos.y + box1Size.y;

box2MinX = box2Pos.x - box2Size.x;
box2MaxX = box2Pos.x + box2Size.x;
box2MinY = box2Pos.y - box2Size.y;
box2MaxY = box2Pos.y + box2Size.y;

collision = (box1MinX <= box2MaxX && box1MaxX >= box2MinX) && (box1MinY <= box2MaxY && box1MaxY >= box2MinY);

end