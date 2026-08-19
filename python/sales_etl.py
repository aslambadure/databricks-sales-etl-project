from pyspark.sql import functions as F

file_path = "/Volumes/workspace/default/sales_volume/databricks_orders_100.csv"

df = (spark.read.option("header","true").option("inferSchema","true").csv(file_path))
print("Source records:", df.count())
display(df)

df.write.format("delta").mode("overwrite").saveAsTable(
    "workspace.sales_project.orders_bronze"
)

bronze_df = spark.table("workspace.sales_project.orders_bronze")

silver_df = (bronze_df
    .dropDuplicates(["order_id"])
    .withColumn("order_date", F.col("order_date").cast("date"))
    .withColumn("quantity", F.col("quantity").cast("int"))
    .withColumn("unit_price", F.col("unit_price").cast("decimal(12,2)"))
    .withColumn("total_amount", F.col("total_amount").cast("decimal(14,2)"))
    .filter(F.col("quantity") > 0)
    .filter(F.col("unit_price") > 0)
    .dropna(subset=["order_id","customer_id","product"])
)
silver_df.write.format("delta").mode("overwrite").saveAsTable(
    "workspace.sales_project.orders_silver"
)

gold_city = silver_df.groupBy("city").agg(
    F.count("*").alias("total_orders"),
    F.sum("quantity").alias("total_quantity"),
    F.sum("total_amount").alias("total_sales")
)
gold_city.write.format("delta").mode("overwrite").saveAsTable(
    "workspace.sales_project.sales_gold_by_city"
)

gold_product = silver_df.groupBy("product").agg(
    F.count("*").alias("total_orders"),
    F.sum("quantity").alias("total_quantity"),
    F.sum("total_amount").alias("total_sales")
)
gold_product.write.format("delta").mode("overwrite").saveAsTable(
    "workspace.sales_project.sales_gold_by_product"
)

for t in ["orders_bronze","orders_silver","sales_gold_by_city","sales_gold_by_product"]:
    print(t, spark.table(f"workspace.sales_project.{t}").count())
