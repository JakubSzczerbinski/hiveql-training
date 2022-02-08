#!/bin/bash

HDFS_USER="hive"
HDFS_DIR="/user/hive"

cd tmp
unzip all.zip

echo -- List $HDFS_DIR
hdfs dfs -ls $HDFS_DIR

echo -- Copying data into hdfs:
su $HDFS_USER -c "hdfs dfs -mkdir -p $HDFS_DIR/employee"
su $HDFS_USER -c "hdfs dfs -put employee.csv $HDFS_DIR/employee"

su $HDFS_USER -c "hdfs dfs -mkdir -p $HDFS_DIR/company"
su $HDFS_USER -c "hdfs dfs -put company.csv $HDFS_DIR/company"

su $HDFS_USER -c "hdfs dfs -mkdir -p $HDFS_DIR/exchange"
su $HDFS_USER -c "hdfs dfs -put exchange.csv $HDFS_DIR/exchange"

echo --- List $HDFS_DIR
hdfs dfs -ls $HDFS_DIR

echo -- Load schema
beeline -f schema.sql
