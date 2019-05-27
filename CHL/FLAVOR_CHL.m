%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% MATLAB code for FLAVOR method %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The inputs of the neural network are:
% 10 points of the normalized fluorescence profile, depth Z0, location and date (5 values), dimensionless depth (eta) of the output
% The output of the neural network is:
% chlorophyll-a concentration for the depth eta defined in input

% The input file must be a mxn format with m, the number of examples and n=17 (inputs)

clear all;
close all;

temporaire=fopen('FLAVOR_CHL_weight_17x7x7x1.sn','r');
fgetl(temporaire);
poids=fscanf(temporaire,'%f',[3 inf]);
poids=poids';
poids=poids(:,3);
fclose(temporaire);

% Number of hidden layers
%nc=input('Number of hidden layers:\n');
nc=2;

% Number of neurons for each layer 

% Number of inputs
%ne=input('Number of inputs:\n');
ne=17;
 
% Number of neurons of the first hidden layer
%nc1=input('Number of neurons of the first hidden layer:\n');
nc1=7;

% Number of neurons of the second hidden layer
%nc2=input('Number of neurons of the second hidden layer:\n');
nc2=7;

% Number of outputs
%ns=input('Number of outputs:\n');
ns=1;

% Definition of the size of the weights and biases parameters files
b1=ones(nc1,1);
b2=ones(ns,1);
b3=ones(nc2,1);

w1=ones(nc1,ne);
w2c1=ones(ns,nc1);
w2c2=ones(ns,nc2);
w3=ones(nc2,nc1);

% WEIGHT PARAMETERS   
   % weight and bias from the input layer to the first hidden layer w1, b1
  
     for j=1:nc1
         b1(j)=poids(j);
     end    
     
     k=nc1+nc2+ns+1;
     for i=1:ne
         for j=1:nc1
             w1(j,i)=poids(k);
            k=k+1;
         end    
     end

   % weight and bias from the first hidden layer to the second hidden layer

     for j=nc1+1:nc1+nc2
	 b3(j-nc1)=poids(j);
     end

     for i=1:nc1
         for j=1:nc2
             w3(j,i)=poids(k);
	    k=k+1;
	 end
     end

   % weight and bias from the second hidden layer to the output layer w3, b3    
 
        for j=nc1+nc2:nc1+nc2+ns
            b2(ns)=poids(j);
        end
   
 
      for j=1:nc2
        for i=1:ns
            w2c2(i,j)=poids(k);
            k=k+1;
        end
      end

%%% Mean and standard deviation of the training dataset
%%% These values are used to normalize the inputs parameters

Moy=load('Mean_Training_FLAVOR_CHL.dat');
Ecart=load('Std_Training_FLAVOR_CHL.dat');

%%% DATA is the user's input file

data=load('validation_dataset_chl.dat');
%data=load('profil_input.dat');

%% NORMALISATION OF THE INPUT PARAMETERS

data_N = data(:,1:ne);
col=[1:11 17];
for i=1:12
	data_N(:,col(i))=(2/3)*((data(:,col(i))-Moy(i))/Ecart(i));
end

% Two hidden layers

[rx,cx]=size(data_N);
a=1.715905*tanh((2./3)*(data_N*w1'+(b1*ones(1,rx))'));
b=1.715905*tanh((2./3)*(a*w3'+(b3*ones(1,rx))')); % two hidden layer output

y=b*w2c2'+(b2*ones(1,rx))';

%% Y is the output values of the neural network, 

%% Denormalisation of the output of the NN for getting the true value of
%% CHL
Estimated_CHL=10.^(1.5*y*Ecart(13)+Moy(13));

%save CHL_mlp.dat Estimated_CHL -ascii

%% To check if everything is ok
%Desired_CHL=10.^(data(:,18));
%plot(Desired_CHL,Estimated_CHL);
