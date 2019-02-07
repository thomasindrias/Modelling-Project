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
ball1Pos = [-3,0]; % Init position (Ball1)
ball1Vel = [0.1,0.1]; % Initial speed (Ball1)
ball1Mass = 2; % Weigth in Kilograms

% Ball2 properties
ball2Pos = [-1,0]; % Init position (Ball2)
ball2Vel = [0.1,0.9]; % Initial speed (Ball2)
ball2Mass = 2; % Weight in Kilograms

% Box1 (Brick) properties
box1.size = [1, 2]; % Box size (Box1)
box1.pos = [2,0]; % Initial position (Box1)
box1.vel = [0.0,0.0]; % Initial speed (Box1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ball1
a = 0:0.1:2*pi;
Xcircle = cos(a);
Ycircle = sin(a);
ball1Body = patch (ball1Pos(1)+radius*Xcircle, ball1Pos(2)+radius*Ycircle,darkGrey,'FaceAlpha',1);

% Ball2
a = 0:0.1:2*pi;
Xcircle = cos(a);
Ycircle = sin(a);
ball2Body = patch (ball2Pos(1)+radius*Xcircle, ball2Pos(2)+radius*Ycircle,darkGrey,'FaceAlpha',1);


% Box1 (Brick)
B2 = patch([box1.pos(1)-box1.size(1)/2, box1.pos(1)+box1.size(1)/2, box1.pos(1)+box1.size(1)/2, box1.pos(1)-box1.size(1)/2], ...
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
  if (ball1Pos(1)<=W(1)+radius) || (ball1Pos(1)>=W(2)-radius) 
    disp('a1')
    ball1Vel(1)=-ball1Vel(1); 
  end
  
    % Kollision with up and down wall
  if (ball1Pos(2)<=W(1)+radius) || (ball1Pos(2)>=W(2)-radius) 
    disp('b1')
    ball1Vel(2)=-ball1Vel(2); 
  end
  
  % Kollision with left and right wall
  if (ball2Pos(1)<=W(1)+radius) || (ball2Pos(1)>=W(2)-radius) 
    disp('a2')
    ball2Vel(1)=-ball2Vel(1); 
  end
  
    % Kollision with up and down wall
  if (ball2Pos(2)<=W(1)+radius) || (ball2Pos(2)>=W(2)-radius) 
    disp('b2')
    ball2Vel(2)=-ball2Vel(2); 
  end
  
  % Update params for balls
  ball1Pos(1) = ball1Pos(1) + ball1Vel(1);
  ball1Pos(2) = ball1Pos(2) + ball1Vel(2);
  
  ball2Pos(1) = ball2Pos(1) + ball2Vel(1);
  ball2Pos(2) = ball2Pos(2) + ball2Vel(2);
  
  % avståndet mellan boll1 och boll2 = abs(ball1Pos-ball2Pos)
  %
  
  
  if (( abs(ball1Pos-ball2Pos)) <= 2*radius)
    ball1Vel = -ball1Vel;
    ball2Vel = -ball2Vel;
  end

  counter = mod((counter+1),6)
  
  set(ball1Body,'XData',ball1Pos(1)+radius*Xcircle, 'YData', ball1Pos(2)+radius*Ycircle);
  set(ball2Body,'XData',ball2Pos(1)+radius*Xcircle, 'YData', ball2Pos(2)+radius*Ycircle);

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