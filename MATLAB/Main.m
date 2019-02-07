close;
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colors
lightGrey = [0.7,0.7,0.7];
darkGrey = [0.1,0.1,0.1];
brickRed = [0.6,0.25,0.2];

% Ball properties
Ball.pos.x = -1; % Inital position 
Ball.pos.y = 0; % Inital position 
Ball.vel.x = 0.1; % Inital position 
Ball.vel.y = 0.9; % Inital position 
Ball.mass = 1; % Weight in kilograms
Ball.radius = 1; % ball radius

% Floor properties
Floor.size.x = 10;
Floor.size.y = 10;
Floor.pos.x = 0;
Floor.pos.y = 0;
Floor.XMin = Floor.pos.x - (Floor.size.x/2);
Floor.XMax = Floor.pos.x + (Floor.size.x/2);
Floor.YMin = Floor.pos.y - (Floor.size.y/2);
Floor.YMax = Floor.pos.y + (Floor.size.y/2);


% Box1 (Brick) properties
Box1.size.x = 2; % Initial position
Box1.size.y = 1; % Initial position
Box1.pos.x = 2; % Initial position
Box1.pos.y = 0; % Initial position
Box1.vel.x = 0; % Initial speed
Box1.vel.y = 0; % Initial speed

% Box2 (Brick) properties
Box2.size.x = 1; % Initial position
Box2.size.y = 2; % Initial position
Box2.pos.x = -2; % Initial position
Box2.pos.y = 1; % Initial position
Box2.vel.x = 0; % Initial speed
Box2.vel.y = 0; % Initial speed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We want to loop constant updates, we need functions to call
%   - We need to loop for x "seconds"
%     - Will there be a collision?
%       - OPTIONAL Sphere <-> Sphere
%       - Box <-> Box
%       - Sphere <-> Box

%     - What will the resulting vectors become?
%       - Depends on what objects collide

%     - Friction?
%     - Gravitation?
%     - Euler Updates
%       - Update speed
%       - Update angle

%    - End loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ball
a = 0:0.1:2*pi;
Xcircle = cos(a);
Ycircle = sin(a);
ballBody = patch(Ball.pos.x + (Ball.radius*Xcircle), Ball.pos.y + (Ball.radius*Ycircle),darkGrey,'FaceAlpha',1);

% This creates our body patch ("Creates a rigid body")
FloorBody = createBoxPatch(Floor.pos, Floor.size, lightGrey, 0.5);
box1Body = createBoxPatch(Box1.pos, Box1.size, brickRed, 1);
box2Body = createBoxPatch(Box2.pos, Box2.size, brickRed, 1);


% Init draw space 
axis square equal;
axis([Floor.XMin-1,Floor.XMax+1, Floor.YMin-1, Floor.YMax+1]);
hold on;

% Update loop
for i = 1:100


 % if boxSphereCollision = true
 %  do stuff
 % end

 % if boxBoxCollision = true
 %  do stuff
 % end


 % Handle Friction
 % Update Vectors for next iteration  using euler for differential eqs.
  drawnow;

  %axis([minX maxX minY maxY]);
end




% Collision functions
% boolean boxSphereCollision = boxSphereIntersect(ball1.pos, ball1.radius, box1.pos, box1.size)
% boolean boxBoxCollision = boxBoxIntersect(box1.pos, box1.size, box2.pos, box2.size)
%






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%F(i) = getframe(gcf);
%set(ball1Body,'XData',ball1.pos(1)+radius*Xcircle, 'YData', ball1.pos(2)+radius*Ycircle);
%set(ball2Body,'XData',ball2Pos(1)+radius*Xcircle, 'YData', ball2Pos(2)+radius*Ycircle);

%writerObj = VideoWriter('elasticCollision.avi');
%writerObj.FrameRate = 60;
%writerObj.Quality = 100;
 
%open(writerObj);
%for i=1:length(F)
%  frame = F(i);    
%  writeVideo(writerObj, frame);
%end
%close(writerObj);

% Ball1
%a = 0:0.1:2*pi;
%Xcircle = cos(a);
%Ycircle = sin(a);
%ball1Body = patch(ball1.pos(1)+radius*Xcircle, ball1.pos(2)+radius*Ycircle,darkGrey,'FaceAlpha',1);

% Floor
%patch([-5,5,5,-5],[-5,-5,5,5],[0,0,0,0],lightGrey, 'FaceAlpha', 0.5);