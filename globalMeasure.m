function prob = globalMeasure(s, m)

    frames = findConstraints(s, m);
    numFrames = size(m, 1);
    prob = zeros(numFrames, 1);
    prob(frames) = 1;
end