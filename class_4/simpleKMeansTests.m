function simpleKMeansTests
clc
points = simplePoints;
centroids = [0, 0; -1, 0; 0, 1];
disp(' ');
disp(' -------------------------------------------- ');
disp(' -------------------------------------------- ');
disp(' ');
disp( 'The following are standard results:');
centroids = simpleKMeans(points, centroids)
% centroids:
% 0.025200  -0.586800
%-1.466500  -1.043000
% 0.756316   0.935000
disp(' ');
disp(' -------------------------------------------- ');
disp(' ');
disp(' These results are the same as above.');
disp(' Inputs were scaled up and the results were scaled back down:');
centroids = simpleKMeans(2*points, 2*centroids)/2
% centroids:
% 0.025200  -0.586800
%-1.466500  -1.043000
% 0.756316   0.935000
disp(' ');
disp(' -------------------------------------------- ');
disp(' ');
disp(' The following results are the same as above even though');
disp(' the centroids were differnt (just lucky):');
centroids = simpleKMeans(points, centroids/2)
% centroids:
% 0.025200  -0.586800
%-1.466500  -1.043000
% 0.756316   0.935000
disp(' ');
disp(' -------------------------------------------- ');
disp(' ');
disp(' The following results are similar but not the same as above.');
disp(' K-means is not deterministic!');
disp(' Different centroids may lead to different results:');
centroids = simpleKMeans(points, 2*centroids)
% centroids:
%-0.0515   -0.6012
%-1.5163   -1.0058
% 0.7945    0.9142
% Siimilar but not the same
disp(' ');
disp(' -------------------------------------------- ');
disp(' ');
disp(' The following are standard results for 5 cclusters');
disp(' Different number of centroids may lead to different results:');
centroids=[0, 0; -1, 0; 0, 1; 0 -1; 1 0];
centroids = simpleKMeans(points, centroids)
% centroids:
%-0.1668   -0.3750
%-1.6035   -0.8888
% 0.7015    1.0748
%-0.0933   -1.7517
% 1.1445    0.4409
disp(' ');
disp(' -------------------------------------------- ');
