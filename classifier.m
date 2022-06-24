x1 = [1,3,1,2,3,5,7,3,2,5];
x2 = [5,5,3,3,1,3,1,3,1,5];
labels = [1,1,1,1,0,0,0,0,1,1];



n_points = length(labels)

ind1 = find(labels==0);
ind2 = find(labels==1);
plot(x1(ind1),x2(ind1),'bo',x1(ind2),x2(ind2),'rs')
text(x1+0.2,x2, int2str([1:n_points]'));
legend('points from class 0','points from class 1');
title('Press any key ...');
pause

net = newff([-1 7;-1 7],[2 1],{'tansig' 'logsig'}, 'trainlm');

net.trainParam.epochs = 500;
net.trainParam.show = 100;
net.trainParam.goal=0.0000001;

net = init(net);
net = train(net,[x1;x2],labels);
wyjscie = sim(net,[x1;x2]);
y = wyjscie > 0.5;
n_errs = sum(y~=labels)

[X,Y]=meshgrid(-1:0.1:7);
Z=X;
Z(:) = sim(net,[X(:) Y(:)]');

contour(X,Y,Z,[0.499 0.5 0.501]);
hold on
ind1 = find(labels==0);
ind2 = find(labels==1);
plot(x1(ind1),x2(ind1),'bo',x1(ind2),x2(ind2),'rs')
text(x1+0.2,x2, int2str([1:n_points]'));
legend('decision line','points from class 0','points from class 1');
title('2D point classification')
hold off