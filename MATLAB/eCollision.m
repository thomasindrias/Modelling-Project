%%%%%%%%%%%%%%%%%%%%
% Friction on objects
% RB can interact with each other.
% Check out inelastic collisions
% Rotation?
%%%%%%%%%%%%%%%%%%%
%OPERATION EARTHQUAKE

close;
clear;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colors
lightGrey = [0.7,0.7,0.7];
darkGrey = [0.1,0.1,0.1];
brickRed = [0.6,0.25,0.2];

% Ball radius (Global for all balls)
radius = 1; % Radius of the ball

% Ball1 properties
ball1.pos.x = -1; % Init position X 
ball1.pos.y = 0; % Init position Y 
ball1.vel.x = 0.1; % Init position X 
ball1.vel.y = 0.9; % Init position Y 
ball1.mass = 1; % Weight in kilograms

%Ball2 properties
ball2.pos.x = -2; % Init position X 
ball2.pos.y = 1; % Init position Y 
ball2.vel.x = 0.1; % Initial speed X 
ball2.vel.y = 0.9; % Initial speed Y 
ball2.mass = 2; % Weight in Kilograms

% Box1 (Brick) properties
box1.size.x = 2; % Initial position (Box1)
box1.size.y = 0; % Initial position (Box1)
box1.pos.x = 2; % Initial position (Box1)
box1.pos.y = 0; % Initial position (Box1)
box1.vel.x = 0; % Initial speed (Box1)
box1.vel.y = 0; % Initial speed (Box1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ball1
a = 0:0.1:2*pi;
Xcircle = cos(a);
Ycircle = sin(a);
ball1Body = patch(ball1.pos.x+radius*Xcircle, ball1.pos.y+radius*Ycircle,darkGrey,'FaceAlpha',1);

% Ball2
a = 0:0.1:2*pi;
Xcircle = cos(a);
Ycircle = sin(a);
ball2Body = patch (ball2.pos.x+radius*Xcircle, ball2.pos.y+radius*Ycircle,darkGrey,'FaceAlpha',1);


% Box1 (Brick)
B2 = patch([box1.pos.x-box1.size.x, box1.pos(1)+box1.size(1), box1.pos(1)+box1.size(1), box1.pos(1)-box1.size(1)], ...
           [box1.pos(2)-box1.size(2)/2, box1.pos(2)-box1.size(2)/2, box1.pos(2)+box1.size(2)/2, box1.pos(2)+box1.size(2)/2], ...
           brickRed,'FaceAlpha',1);

% Floor properties
W = [-5,5];
H = [-5,5];

% Floor
patch([-5,5,5,-5],[-5,-5,5,5],[0,0,0,0],lightGrey, 'FaceAlpha', 0.5);
axis square equal;
hold on;


% TESTING
counter = 0;
for i = 1:1:50
    
  % Kollision with left and right wall
  if (ball1.pos.x<=W(1)+radius) || (ball1.pos.x>=W(2)-radius) 
    disp('a1')
    ball1.vel.x=-ball1.vel.x; 
  end
  
    % Kollision with up and down wall
  if (ball1.pos.y<=W(1)+radius) || (ball1.pos.y>=W(2)-radius) 
    disp('b1')
    ball1.vel.y=-ball1.vel.y; 
  end
  
  % Kollision with left and right wall
  if (ball2.pos.x<=W(1)+radius) || (ball2.pos.x>=W(2)-radius) 
    disp('a2')
    ball2.vel.x=-ball2.vel.x; 
  end
  
    % Kollision with up and down wall
  if (ball2.pos.y<=W(1)+radius) || (ball2.pos.y>=W(2)-radius) 
    disp('b2')
    ball2.vel.y=-ball2.vel.y; 
  end
  
  % Update params for balls
  ball1.pos.x = ball1.pos.x + ball1.velX;
  ball1.pos.y = ball1.pos.y+ ball1.velY;
  
  ball2.pos.x = ball2.pos.x + ball2.vel.x;
  ball2.pos.y = ball2.pos.y + ball2.vel.y;
  
  % avståndet mellan boll1 och boll2 = abs(ball1.pos-ball2.pos)
  %


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Early Escape test: if the length of the movevec is less
% %than distance between the centers of these circles minus
% %their radii, there's no way they can hit.
% double dist = B.center.distance(A.center);
% double sumRadii = (B.radius + A.radius);
% dist -= sumRadii;
% if(movevec.Magnitude() < dist){
%   return false;
% }
% 
% %Normalize the movevec
% Vector N = movevec.copy(); %euler speed
% N.normalize(); % NX = norm(ballXVel) etc.
% 
% 
% % Avståndet mellan två cirklar(sfärer)
% Vector C = B.center.minus(A.center); % distance (C) = abs(P2 - P1) %%% [2, 0],  [5, 0] = [2-5, 0-0] = [3, 0]
% 
% %D = N . C = ||C|| * cos(angle between N and C)
% double D = N.dot(C); % D = NX dot (distance) D is a number NOT a vector
% 
% %Another early escape: Make sure that A is moving
% %towards B! If the dot product between the movevec and
% %B.center - A.center is less that or equal to 0,
% %A isn't isn't moving towards B
% if(D <= 0){
%   return false;
% }
% 
% %Find the length of the vector C
% double lengthC = C.Magnitude();
% 
% double F = (lengthC * lengthC) - (D * D);
% 
% %Escape test: if the closest that A will get to B
% %is more than the sum of their radii, there's no
% %way they are going collide
% double sumRadiiSquared = sumRadii * sumRadii;
% if(F >= sumRadiiSquared){
%   return false;
% }
% 
% %We now have F and sumRadii, two sides of a right triangle.
% %Use these to find the third side, sqrt(T)
% double T = sumRadiiSquared - F;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  
  
  if (( abs(ball1.pos-ball2.pos)) <= 2*radius)
    ball1.vel = -ball1.vel;
    ball2.vel = -ball2.vel;
  end

  counter = mod((counter+1),6)
  
  set(ball1Body,'XData',ball1.pos.x+radius*Xcircle, 'YData', ball1.pos.y+radius*Ycircle);
  set(ball2Body,'XData',ball2.pos.x+radius*Xcircle, 'YData', ball2.pos.y+radius*Ycircle);

  axis([H(1) H(2) W(1) W(2)]);
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