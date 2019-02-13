close;
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colors
lightGrey = [0.7,0.7,0.7];
darkGrey = [0.1,0.1,0.1];
brickRed = [0.6,0.25,0.2];

% Ball properties
Ball.pos.x = 100; % Inital position 
Ball.pos.y = 60; % Inital position 
Ball.vel.x = -4; % Inital position 
Ball.vel.y = -4; % Inital position 
Ball.mass = 1; % Weight in kilograms
Ball.radius = 8; % ball radius

% Floor properties
Floor.size.x = 400;
Floor.size.y = 400;
Floor.pos.x = 0;
Floor.pos.y = 0;
Floor.XMin = Floor.pos.x - (Floor.size.x/2);
Floor.XMax = Floor.pos.x + (Floor.size.x/2);
Floor.YMin = Floor.pos.y - (Floor.size.y/2);
Floor.YMax = Floor.pos.y + (Floor.size.y/2);


% Box1 (Brick) properties
Box1.size.x = 30; % Initial position
Box1.size.y = 30; % Initial position
Box1.pos.x = 0; % Initial position
Box1.pos.y = 0; % Initial position
Box1.vel.x = 0; % Initial speed
Box1.vel.y = 0; % Initial speed
Box1.mass = 2; % Weight in Kilograms
Box1.moi = 0; % Moment of inertia
Box1.normal.right = [1,0]; 
Box1.normal.up = [0,1];
Box1.normal.left = [-1,0];
Box1.normal.down = [0,-1];
Box1.xMin = Box1.pos.x - (Box1.size.x/2);
Box1.xMax = Box1.pos.x + (Box1.size.x/2);
Box1.yMin = Box1.pos.y - (Box1.size.y/2);
Box1.yMax = Box1.pos.y + (Box1.size.y/2);

% Box2 (Brick) properties
Box2.size.x = 10; % Initial position
Box2.size.y = 10; % Initial position
Box2.pos.x = -60; % Initial position
Box2.pos.y = -60; % Initial position
Box2.vel.x = 0; % Initial speed
Box2.vel.y = 0; % Initial speed
Box2.mass = 1; % Weight in Kilograms
Box2.moi = 0; % Moment of inertia
Box2.xMin = Box2.pos.x - (Box2.size.x/2);
Box2.xMax = Box2.pos.x + (Box2.size.x/2);
Box2.yMin = Box2.pos.y - (Box2.size.y/2);
Box2.yMax = Box2.pos.y + (Box2.size.y/2);
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

% CREATE FUNCTION TO DYNAMICALLY CREATE BODIES
box1Body = createBoxPatch(Box1.pos, Box1.size, brickRed, 1);
box2Body = createBoxPatch(Box2.pos, Box2.size, brickRed, 1);


% Init draw space 
axis square equal;
axis([Floor.XMin-1,Floor.XMax+1, Floor.YMin-1, Floor.YMax+1]);
hold on;

% Update loop
for i = 1:300
  % Check if our Ball is colliding with Box1
  % CREATE FUNCTION TO DYNAMICALLY CHECK INTERSECTIONS
  [box1Collision, box1CollisionPosX, box1CollisionPosY] = boxSphereIntersect(Ball.pos, Ball.radius, Box1.pos, Box1.size);
  if box1Collision
    disp('Ball has collided with the Box1. DO SHIT')
    % New implementation for ball
    %n_x = (Box1.pos.x - box1CollisionPosX)/(Box1.size.x); % This wont work completely. The equations is for sphere -> sphere
    %n_y = (Box1.pos.y - box1CollisionPosY)/(Box1.size.y); % This wont work completely. The equations is for sphere -> sphere
    %p = (2*(Ball.vel.x*n_x + Ball.vel.y*n_y))/(Ball.mass + Box1.mass);
    %vBallX = Ball.vel.x - (p * Ball.mass * n_x) - (p * Box1.mass * n_x);
    %vBallY = Box1.vel.y - (p * Ball.mass * n_y) - (p * Box1.mass * n_y);

    % We have the ball position
    % We have velocity vectors for x and y
    % We can now create the velocity vector between ball center and velocityPoint
    %atan2d(Box1.normal.right(2) - Ball.vel.y, Box1.normal.right(1) - Ball.vel.x) % I THINK IT WORK

    theta = 180-rad2deg(acos(dot([Ball.vel.x, Ball.vel.y], [Box1.normal.right(1), Box1.normal.right(2)])/(norm([Ball.vel.x, Ball.vel.y])*norm([Box1.normal.right(1), Box1.normal.right(2)]))))
    
    % dot([Ball.pos.x - box1CollisionPosX, Ball.pos.y - box1CollisionPosY, 0].*[Box1.normal.right(1), Box1.normal.right(2), 0])/(norm([Ball.pos.x - box1CollisionPosX, Ball.pos.y - box1CollisionPosY, 0])*norm([Box1.normal.right(1), Box1.normal.right(2), 0]))
    
    % This will return the angle between a chosen normal and the velocity vector.
    % This kinda does not work. Vi behöver generera normalen utifrån nuvarande pos på boxen.
    % Vi behöver generera normalen rakt  ut från collisionen 
    % Exempel: CollisonX + 1 för att "dra" en normal från kollision i x-led
    % Vi behöver berätta för matlab var normalen börjar. Alltså boxWallX + 1 till exempel så vi får rätt vinkel med atan2d
    % Speciellt om det ska funka med roterande objekt
    vBallX = ((Ball.mass - Box1.mass)/(Ball.mass + Box1.mass))*Ball.vel.x + ((2*Box1.mass)/(Ball.mass + Box1.mass))*Box1.vel.x;
    vBallY = ((Ball.mass - Box1.mass)/(Ball.mass + Box1.mass))*Ball.vel.y + ((2*Box1.mass)/(Ball.mass + Box1.mass))*Box1.vel.y;

    Box1.vel.x = ((2*Ball.mass)/(Ball.mass + Box1.mass))*Ball.vel.x + ((Box1.mass - Ball.mass)/(Ball.mass + Box1.mass))*Box1.vel.x;
    Box1.vel.y = ((2*Ball.mass)/(Ball.mass + Box1.mass))*Ball.vel.y + ((Box1.mass - Ball.mass)/(Ball.mass + Box1.mass))*Box1.vel.y;

    Ball.vel.x = vBallX;
    Ball.vel.y = vBallY;
  end

  
  % CREATE FUNCTION TO DYNAMICALLY CHECK INTERSECTIONS
  %[box2Collision, box2CollisionPosX, box2CollisionPosY] = boxSphereIntersect(Ball.pos, Ball.radius, Box2.pos, Box2.size);
  %if box2Collision
  %  disp('Ball has collided with the box. DO SHIT')
  %  vBallX = ((Ball.mass - Box2.mass)/(Ball.mass + Box2.mass))*Ball.vel.x + ((2*Box2.mass)/(Ball.mass + Box2.mass))*Box2.vel.x;
  %  vBallY = ((Ball.mass - Box2.mass)/(Ball.mass + Box2.mass))*Ball.vel.y + ((2*Box2.mass)/(Ball.mass + Box2.mass))*Box2.vel.y;

  %  Box2.vel.x = ((2*Ball.mass)/(Ball.mass + Box2.mass))*Ball.vel.x + ((Box2.mass - Ball.mass)/(Ball.mass + Box2.mass))*Box2.vel.x;
  %  Box2.vel.y = ((2*Ball.mass)/(Ball.mass + Box2.mass))*Ball.vel.y + ((Box2.mass - Ball.mass)/(Ball.mass + Box2.mass))*Box2.vel.y;

  %  Ball.vel.x = vBallX;
  %  Ball.vel.y = vBallY;
 % end

  % IMPLEMENT HANDLING OF COLLISIONS AT AN ANGLE
  % IMPLEMENT HANDLING OF COLLISIONS AT AN ANGLE
  % IMPLEMENT HANDLING OF COLLISIONS AT AN ANGLE
  % IMPLEMENT HANDLING OF COLLISIONS AT AN ANGLE

  % Update our objects and make them ready for drawnow.
  % CREATE FUNCTION TO DYNAMICALLY UPDATE GRAPHICS
  set(ballBody,'XData',Ball.pos.x + (Ball.radius*Xcircle), 'YData', Ball.pos.y + (Ball.radius*Ycircle));
  set(box1Body,'XData',[Box1.xMin, Box1.xMax, Box1.xMax, Box1.xMin], 'YData',[Box1.yMin, Box1.yMin, Box1.yMax, Box1.yMax]);
  set(box2Body,'XData',[Box2.xMin, Box2.xMax, Box2.xMax, Box2.xMin], 'YData',[Box2.yMin, Box2.yMin, Box2.yMax, Box2.yMax]);
  drawnow;

  % Handle linear Friction for Ball
  [Ball.vel.x, Ball.vel.y] = handleBallFriction(Ball.vel, Ball.mass);

  % Handle linear friction for Boxes
  % CREATE FUNCTION TO DYNAMICALLY HANDLE FRICTION
  Box1.vel.x = handleBoxFriction(Box1.vel, Box1.mass);
  Box2.vel.x = handleBoxFriction(Box2.vel, Box2.mass);

  % Update Vectors for next iteration  using euler for differential eqs.
  % CREATE FUNCTION TO DYNAMICALLY UPDATE POSITION
  Ball.pos.x = Ball.pos.x + Ball.vel.x;
  Ball.pos.y = Ball.pos.y + Ball.vel.y;
  
  Box1.pos.x = Box1.pos.x + Box1.vel.x;
  Box1.pos.y = Box1.pos.y + Box1.vel.y;

  Box2.pos.x = Box2.pos.x + Box2.vel.x;
  Box2.pos.y = Box2.pos.y + Box2.vel.y;

  % CREATE FUNCTION TO DYNAMICALLY UPDATE BOUNDRIES
  Box1.xMin = Box1.pos.x - (Box1.size.x/2);
  Box1.xMax = Box1.pos.x + (Box1.size.x/2);
  Box1.yMin = Box1.pos.y - (Box1.size.y/2);
  Box1.yMax = Box1.pos.y + (Box1.size.y/2);

  Box2.xMin = Box2.pos.x - (Box2.size.x/2);
  Box2.xMax = Box2.pos.x + (Box2.size.x/2);
  Box2.yMin = Box2.pos.y - (Box2.size.y/2);
  Box2.yMax = Box2.pos.y + (Box2.size.y/2);

  F(i) = getframe(gcf);
end

writerObj = VideoWriter('elasticCollision.avi');
writerObj.FrameRate = 60;
writerObj.Quality = 100;
 
open(writerObj);
for i=1:length(F)
  frame = F(i);    
  writeVideo(writerObj, frame);
end

close(writerObj);