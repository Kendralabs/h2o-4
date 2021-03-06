setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../../h2o-r/scripts/h2o-r-test-setup.R")
#----------------------------------------------------------------------
# Purpose:  This test exercises HDFS operations from R.
#----------------------------------------------------------------------

hdfs_name_node <-HADOOP.NAMENODE
hdfs_iris_file <- "/datasets/runit/iris_wheader.csv"
hdfs_iris_dir <- "/datasets/runit/iris_test_train"

#----------------------------------------------------------------------

heading("BEGIN TEST")
check.hdfs_basic <- function() {
  #----------------------------------------------------------------------
  # Single file cases.
  #----------------------------------------------------------------------

  heading("Testing single file importHDFS")
  url <- sprintf("hdfs://%s%s", hdfs_name_node, hdfs_iris_file)
  iris.hex <- h2o.importFile(url)
  head(iris.hex)
  tail(iris.hex)
  n <- nrow(iris.hex)
  print(n)
  if (n != 150) {
      stop("nrows is wrong")
  }
  if (class(iris.hex) != "H2OFrame") {
      stop("iris.hex is the wrong type")
  }
  print ("Import worked")

  #----------------------------------------------------------------------
  # Directory file cases.
  #----------------------------------------------------------------------

  heading("Testing directory importHDFS")
  url <- sprintf("hdfs://%s%s", hdfs_name_node, hdfs_iris_dir)
  iris.dir.hex <- h2o.importFile(url)
  head(iris.dir.hex)
  tail(iris.dir.hex)
  n <- nrow(iris.dir.hex)
  print(n)
  if (n != 150) {
      stop("nrows is wrong")
  }
  if (class(iris.dir.hex) != "H2OFrame") {
      stop("iris.dir.hex is the wrong type")
  }
  print ("Import worked")
}

doTest("HDFS operations", check.hdfs_basic)
