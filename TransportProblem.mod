
/* number of production site */
param m, integer, > 0;

/* number of warehouse */
param n, integer, > 0;

/* set of productions for each site */
set I := 1..m;

/* set of warehouse */
set J := 1..n;

/* cost of sending i to j */
param c{i in I, j in J}, >= 0;

param p{i in I}, >= 0;
param w{j in J}, >= 0;

/* x[i,j] = 1 means task j is assigned to agent i
   note that variables x[i,j] are binary, however, there is no need to
   declare them so due to the totally unimodular constraint matrix */
var x{i in I, j in J}, integer, >= 0;

/* each agent can perform at most one task */
s.t. wareCon{i in I}: sum{j in J} x[i, j] <= p[i];
s.t. prodCon{j in J}: sum{i in I} x[i, j] >= w[j];


minimize obj: sum{i in I, j in J} c[i,j] * x[i,j];
/* the objective is to find a cheapest assignment */

solve;

printf "Solution\n";
for {i in I}
{
    printf {j in J} '%14s', x[i,j];
    printf "\n";
}

printf "\nFinal cost: %g\n", sum{i in I, j in J} c[i, j]*x[i, j];
printf "\n";

data;

/* These data correspond to an example from [Christofides]. */

/* Optimal solution is 76 */

param m := 3;

param n := 4;

param : p :=
    1 75
    2 125
    3 100
;

param : w :=
    1 80
    2 65
    3 70
    4 85;

param c : 1 2 3 4 :=
      1 464 513 654 867
      2 352 416 690 791
      3 995 682 388 685;

end;
