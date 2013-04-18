clear;
clc;
close all hidden;

%loading data
load fisheriris;

%N:#instances
%M:#attributes
[N M] = size(meas);


%random selection of 70% of the data for training DT
%and the rest for testing DT
ind = randperm(N);

ind_train = ind(1:round(0.7*N));
ind_test = ind(round(0.7*N)+1:end);

X_train = meas(ind_train,:);
Y_train = species(ind_train);

X_test = meas(ind_test,:);
Y_test = species(ind_test);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%training DT
%%%%%%%%%%%%%%%%%%%%%%%%%%
vals = {'Sepal Length', 'Sepal Width', 'Petal Length','Petal Width'};
t = classregtree(X_train,Y_train,'method','classification','names', ...
    vals,'prune','off');
view(t)

%%%%%%%%%%%%%%%%%%%%%%%%%%
%Testing DT
%%%%%%%%%%%%%%%%%%%%%%%%%%
%Training data
Y_predicted_train = eval(t,X_train);
bad = ~strcmp(Y_predicted_train,Y_train);
TrainingErr = sum(bad) / length(ind_train)
 
%Test data
Y_predicted_test = eval(t,X_test);
bad = ~strcmp(Y_predicted_test,Y_test);
TestErr = sum(bad) / length(ind_test)

