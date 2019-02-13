function boxVelX = handleBoxFriction(boxVel, boxMass)
  % Init params
  boxVelX = 0;

 dummyVal = boxVelX;
 if (abs(boxVel.x) > 0.0001 && boxVel.x > 0)
   dummyVal = boxVel.x - 0.01*(boxMass);
 end

 if (abs(boxVel.x) > 0.0001 && boxVel.x < 0)
   dummyVal = boxVel.x + 0.01*(boxMass);
 end

 if (dummyVal < 0 && boxVel.x > 0 || dummyVal > 0 && boxVel.x < 0)
   boxVelX = 0;
 else
   boxVelX = dummyVal;
 end
end

