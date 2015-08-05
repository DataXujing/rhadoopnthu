map <- function(.,lines) {
  keyval(
    unlist(
      strsplit(
        x = lines,
        split = " +")),
    1)}

#original
lines = 'car car river      qoo oop              qoo car river oop'
split_lines = strsplit(lines, split=" +")
tokens= unlist(split_lines)
kv = keyval(tokens, 1)

#one line code
keyval(unlist(strsplit(lines, split= ' +')), 1)

map(NULL, lines)


reduce <- function(word, counts) {
  keyval(word, sum(counts))
}


reduce("car", c(1,1,1))



hdfs.root = '/user/user50/wordcount'
hdfs.data = file.path(hdfs.root, 'data')
hdfs.out = file.path(hdfs.root, 'out2')
wordcount = function (input, output=NULL) {
  mapreduce(input=input, output=output,
            input.format="text", map=map, reduce=reduce)
}

out = wordcount(hdfs.data, hdfs.out)



results = from.dfs(out)