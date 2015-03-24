function weights = computeLocalWeights(s, mTrial)

    numJoints = length(s.tree);
    % numFrames = size(mTrial{1}, 1);
    
    weights = zeros(numJoints*2, 1);
    
    for indJoint = 1 : numJoints
        % childrenIDs = s.tree(indJoint).children;
        % numChildren = length(childrenIDs);
        
        % arcLenArray = zeros(numChildren, 1);
        % distArray = zeros(numChildren, 1);
        
        % for indChild = 1 : numChildren
        %   arcLenArray(indChild) = computeTrialLength(mTrial{indJoint});
        %   distArray(indChild) = norm(s.tree(childrenIDs(indChild)).offset);
        % end
        
        arcLenY = computeTrialLength(mTrial{indJoint}(:, 1));
        arcLenZ = computeTrialLength(mTrial{indJoint}(:, 2));
        
        dist = norm(s.tree(indJoint).offset);
        
        weights(indJoint*2-1 : indJoint*2) = dist * [arcLenY arcLenZ];
    end

end