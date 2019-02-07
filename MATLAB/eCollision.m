close;
clear;
clc;

% Colors
lightGrey = [0.7,0.7,0.7];
darkGrey = [0.1,0.1,0.1];
brickRed = [0.6,0.25,0.2];

% Body1 properties
radius = 1;
P1_ball = [-3,0];
P2_ball = [-1,0];
V1_ball = [0.1,0.1];
V2_ball = [0.1,1];
% Body2 properties
P2 = [2,0];
V2 = [0.0,0.0];

% Body1
a = 0:0.1:2*pi;
Xcircle = cos(a);
Ycircle = sin(a);
RB1 = patch (P1_ball(1)+radius*Xcircle, P1_ball(2)+radius*Ycircle,darkGrey,'FaceAlpha',1);

% Body2
a = 0:0.1:2*pi;
Xcircle = cos(a);
Ycircle = sin(a);
RBall2 = patch (P2_ball(1)+radius*Xcircle, P2_ball(2)+radius*Ycircle,darkGrey,'FaceAlpha',1);


% Body2
RB2 = patch([P2(1)-1,P2(1)+1,P2(1)+1,P2(1)-1],[P2(2)-2,P2(2)-2,P2(2)+2,P2(2)+2],brickRed,'FaceAlpha',1);

% Floor properties
W = [-5,5];
H = [-5,5];

% Floor
patch([-5,5,5,-5],[-5,-5,5,5],[0,0,0,0],lightGrey, 'FaceAlpha', 0.5);
axis square equal;
hold on;

for i = 1:1:300
    
    % Kollision with left and right wall
    if (P1_ball(1)<=W(1)+radius) || (P1_ball(1)>=W(2)-radius)
        V1_ball(1)=-V1_ball(1); 
    end
    
     % Kollision with left and right wall
    if (P1_ball(2)<=W(1)+radius) || (P1_ball(2)>=W(2)-radius) 
        V1_ball(2)=-V1_ball(2); 
    end
    
    % Kollision with left and right wall
    if (P2_ball(1)<=W(1)+radius) || (P2_ball(1)>=W(2)-radius) 
        V2_ball(1)=-V2_ball(1); 
    end
    
     % Kollision with left and right wall
    if (P2_ball(2)<=W(1)+radius) || (P2_ball(2)>=W(2)-radius)
        V2_ball(2)=-V2_ball(2); 
    end
    
    
    P1_ball(1) = P1_ball(1) + V1_ball(1);
    P1_ball(2) = P1_ball(2) + V1_ball(2);
    
    P2_ball(1) = P2_ball(1) + V2_ball(1);
    P2_ball(2) = P2_ball(2) + V2_ball(2);
    %P2(1) = P2(1) + V2(1);
    
    RB1 = patch (P1_ball(1)+radius*Xcircle, P1_ball(2)+radius*Ycircle,darkGrey,'FaceAlpha',1);
    RBall2 = patch (P2_ball(1)+radius*Xcircle, P2_ball(2)+radius*Ycircle,darkGrey,'FaceAlpha',1);
    RB2 = patch([P2(1)-1,P2(1)+1,P2(1)+1,P2(1)-1],[P2(2)-2,P2(2)-2,P2(2)+2,P2(2)+2],brickRed,'FaceAlpha',1);
    
    patch([-5,5,5,-5],[-5,-5,5,5],[0,0,0,0],lightGrey, 'FaceAlpha', 0.5);
    axis square equal;
    hold on;
    drawnow;
end