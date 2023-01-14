function [number_of_objectives, number_of_decision_variables, min_range_of_decesion_variable,...
    max_range_of_decesion_variable] = objective_description()
%{ 
    Return:
    number_of_objectives : The number of objective functions
    number_of_decision_variables : The number of decision variables
    min_range_of_decesion_variable : The lower bound of decision variables
    max_range_of_decesion_variable : The upper bound of decision variables
 %}

%get the number of objective functions
% number_of_objectives = input('\nInput the number of objectives: '); 
% here we only consider 2 objective functions

% if number_of_objectives < 2
%     error('This is a multi-objective optimization function hence the minimum number of objectives is two');
% end

number_of_objectives = 2;


global VArraysum;                 

clc

% set the bounds of decision variables
min_range_of_decesion_variable(1:VArraysum)=1;
max_range_of_decesion_variable(1:VArraysum)=VArraysum;

min_range_of_decesion_variable(VArraysum+1:VArraysum*2)=0;
max_range_of_decesion_variable(VArraysum+1:VArraysum*2)=1;

min_range_of_decesion_variable(VArraysum*2+1:VArraysum*3)=1;
max_range_of_decesion_variable(VArraysum*2+1:VArraysum*3)=3;

number_of_decision_variables = VArraysum*3;
