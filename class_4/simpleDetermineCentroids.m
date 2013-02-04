function centroids = simpleDetermineCentroids(points, clusterID, numberOfClusters)
% Create a matrix where each row is a centroid of 2 dimensions
% Initially the values will be zeros
centroids = zeros(numberOfClusters, 2);

% Loop through each cluster
for ik = 1:numberOfClusters
    % Get only the points from one cluster (ik)
    pointsInTheCluster = points(clusterID == ik, :);
    % Determine the mean of that cluster
    centroids(ik, :) = mean(pointsInTheCluster);
end % for
return