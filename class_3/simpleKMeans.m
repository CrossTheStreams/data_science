% simpleKMeans is a 2D K-means implementation.  
% The function takes points and initial centroids and 
% returns centroids K-mean centroids

function centroids = simpleKMeans(points, centroids);
% Get rediculous values for the initial cluster ids
clusterID = -1;
clusterID_old = clusterID;

% repeat the following processes using a loop.  Use a for loop to prevent infinite loops
for (iter = 1:10)

    % For each point find its closest cluster center (centroid)
    centroids = simpleDetermineCentroids(points,clusterID,numberOfClusters);

    % If there was no change in cluster assignments, then stop;
    % Use "break" to break out of the loop
    if (clusterID == clusterID_old)
      break;
    end
    % For each cluster of points determine its centroid;  
    centroids = simpleDetermineCentroids(points, clusterID, size(centroids, 1)
    % The number of clusters is the number of centroids
    clusterID_old = clusterID;
    % Remember clusterID before clusterID is re-assigned
end
    % End the for loop
return
% End the function
