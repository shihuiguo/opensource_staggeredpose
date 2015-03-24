function len = computeTrialLength(trial)

    diffTrial = diff(trial);
    len = sum(sqrt(sum(diffTrial.^2, 2)));

end