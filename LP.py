import glpk # Import the GLPK module
lp = glpk.LPX() # Create empty problem instance
lp.name = 'sample' # Assign symbolic name to problem
lp.obj.maximize = True # Set this as a maximization problem
lp.rows.add(3) # Append three rows to this instance
for r in lp.rows: # Iterate over all rows
    r.name = chr(ord('p')+r.index) # Name them p, q, and r
lp.rows[0].bounds = None, 100.0 # Set bound -inf < p <= 100
lp.rows[1].bounds = None, 600.0 # Set bound -inf < q <= 600
lp.rows[2].bounds = None, 300.0 # Set bound -inf < r <= 300
lp.cols.add(3) # Append three columns to this instance
for c in lp.cols: # Iterate over all columns
    c.name = 'x%d' % c.index
    c.bounds = 0.0, None
lp.obj[:] = [10.0, 6.0, 4.0]
lp.matrix = [1.0, 1.0, 1.0, 10.0, 4.0, 5.0, 2.0, 2.0, 6.0]
lp.simplex()
print ('Z = %g;' % lp.obj.value,)
print ('; '.join('%s = %g' % (c.name, c.primal) for c in lp.cols ))