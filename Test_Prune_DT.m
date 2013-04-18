clear;
clc;
close all hidden;

%loading data
load fisheriris;
load ind_overfit;
vals = {'Sepal Length', 'Sepal Width', 'Petal Length','Petal Width'};

%N:#instances
%M:#attributes
[N M] = size(meas);


%random selection of 50% of the data for training DT
%and the rest for testing DT
ind_train = ind(1:round(0.5*N));
ind_test = ind(round(0.5*N)+1:end);

X_train = meas(ind_train,:);
Y_train = species(ind_train);

X_test = meas(ind_test,:);
Y_test = species(ind_test);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%training DT
%%%%%%%%%%%%%%%%%%%%%%%%%%
t = classregtree(X_train,Y_train,'method','classification','names', ...
    vals,'prune','off','splitmin',5);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pruning DT
%%%%%%%%%%%%%%%%%%%%%%%%%%
t_pruned = prune(t,'level',2);
view(t_pruned)

%%%%%%%%%%%%%%%%%%%%%%%%%%
%Testing pruned DT
%%%%%%%%%%%%%%%%%%%%%%%%%%
%Training data
Y_predicted_train = eval(t_pruned,X_train);
bad = ~strcmp(Y_predicted_train,Y_train);
TrainingErr_pruned = sum(bad) / length(ind_train);
 
%Test data
Y_predicted_test = eval(t_pruned,X_test);
bad = ~strcmp(Y_predicted_test,Y_test);
TestErr_pruned = sum(bad) / length(ind_test);

disp(['Training Error: Before Pruning = ',num2str(TrainingErr),'     After pruning=',num2str(TrainingErr_pruned)])
disp(['Test Error: Before Pruning = ',num2str(TestErr),'         After pruning=',num2str(TestErr_pruned)])