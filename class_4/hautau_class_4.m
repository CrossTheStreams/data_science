% Andrew Hautau
% Intro to Data Science
% Class 4 Assignment


% simpleKMeans is a 2D K-means implementation.  
% The function takes points and initial centroids and 
% returns centroids K-mean centroids

function centroids = simpleKMeansFinished(points, centroids)
  
  % Normalization for points and centroids.
  points = normalizePoints(points)
  centroids = normalizeCentroids(centroids, points) 
  clusterIDOld = -1;
  
  for (iter1 = 1:20)
    % For each point find its closest cluster center (centroid)
    clusterID = simpleAssignToCentroids(points, centroids);
  
    % If there was no change in cluster assignments, then stop;
    % Use "break" to break out of the loop
    if (sum(clusterID ~= clusterIDOld) < 2)   
        break;
    end 

    % For each cluster of points determine its centroid
    % The number of clusters is the number of centroids
    centroids = simpleDetermineCentroids(points, clusterID, size(centroids, 1));
    % remember clusterID before clusterID is re-assigned
    clusterIDOld = clusterID;
  end
endfunction

% Normalization for points.

function matrix = normalizePoints(matrix)
  for i = 1:columns(matrix)
    columnMax = max(matrix(:,i))
    columnMin = min(matrix(:,i))
    for n = 1:rows(matrix)
      x = matrix(n,i)
      x = (x - columnMin)/(columnMax - columnMin)
      matrix(n,i) = x
    endfor
  endfor
endfunction 

% Normalization for centroids. There's probably an Octave/MATLAB-esque way to simply do both in a single function, but I'm still learning, so whatevs.

function vector = normalizeCentroids(centroids, points)
  for i = 1:columns(centroids)
    columnMax = max(points(:,i))
    columnMin = min(points(:,i))
    for n = 1:columns(centroids)
      x = centroids(n)
      x = (x - columnMin)/(columnMax - columnMin)
      centroids(n) = x
    endfor
  endfor
endfunction
