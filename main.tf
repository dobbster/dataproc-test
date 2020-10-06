provider "google" {
  project = "broadcom-service-project2"
  region  = "us-west1"
  zone    = "us-west1-b"
}

# Submit an example spark job to a dataproc cluster
resource "google_dataproc_job" "spark" {
  region       = "us-west1"
  force_delete = true
  placement {
    cluster_name = "cluster-f4a8"
  }

  spark_config {
    main_jar_file_uri    = "gs://dataproc-artifactory/hello/target/scala-2.12/HelloWorld.jar"
    //main_class    = "org.apache.spark.examples.SparkPi"
    //jar_file_uris = ["file:///usr/lib/spark/examples/jars/spark-examples.jar"]
    //args          = ["1000"]

    properties = {
      "spark.logConf" = "true"
    }

    logging_config {
      driver_log_levels = {
        "root" = "INFO"
      }
    }
  }
}
