function clusterID = simpleAssignToCentroids(points, centroids)
% Get the number of centroids
numberOfClusters = size(centroids, 1);
% Get the number of points
numberOfPoints = size(points, 1);
% Make a matrix where each row is for one point and each column for one cluster
% This matrix is used to compare distances from each point to each cluster
sumDiff2 = zeros(numberOfPoints, numberOfClusters);

% Repeat for each cluster
for clusterNo = 1:numberOfClusters
    % Repeat the centroid of the cluster for each point (vectorization)
    centroidRepeated = repmat(centroids(clusterNo, :), numberOfPoints, 1);
    % Determine the distance from the centroid to each point
    diff = centroidRepeated - points;
    % Determine the difference squared
    diff2 = diff.*diff;
    % Populate the distance-squared matrix
    sumDiff2(:, clusterNo) = sum(diff2, 2);
end % for

% For each point, determine the minimum distance and get the
% index of the column.  The index is the cluster number.
[bogus, clusterID] = min(sumDiff2');
return