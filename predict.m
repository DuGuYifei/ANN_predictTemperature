clear

%function plot data - 221 samples
x=(-3:.05:8);   
y=0.5*sin(10*x)+0.5*cos(2*x);

%training set - 20 inputs (window width is 20), 100 samples
I = zeros(20,2);
minn = min(y);
maxn = max(y);
for i = 1:20
    I(i,1) = minn;
    I(i,2) = maxn;
end
X = zeros(20,100);
for i = 1:100
    for j = 1:20
        X(j, i) = y(i+j-1);
    end
end

f = zeros(1,100);
for i = 1:100
    f(i) = y(i+20);
end

net = newff(I,[10 1],{'tansig','purelin'},'trainlm');
net.trainParam.epochs = 8000;
net.trainParam.goal = 0.0000001;

net = init(net);
net = train(net,X,f);


%the original plot
plot(x(21:220),y(21:220))
hold on

%testing should be performed for all 221 samples
%ff = zeros(1,120);
ny = y;
for i = 101:220
    test = ny((i-20):(i-1));
    test_list = test';
    ff = sim(net,test_list);
    ny(i) = ff;
end

plot(x(101:220), ny(101:220), 'r');
hold off


