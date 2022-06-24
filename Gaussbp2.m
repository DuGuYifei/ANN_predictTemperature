% Gauss function approximation 

% generating the Gaussian and the training points
x=-4:0.4:4;
xx=-4:0.05:4;
sigma=1;



% the training points are marked with circles
f=(1/(sqrt(2*pi)*sigma))*exp(-x.^(2)/(2*sigma^(2)));
plot(x,f,'o');

% the actual Gaussian is drawn in the same figure
hold on
ff=(1/(sqrt(2*pi)*sigma))*exp(-xx.^(2)/(2*sigma^(2)));
plot(xx,ff);

hold off
pause
close

I = [min(x) max(x)];

net = newff(I,[50 1],{'tansig','purelin'},'trainlm');
net.trainParam.epochs = 8000;
net.trainParam.goal = 0.0000001;

net = init(net);
net = train(net,x,f);

y = sim(net, xx);
plot(xx,y, 'r');