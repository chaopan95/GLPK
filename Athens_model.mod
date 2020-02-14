########################################################
####### ATHENS - GRAPH COLORING FOR AN ASSIGNMENT PROBLEM ###########
########################################################

param nbTasks := 10;
#param nbTasks := 40;
#param nbTasks := 100;

param nbMaxColors := nbTasks;

set I := {1..nbTasks};
set J := {1..nbTasks};

param matI{I,J};

### 1. Variables ###

#Assignment variables
var x{1..nbTasks,1..nbMaxColors}, binary;

#Color variables
var c{1..nbMaxColors}, binary;

### 2. Constraints ###

#Color constraint : link assignment variables to color variables
s.t. colorConstraint1{i in 1..nbTasks, j in 1..nbMaxColors}:
	c[j] >= x[i,j];

#Color constraint : An other way to model this constraint : 
#s.t. colorConstraint2{j in 1..nbTasks}:
#	c[j] >= 1/nbTasks * sum{i in 1..nbTasks} x[i,j];

#Assignment constraint : every task has to be covered by one and only one crew member
s.t. assignmentConstraint{i in 1..nbTasks}:
	sum{j in 1..nbMaxColors} x[i,j] = 1;

#Intersection constraint : 2 tasks that intersect can't be assign to the same crew member
s.t. intersectionConstraint{i in 1..nbTasks, k in 1..nbTasks, j in 1..nbMaxColors : matI[i,k]==1}:
	x[i,j] + x[k,j] <= 1;

#Color ordering constraint : chose colors in increasing order (what matters is not which colors are chosen by the solver
#but the number of colors used). 
#This constraint is not a mandatory one, it is just a guide for the solver, it's break symetries
#There are many ways to express this constraint.

#s.t. orderingColorConstraint1{i in 1..nbMaxColors, j in 1..nbMaxColors : j > i}:
#	c[i] >= c[j];

#s.t. orderingColorConstraint2{i in 2..nbMaxColors}:
#	 c[i] <= c[i-1];

s.t. orderingColorConstraint3{i in 2..nbTasks}:
	c[i] <= 1/(i-1)*(sum{j in 1..i-1} c[j]);

### 3. Objective function ###

minimize obj: 
	sum{j in 1..nbMaxColors} c[j];

#printf sum{j in 1..nbMaxColors} c[j];

data;

param matI :
	1	2	3	4	5	6	7	8	9	10:=
1	0	1	0	0	0	0	0	0	0	0
2	1	0	0	0	0	0	0	0	0	0
3	0	0	0	0	0	0	0	0	0	0
4	0	0	0	0	0	0	0	0	0	0
5	0	0	0	0	0	1	0	0	0	0
6	0	0	0	0	1	0	1	0	0	0
7	0	0	0	0	0	1	0	0	0	0
8	0	0	0	0	0	0	0	0	1	0
9	0	0	0	0	0	0	0	1	0	1
10	0	0	0	0	0	0	0	0	1	0
;

end;
