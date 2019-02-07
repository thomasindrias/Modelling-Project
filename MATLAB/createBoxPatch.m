function boxPatch = createBoxPatch(boxPos, boxSize, colorBox, alphaColor)
  
  % Define scope
  xMin = boxPos.x - (boxSize.x/2);
  xMax = boxPos.x + (boxSize.x/2);
  
  yMin = boxPos.y - (boxSize.y/2);
  yMax = boxPos.y + (boxSize.y/2);
  
  boxPatch = patch([xMin, xMax, xMax, xMin], [yMin, yMin, yMax, yMax], colorBox, 'FaceAlpha', alphaColor);

end