function updateProgress(currentIndex, totalTires, progressBarWidth)
    progressPercent = currentIndex / totalTires * 100;
    numDots = floor(progressPercent / 100 * progressBarWidth);
    fprintf('\r[%-30s] %d%% Completed', repmat('~', 1, numDots), progressPercent);
end