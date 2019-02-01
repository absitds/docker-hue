#!/usr/bin/env bash

#Mount Adls gen2
mount_adls_gen2() {

   abfs_uri="${1}"

   mount_point="{$2}"

   mkdir -p ${mount_point}

   /usr/bin/hadoop-fuse-dfs ${abfs_uri} ${mount_point}

}

mount_adls_gen2 ${ABFS_URI} ${AIRFLOW_HOME}

