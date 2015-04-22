function eventsInfo = findConstraints(s, m)
    
    
    windowSize = 30;
    threshold = 0.5;
    
    numFrames = size(m, 1);    
    numJoints = length(s.tree);
    xyzMotion = zeros(numFrames, numJoints, 3);

    
    for indFrame = 1 : numFrames        
        xyz = skel2xyz(s, m(indFrame, :));            
        xyzMotion(indFrame, :, :) = xyz;        
    end
    
    eventsInfo = zeros(numFrames, numJoints);
    
    jointList = [6 12];
    
    % for indJoint = 1 : numJoints
    for idx = 1:numel(jointList)
        indJoint = jointList(idx);
        
        indFrame = 1;        
        while indFrame < (numFrames - windowSize)
            startFrame = xyzMotion(indFrame, indJoint, :);
            endFrame = xyzMotion(indFrame + windowSize, indJoint, :);
            
            if (norm(startFrame(:) - endFrame(:)) < threshold)
                eventsInfo(indFrame, indJoint) = 1;
                nextIndFrame = indFrame + windowSize;                
                while (norm(startFrame(:) - endFrame(:)) < threshold)                    
                    nextIndFrame = nextIndFrame + 1;
                    endFrame = xyzMotion(nextIndFrame, indJoint, :);
                end                
                indFrame = nextIndFrame;
            else
                indFrame = indFrame + 1;
            end
            
        end
        
    end

    

end
