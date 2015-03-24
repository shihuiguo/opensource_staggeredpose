function frames = findConstraints(s, m)
    
    lFoot = s.tree(6);
    rFoot = s.tree(12);
    lFootInd = lFoot.id;
    rFootInd = rFoot.id;
    
    windowSize = 30;
    threshold = 0.5;
    
    numFrames = size(m, 1);
    lFootPosArray = zeros(numFrames, 3);
    rFootPosArray = zeros(numFrames, 3);
    
    for indFrame = 1 : numFrames
        xyz = skel2xyz(s, m(indFrame, :));
        lFootPosArray(indFrame, :) = xyz(lFootInd, :);
        rFootPosArray(indFrame, :) = xyz(rFootInd, :);
        
    end

    lInv = - lFootPosArray(:, 2);
    [minVFake, lMinInds] = findpeaks(lInv, 'MINPEAKDISTANCE', 30);
    rInv = - rFootPosArray(:, 2);
    [minVFake, rMinInds] = findpeaks(rInv, 'MINPEAKDISTANCE', 30);
    
    frames = sort([lMinInds, rMinInds]);    

end