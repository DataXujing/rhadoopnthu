a.time <- proc.time()
small.ints2=1:100000
result.normal = sapply(small.ints2, function(x) x^2)
proc.time() - a.time

b.time <- proc.time()
small.ints= to.dfs(1:100000)
result = mapreduce(input = small.ints, map = function(k,v)
  cbind(v,v^2))
proc.time() - b.time


rmr.options(backend = 'local')
b.time <- proc.time()
small.ints= to.dfs(1:100000)
result = mapreduce(input = small.ints, map = function(k,v)
  cbind(v,v^2))
proc.time() - b.time


out = mapreduce(to.dfs(1), map = function(k, v)
  rmr.str(v))

small.ints = to.dfs(1:100)
mapr = mapreduce(input = small.ints,
                 map = function(k,v) cbind(v,v^2))
result = from.dfs(mapr)
result


cbind(1:100, 1:100+2)
rbind(1:100, 1:100+2)

data(mtcars)
tapply(mtcars$mpg, mtcars$gear, sum)

#  from dfs to dfs
out = from.dfs(to.dfs(mtcars))
out

# map example
wc.map = function(., row) {    
  keyval(row$gear, row$mpg)}

out = mapreduce(
    input = to.dfs(mtcars),
    map = wc.map
  )

from.dfs(out)

# reduce example
wc.reduce = function(word, val) {    
  keyval(word, sum(val))}


out2 = mapreduce(
  input = to.dfs(mtcars),
  map = wc.map,
  reduce = wc.reduce
)

from.dfs(out2)


# debug example
wc.map = function(., row) {
  rmr.str(row)
  keyval(row$gear, row$mpg)
}

wc.reduce = function(word, val) {    
  keyval(word, sum(val))}

out3 = mapreduce(
  input = to.dfs(mtcars),
  map = wc.map,
  reduce = wc.reduce
)


# debug example2
wc.map = function(., row) {
  keyval(row$gear, row$mpg)
}

wc.reduce = function(word, val) { 
  rmr.str(word)
  rmr.str(val)
  keyval(word, sum(val))}

out4 = mapreduce(
  input = to.dfs(mtcars),
  map = wc.map,
  reduce = wc.reduce
)


#mean example
wc.map = function(., row) {
  keyval(row$gear, row$mpg)
}

wc.reduce = function(word, val) { 
  keyval(word, mean(val))}

out5 = mapreduce(
  input = to.dfs(mtcars),
  map = wc.map,
  reduce = wc.reduce
)
from.dfs(out5)
