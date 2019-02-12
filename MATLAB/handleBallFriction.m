function [ballVelX, ballVelY] = handleBallFriction(ballVel, ballMass)
 % Init params
 ballVelX = 0;
 ballVelY = 0;
 if (abs(ballVel.x) > 0.0001 && ballVel.x > 0)
  ballVelX = ballVel.x - 0.01*(ballMass);
 end

 if (abs(ballVel.x) > 0.0001 && ballVel.x < 0)
  ballVelX = ballVel.x + 0.01*(ballMass);
 end

 if (abs(ballVel.y) > 0.0001 && ballVel.y > 0)
  ballVelY = ballVel.y - 0.01*(ballMass);
 end

 if (abs(ballVel.y) > 0.0001 && ballVel.y < 0)
  ballVelY = ballVel.y + 0.01*(ballMass);
 end
end

