%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function points = makePoints(numberOfClusters, dimensionLimits, Dim3Bool, maxNumberOfPoints, isNormalized)
% numberOfClusters is an integer that specifies how many points will be made
% dimensionLimits is an 2 X n matrix where n is the number of dimensions in this space

if (nargin == 0)
    close all
    dimensionLimits = [-10, -10; 10, 10];
    numberOfClusters = 5;
    Dim3Bool = 0;
    maxNumberOfPoints = 50;
end % if

ranges = dimensionLimits(2, :) - dimensionLimits(1, :);
numberOfDimensions = size(ranges, 2);
points = zeros(maxNumberOfPoints*numberOfClusters, numberOfDimensions);

pointsNo = 0;
for (iter1 = 1:numberOfClusters)
    threshold = 0.5;
    clusterOfPoints = zeros(maxNumberOfPoints, numberOfDimensions);
    pointNo = 1;
    for (iter2 = 1:maxNumberOfPoints)
        if (rand > threshold)
            threshold = threshold - 0.5/maxNumberOfPoints; % threshold diminishes
            clusterOfPoints(pointNo, :) = rand(size(ranges)).*ranges + dimensionLimits(1, :);
            if (pointNo == 1)
                firstPoint = clusterOfPoints(pointNo, :);
            end % if
            if (rand < threshold)
                clusterOfPoints(pointNo, :) = mean(clusterOfPoints(1:pointNo, :));
            else
                clusterOfPoints(pointNo, :) = (clusterOfPoints(pointNo, :) + firstPoint)/2;
            end % ifelse
            pointNo = pointNo + 1;
        else
            threshold = threshold + 0.5/maxNumberOfPoints; % threshold increases
        end % if else
    end %for
    pointNo = pointNo - 1;
    points((pointsNo+1):(pointsNo+pointNo), :) = clusterOfPoints(1:pointNo, :);
    pointsNo = pointsNo + pointNo;
end % for iter1

points = points(1:pointsNo, :);

% The 3rd dimension is encoded as a binary
if (Dim3Bool & (numberOfDimensions > 2) )
    minValue = min(min(points(:, 1:2)));
    maxValue = max(max(points(:, 1:2)));
    big = points(:, 3)>mean(points(:, 3));
    points(big, 3) = maxValue;
    points(~big, 3) = minValue;
end % if

% Normalization is important when your dimensions are in different units or types
if (isNormalized)
    pointsStd = std(points);
    pointsMean = mean(points);
    pointsMeanRep = repmat(pointsMean, size(points, 1), 1);
    pointsstdRep = repmat(pointsStd, size(points, 1), 1);
    points = (points - pointsMeanRep)./pointsstdRep;
end % if

if (nargin == 0)
    %plot(initial_centroids(:, 1), initial_centroids(:, 2), 'ro', 'MarkerFaceColor', 'g', 'MarkerSize', 7);
    plot(points(:, 1), points(:, 2), 'mx');
    title(sprintf(' Space contains %i points ', size(points, 1)));
    xlim([dimensionLimits(1, 2) dimensionLimits(2, 2)]);
    ylim([dimensionLimits(1, 1) dimensionLimits(2, 1)]);
end % if

if (nargout == 0)
    points=[];
end % if

return % points = makePoints(numberOfClusters, dimensionLimits, Dim3Bool)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   