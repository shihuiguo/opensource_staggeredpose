function [prob, weights] = localMeasure(s, m)

[numFrames, numChannels] = size(m);

numJoints = length(s.tree);

localMotionTrial = cell(numJoints, 1);
jointCurvature = cell(numJoints, 1);
prob = zeros(numFrames, numJoints*2);

windowSize = 5;
b = (1/windowSize)*ones(1,windowSize);
a = 1;


for indJoint = 1 : numJoints    
    rotInds = s.tree(indJoint).rotInd;
    localYaxisArray = zeros(numFrames, 3);
    localZaxisArray = zeros(numFrames, 3);
    if ~isempty(s.tree(indJoint).rotInd)    
        for indFrame = 1 : numFrames
            rotAngles = m(indFrame, rotInds);
            rotMat = rotationMatrix(rotAngles(1), rotAngles(2), rotAngles(3), 'zyx');
            localYaxis = rotMat * [0 1 0]';
            localZaxis = rotMat * [0 0 1]';
            localYaxisArray(indFrame, :) = localYaxis';
            localZaxisArray(indFrame, :) = localZaxis';            
        end    
    end
    localMotionTrial{indJoint} = [localYaxisArray localZaxisArray];
    
    jointCurvature_perJoint = zeros(numFrames, 2);
    
    if ~isempty(s.tree(indJoint).rotInd)            
        [Ty, Ny, By, ky, ty] = frenet(localYaxisArray(:, 1), localYaxisArray(:, 2), localYaxisArray(:, 3));
        [Tz, Nz, Bz, kz, tz] = frenet(localZaxisArray(:, 1), localZaxisArray(:, 2), localZaxisArray(:, 3));
        ky = filter(b, a, ky);
        kz = filter(b, a, kz);
        jointCurvature_perJoint = [ky kz];
    end
    
    jointCurvature{indJoint} = jointCurvature_perJoint;
    prob(:, numJoints*2-1:numJoints*2) = [ky kz];
end

weights = computeLocalWeights(s, localMotionTrial);

end