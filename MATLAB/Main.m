close;
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colors
lightGrey = [0.7,0.7,0.7];
darkGrey = [0.1,0.1,0.1];
brickRed = [0.6,0.25,0.2];

% Ball properties
Ball.pos.x = -2; % Inital position 
Ball.pos.y = 0; % Inital position 
Ball.vel.x = 1; % Inital position 
Ball.vel.y = 0; % Inital position 
Ball.mass = 1; % Weight in kilograms
Ball.radius = 0.5; % ball radius

% Floor properties
Floor.size.x = 20;
Floor.size.y = 20;
Floor.pos.x = 0;
Floor.pos.y = 0;
Floor.XMin = Floor.pos.x - (Floor.size.x/2);
Floor.XMax = Floor.pos.x + (Floor.size.x/2);
Floor.YMin = Floor.pos.y - (Floor.size.y/2);
Floor.YMax = Floor.pos.y + (Floor.size.y/2);


% Box1 (Brick) properties
Box1.size.x = 2; % Initial position
Box1.size.y = 2; % Initial position
Box1.pos.x = 2; % Initial position
Box1.pos.y = 0; % Initial position
Box1.vel.x = 0; % Initial speed
Box1.vel.y = 0; % Initial speed
Box1.mass = 0.5; % Weight in Kilograms
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


% Init draw space 
axis square equal;
axis([Floor.XMin-1,Floor.XMax+1, Floor.YMin-1, Floor.YMax+1]);
hold on;

% Update loop
for i = 1:600

  % We check if the ball is hitting the border wall.
  if (Ball.pos.x < Floor.XMin+Ball.radius)
    Ball.vel.x = -Ball.vel.x;
    Ball.vel.y = -Ball.vel.y;
  end

  if (Ball.pos.x > Floor.XMax-Ball.radius)
    Ball.vel.x = -Ball.vel.x;
    Ball.vel.y = -Ball.vel.y;
  end
  
  if (Ball.pos.y < Floor.YMin+Ball.radius) 
    Ball.vel.x = -Ball.vel.x;
    Ball.vel.y = -Ball.vel.y;
  end

  if (Ball.pos.y > Floor.YMax-Ball.radius) 
    Ball.vel.x = -Ball.vel.x;
    Ball.vel.y = -Ball.vel.y;
  end

  % Check if our Ball is colliding with Box1
  if boxSphereIntersect(Ball.pos, Ball.radius, Box1.pos, Box1.size)
    disp('Ball has collided with the sphere. DO SHIT')
    Ball.vel.x = -Ball.vel.x;
    Ball.vel.y = -Ball.vel.y;
  end


  % Update our objects and make them ready for drawnow.
  set(ballBody,'XData',Ball.pos.x + (Ball.radius*Xcircle), 'YData', Ball.pos.y + (Ball.radius*Ycircle));
  drawnow;

  % Handle Friction
  % F = m*a = m*derivate(Velocity) -> We have velocity, we have mass.
  Ball.vel.x
  if (abs(Ball.vel.x) > 0.01 && Ball.vel.x > 0)
    disp('Vel greater then 0')
    Ball.vel.x = Ball.vel.x - 0.03*i*0.01;
  end

  if (abs(Ball.vel.x) > 0.01 && Ball.vel.x < 0)
    disp('Vel less then 0')
    Ball.vel.x = Ball.vel.x + 0.03*i*0.01;
  end

  % Update Vectors for next iteration  using euler for differential eqs.
  Ball.pos.x = Ball.pos.x + Ball.vel.x;
  Ball.pos.y = Ball.pos.y + Ball.vel.y;
  

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