% simpleKMeans is a 2D K-means implementation.  
% The function takes points and initial centroids and 
% returns centroids K-mean centroids
function centroids = simpleKMeans(points, centroids)
% Get rediculous values for the initial cluster ids
clusterIDOld = -1;

normalize = 1;

if (normalize)
    % Parameters for normalization and denormalization
    minPoint = min(points);
    maxPoint = max(points);
    range = maxPoint - minPoint;
    
    % Normalize points
    numberOfPoints = size(points, 1);
    % for each point subtract away its minimum and then divide by the range
    for (pointNo = 1:numberOfPoints)
        points(pointNo, :) = (points(pointNo, :) - minPoint)./range;
        % y                   = (x                    -  m)   / r
    end
    
    % Normalize Centroids
    numberOfCentroids = size(centroids, 1);
    % for each point subtract away its minimum and then divide by the range
    for (centroidNo = 1:numberOfCentroids)
        centroids(centroidNo, :) = (centroids(centroidNo, :) - minPoint)./range;
        % y                   = (x                    -  m)   / r
    end
end % normalize

% repeat the following processes using a loop.  Use a for loop to prevent infinite loops
for (iter1 = 1:20)
    % For each point find its closest cluster center (centroid)
    clusterID = simpleAssignToCentroids(points, centroids);
    % If there was no change in cluster assignments, then stop;  Use "break" to break out of the loop
    if (sum(clusterID ~= clusterIDOld) < 1)   
        break;
    end % if
    % For each cluster of points determine its centroid;  The number of clusters is the number of centroids
    centroids = simpleDetermineCentroids(points, clusterID, size(centroids, 1));
    % remember clusterID before clusterID is re-assigned
    clusterIDOld = clusterID;
    % end the for loop
end % for

if (normalize)
    % Denormalization
    % for each point mutiply by range and then add minimum
    for (centroidNo = 1:numberOfCentroids)
        centroids(centroidNo, :) = range.*centroids(centroidNo, :) + minPoint;
        % x                   =      r    *  x                     + m
    end
end % normalize

% End the function
return