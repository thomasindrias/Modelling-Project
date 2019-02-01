clc
clear


%%%%%% PARAMS %%%%%%%%
numValues = 200;
stepSize = 0.1;


frictionStatic = 0.7; % myS
frictionKinetic = 0.3; % myK
objectMass = 8; % Value in kilograms
forceAngle = 0.523598776; % (30 degrees) Value in radians
%%%%%%%%%%%%%%%%%%%%%%

% Init Force vector
F = zeros(numValues, 1); % Inits an array of numValue zeros.
F(1) = 200; % We need an inital force or the object will never move. (Law of friction)

% Init Acceleration vector
a = zeros(numValues, 1);

% Init Velocity vector
v = zeros(numValues, 1);
v(1) = 40;

% Gravitation
g = 9.8;

Fx = F(1)*cos(forceAngle);
staticMaxF = frictionStatic*(objectMass*g + F(1)*sin(forceAngle));

if (staticMaxF < Fx)
    accelerationX = -(frictionKinetic*(objectMass*g + F(1)*sin(forceAngle)))/objectMass; % Constant acceleration
    for i = 1:numValues
        if (v(i) > 0) % If the speed is negative we dont want to continue
            v(i+1) = v(i) + stepSize*accelerationX; % Euler method for acceleration and velocity
        end
    end
end

figure;
plot(v)
