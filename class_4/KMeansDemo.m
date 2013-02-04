
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function KMeansDemo
close all;
clc;

colorPoint = ['@1o'; '@2o'; '@3o'; '@4o'; '@5o'; '@0o'; '@1o']; % 'b' 'r' 'g' 'b' 'm' 'c'
colorCentroid = ['@1^'; '@2^'; '@3^'; '@4^'; '@5^'; '@0^'; '@1^'];

% Basic parameters for the Algorithm
% number of refinements
IterMax = 10;

%  Get Points and initial centroids
if (1 == 1)
  % In Clustering we need to specify the number of clusters
  numberOfClusters = 3;
  % This describes our space.  The number of columns describes the number of dimensions
  % The top row is the minimal allowed value
  % The bottom row is the maximal allowed value
  dimensionLimits = [-10 -7 0; 3 10 1];
  % Categorical dimensions are encoded as binaries
  % For instance female and male can be encoded as 0 and 1
  % Is the third dimension a categorical (boolean) dimension?
  is3rdDimBool = 1;
  % Max number of points in a cluster
  maxNumberOfPoints = 50;
  % Get data;  In this case we get random data
  % Generally dimensions are normalized.  Otherwise a dimension with large numbers (number of molecules) will overwhelm a dimension with small numbers (number of miles)
  isNormalized = 0;
  points = makePoints(numberOfClusters, dimensionLimits, is3rdDimBool, maxNumberOfPoints, isNormalized);
  % Guess for initial centroids
  centroids = intializeCentroids(numberOfClusters, points);
end % tauto

% Explain Spherical assumption using rectangle example
if (0 == 1)
  points = rectangles; % simplePoints;
  centroids = [0.075, 0.0; 0.7, -0.3];
end % tauto

% Generic example;  Same as simpleKmeans
if (1 == 1)
  points = simplePoints;
  centroids = [0, 0; -1, 0; 0, 1];
end % tauto

% Ridiculous initial value for cluster assignments
clusterID = -1;
%Reassign number of clusters based on number of centroids
numberOfClusters = size(centroids, 1);

% start the figure
figure(17); hold on; % additional graphics will be added to the existing figure
% plot the points
plot(points(:,1), points(:,2), '@0o'); % OCTAVE

for (iter1 = 1:IterMax)
  % Pause for 1 second
  drawnow;
  % disp(' Hit Spacebar to continue '); pause;
  pause(1);

  % plot centroids
  for (iter = 1:numberOfClusters) 
    plot(centroids(iter,1), centroids(iter,2), colorCentroid(iter, :))
  end 
  
  % For each point, find the closest centroid
  clusterIDOld = clusterID;
  clusterID = assignToCentroids(points, centroids);

  % color the points by cluster
  for (iter = 1:numberOfClusters)
          plot(points(clusterID==iter,1), points(clusterID==iter,2), colorPoint(iter, :));
  end
  
  if (sum(clusterID ~= clusterIDOld) < 1)
      convergence = sprintf('Converged in %i iterations.', iter1);
      break;
  else
      convergence = sprintf('Did Not Converge in %i iterations.', iter1);
  end
  
  % compute centroids
  centroidsNew = determineCentroidsOfPoints(points, clusterID, numberOfClusters);

  % Plot the history of the centroids with lines
  for (iter = 1:numberOfClusters)
      plot([centroidsNew(iter, 1) centroids(iter, 1)], [centroidsNew(iter, 2) centroids(iter, 2)], 'k', 'LineWidth', 2);
  end
  title(sprintf(' Iteration %i out of %i ', iter1, IterMax));
  
  centroids = centroidsNew;
end

% Summary as graph title
t = convergence;
for (iter = 1:numberOfClusters)
  numberOfPointsInCluster = sum(clusterID == iter);
  t = [t sprintf('  Cluster #%i has %i points;  ', iter, numberOfPointsInCluster)];
end 
title(t);
hold off;

return % KMeansDemo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial centroids are guesses.  We guess that centroids are close to the center.
function centroids = intializeCentroids(numberOfClusters, points)
centers = repmat(mean(points), numberOfClusters, 1);
deviations = repmat(std(points), numberOfClusters, 1);
centroids = (0.5 - rand(size(deviations))).*deviations + centers;
return % centroids = intializeCentroids(numberOfClusters, points)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function clusterID = assignToCentroids(points, centroids)
numberOfClusters = size(centroids, 1); % number of centroids

m = size(points, 1); % number of points
n = size(points, 2); % dimensionality of point
diff = zeros(n, m, numberOfClusters);
sumDiff2 = zeros(n, m);

for ik = 1:numberOfClusters
  centroidRepeated = repmat(centroids(ik, :)', 1, m);
  diff(:, :, ik) = centroidRepeated - points';
end 

sumDiff2 = sum(diff .^ 2);
sumDiff2b(1:m, 1:numberOfClusters) = sumDiff2(1, 1:m, 1:numberOfClusters);
[bogus, clusterID] = min(sumDiff2b');
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function centroids = determineCentroidsOfPoints(points, clusterID, numberOfClusters)

% Create a matrix where each row is a centroid of n dimensions
numberOfDimensions = size(points, 2);
centroids = zeros(numberOfClusters, numberOfDimensions);

for ik = 1:numberOfClusters
  pointsInTheCluster = points(clusterID == ik, :);
  if(length(pointsInTheCluster) > 0)
      % if the centroid has any nearest points then calculate the mean
      centroids(ik, :) = mean(pointsInTheCluster);
  else
      % If the centroid has no points then assign the mean to NaN
      centroids(ik, :) = NaN;
  end
end 
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

