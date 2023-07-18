#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0
#
# Environment configuration for opensearch

# The values for all environment variables will be set in the below order of precedence
# 1. Custom environment variables defined below after Bitnami defaults
# 2. Constants defined in this file (environment variables with no default), i.e. BITNAMI_ROOT_DIR
# 3. Environment variables overridden via external files using *_FILE variables (see below)
# 4. Environment variables set externally (i.e. current Bash context/Dockerfile/userdata)

# Load logging library
# shellcheck disable=SC1090,SC1091
. /opt/bitnami/scripts/liblog.sh

export BITNAMI_ROOT_DIR="/opt/bitnami"
export BITNAMI_VOLUME_DIR="/bitnami"

# Logging configuration
export MODULE="${MODULE:-opensearch}"
export BITNAMI_DEBUG="${BITNAMI_DEBUG:-false}"

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
opensearch_env_vars=(
    OPENSEARCH_CERTS_DIR
    OPENSEARCH_DATA_DIR_LIST
    OPENSEARCH_BIND_ADDRESS
    OPENSEARCH_ADVERTISED_HOSTNAME
    OPENSEARCH_CLUSTER_HOSTS
    OPENSEARCH_CLUSTER_MASTER_HOSTS
    OPENSEARCH_CLUSTER_NAME
    OPENSEARCH_HEAP_SIZE
    OPENSEARCH_MAX_ALLOWED_MEMORY_PERCENTAGE
    OPENSEARCH_MAX_ALLOWED_MEMORY
    OPENSEARCH_MAX_TIMEOUT
    OPENSEARCH_LOCK_ALL_MEMORY
    OPENSEARCH_DISABLE_JVM_HEAP_DUMP
    OPENSEARCH_DISABLE_GC_LOGS
    OPENSEARCH_IS_DEDICATED_NODE
    OPENSEARCH_MINIMUM_MASTER_NODES
    OPENSEARCH_NODE_NAME
    OPENSEARCH_FS_SNAPSHOT_REPO_PATH
    OPENSEARCH_NODE_ROLES
    OPENSEARCH_PLUGINS
    OPENSEARCH_TRANSPORT_PORT_NUMBER
    OPENSEARCH_HTTP_PORT_NUMBER
    OPENSEARCH_ENABLE_SECURITY
    OPENSEARCH_PASSWORD
    OPENSEARCH_TLS_VERIFICATION_MODE
    OPENSEARCH_TLS_USE_PEM
    OPENSEARCH_KEYSTORE_PASSWORD
    OPENSEARCH_TRUSTSTORE_PASSWORD
    OPENSEARCH_KEY_PASSWORD
    OPENSEARCH_KEYSTORE_LOCATION
    OPENSEARCH_TRUSTSTORE_LOCATION
    OPENSEARCH_NODE_CERT_LOCATION
    OPENSEARCH_NODE_KEY_LOCATION
    OPENSEARCH_CA_CERT_LOCATION
    OPENSEARCH_SKIP_TRANSPORT_TLS
    OPENSEARCH_TRANSPORT_TLS_USE_PEM
    OPENSEARCH_TRANSPORT_TLS_KEYSTORE_PASSWORD
    OPENSEARCH_TRANSPORT_TLS_TRUSTSTORE_PASSWORD
    OPENSEARCH_TRANSPORT_TLS_KEY_PASSWORD
    OPENSEARCH_TRANSPORT_TLS_KEYSTORE_LOCATION
    OPENSEARCH_TRANSPORT_TLS_TRUSTSTORE_LOCATION
    OPENSEARCH_TRANSPORT_TLS_NODE_CERT_LOCATION
    OPENSEARCH_TRANSPORT_TLS_NODE_KEY_LOCATION
    OPENSEARCH_TRANSPORT_TLS_CA_CERT_LOCATION
    OPENSEARCH_ENABLE_REST_TLS
    OPENSEARCH_HTTP_TLS_USE_PEM
    OPENSEARCH_HTTP_TLS_KEYSTORE_PASSWORD
    OPENSEARCH_HTTP_TLS_TRUSTSTORE_PASSWORD
    OPENSEARCH_HTTP_TLS_KEY_PASSWORD
    OPENSEARCH_HTTP_TLS_KEYSTORE_LOCATION
    OPENSEARCH_HTTP_TLS_TRUSTSTORE_LOCATION
    OPENSEARCH_HTTP_TLS_NODE_CERT_LOCATION
    OPENSEARCH_HTTP_TLS_NODE_KEY_LOCATION
    OPENSEARCH_HTTP_TLS_CA_CERT_LOCATION
    OPENSEARCH_SECURITY_DIR
    OPENSEARCH_SECURITY_CONF_DIR
    OPENSEARCH_DASHBOARDS_PASSWORD
    LOGSTASH_PASSWORD
    OPENSEARCH_SET_CGROUP
    OPENSEARCH_SECURITY_BOOTSTRAP
    OPENSEARCH_SECURITY_NODES_DN
    OPENSEARCH_SECURITY_ADMIN_DN
    OPENSEARCH_SECURITY_ADMIN_CERT_LOCATION
    OPENSEARCH_SECURITY_ADMIN_KEY_LOCATION
    DB_MINIMUM_MANAGER_NODES
    KIBANA_PASSWORD
)
for env_var in "${opensearch_env_vars[@]}"; do
    file_env_var="${env_var}_FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            warn "Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done
unset opensearch_env_vars
export DB_FLAVOR="opensearch"

# Paths
export OPENSEARCH_VOLUME_DIR="/bitnami/opensearch"
export DB_VOLUME_DIR="$OPENSEARCH_VOLUME_DIR"
export OPENSEARCH_BASE_DIR="/opt/bitnami/opensearch"
export DB_BASE_DIR="$OPENSEARCH_BASE_DIR"
export OPENSEARCH_CONF_DIR="${DB_BASE_DIR}/config"
export DB_CONF_DIR="$OPENSEARCH_CONF_DIR"
export OPENSEARCH_CERTS_DIR="${OPENSEARCH_CERTS_DIR:-${DB_CONF_DIR}/certs}"
export DB_CERTS_DIR="$OPENSEARCH_CERTS_DIR"
export OPENSEARCH_LOGS_DIR="${DB_BASE_DIR}/logs"
export DB_LOGS_DIR="$OPENSEARCH_LOGS_DIR"
export OPENSEARCH_PLUGINS_DIR="${DB_BASE_DIR}/plugins"
export DB_PLUGINS_DIR="$OPENSEARCH_PLUGINS_DIR"
export OPENSEARCH_DATA_DIR="${DB_VOLUME_DIR}/data"
export DB_DATA_DIR="$OPENSEARCH_DATA_DIR"
export OPENSEARCH_DATA_DIR_LIST="${OPENSEARCH_DATA_DIR_LIST:-}"
export DB_DATA_DIR_LIST="$OPENSEARCH_DATA_DIR_LIST"
export OPENSEARCH_TMP_DIR="${DB_BASE_DIR}/tmp"
export DB_TMP_DIR="$OPENSEARCH_TMP_DIR"
export OPENSEARCH_BIN_DIR="${DB_BASE_DIR}/bin"
export DB_BIN_DIR="$OPENSEARCH_BIN_DIR"
export OPENSEARCH_MOUNTED_PLUGINS_DIR="${DB_VOLUME_DIR}/plugins"
export DB_MOUNTED_PLUGINS_DIR="$OPENSEARCH_MOUNTED_PLUGINS_DIR"
export OPENSEARCH_CONF_FILE="${DB_CONF_DIR}/opensearch.yml"
export DB_CONF_FILE="$OPENSEARCH_CONF_FILE"
export OPENSEARCH_LOG_FILE="${DB_LOGS_DIR}/opensearch.log"
export DB_LOG_FILE="$OPENSEARCH_LOG_FILE"
export OPENSEARCH_PID_FILE="${DB_TMP_DIR}/opensearch.pid"
export DB_PID_FILE="$OPENSEARCH_PID_FILE"
export OPENSEARCH_INITSCRIPTS_DIR="/docker-entrypoint-initdb.d"
export DB_INITSCRIPTS_DIR="$OPENSEARCH_INITSCRIPTS_DIR"
export PATH="${DB_BIN_DIR}:${BITNAMI_ROOT_DIR}/common/bin:$PATH"

# System users (when running with a privileged user)
export OPENSEARCH_DAEMON_USER="opensearch"
export DB_DAEMON_USER="$OPENSEARCH_DAEMON_USER"
export OPENSEARCH_DAEMON_GROUP="opensearch"
export DB_DAEMON_GROUP="$OPENSEARCH_DAEMON_GROUP"

# Opensearch configuration
export OPENSEARCH_BIND_ADDRESS="${OPENSEARCH_BIND_ADDRESS:-}"
export DB_BIND_ADDRESS="$OPENSEARCH_BIND_ADDRESS"
export OPENSEARCH_ADVERTISED_HOSTNAME="${OPENSEARCH_ADVERTISED_HOSTNAME:-}"
export DB_ADVERTISED_HOSTNAME="$OPENSEARCH_ADVERTISED_HOSTNAME"
export OPENSEARCH_CLUSTER_HOSTS="${OPENSEARCH_CLUSTER_HOSTS:-}"
export DB_CLUSTER_HOSTS="$OPENSEARCH_CLUSTER_HOSTS"
export OPENSEARCH_CLUSTER_MASTER_HOSTS="${OPENSEARCH_CLUSTER_MASTER_HOSTS:-}"
export DB_CLUSTER_MASTER_HOSTS="$OPENSEARCH_CLUSTER_MASTER_HOSTS"
export OPENSEARCH_CLUSTER_NAME="${OPENSEARCH_CLUSTER_NAME:-}"
export DB_CLUSTER_NAME="$OPENSEARCH_CLUSTER_NAME"
export OPENSEARCH_HEAP_SIZE="${OPENSEARCH_HEAP_SIZE:-1024m}"
export DB_HEAP_SIZE="$OPENSEARCH_HEAP_SIZE"
export OPENSEARCH_MAX_ALLOWED_MEMORY_PERCENTAGE="${OPENSEARCH_MAX_ALLOWED_MEMORY_PERCENTAGE:-100}"
export DB_MAX_ALLOWED_MEMORY_PERCENTAGE="$OPENSEARCH_MAX_ALLOWED_MEMORY_PERCENTAGE"
export OPENSEARCH_MAX_ALLOWED_MEMORY="${OPENSEARCH_MAX_ALLOWED_MEMORY:-}"
export DB_MAX_ALLOWED_MEMORY="$OPENSEARCH_MAX_ALLOWED_MEMORY"
export OPENSEARCH_MAX_TIMEOUT="${OPENSEARCH_MAX_TIMEOUT:-60}"
export DB_MAX_TIMEOUT="$OPENSEARCH_MAX_TIMEOUT"
export OPENSEARCH_LOCK_ALL_MEMORY="${OPENSEARCH_LOCK_ALL_MEMORY:-no}"
export DB_LOCK_ALL_MEMORY="$OPENSEARCH_LOCK_ALL_MEMORY"
export OPENSEARCH_DISABLE_JVM_HEAP_DUMP="${OPENSEARCH_DISABLE_JVM_HEAP_DUMP:-no}"
export DB_DISABLE_JVM_HEAP_DUMP="$OPENSEARCH_DISABLE_JVM_HEAP_DUMP"
export OPENSEARCH_DISABLE_GC_LOGS="${OPENSEARCH_DISABLE_GC_LOGS:-no}"
export DB_DISABLE_GC_LOGS="$OPENSEARCH_DISABLE_GC_LOGS"
export OPENSEARCH_IS_DEDICATED_NODE="${OPENSEARCH_IS_DEDICATED_NODE:-no}"
export DB_IS_DEDICATED_NODE="$OPENSEARCH_IS_DEDICATED_NODE"
OPENSEARCH_MINIMUM_MASTER_NODES="${OPENSEARCH_MINIMUM_MASTER_NODES:-"${DB_MINIMUM_MANAGER_NODES:-}"}"
export OPENSEARCH_MINIMUM_MASTER_NODES="${OPENSEARCH_MINIMUM_MASTER_NODES:-}"
export DB_MINIMUM_MASTER_NODES="$OPENSEARCH_MINIMUM_MASTER_NODES"
export OPENSEARCH_NODE_NAME="${OPENSEARCH_NODE_NAME:-}"
export DB_NODE_NAME="$OPENSEARCH_NODE_NAME"
export OPENSEARCH_FS_SNAPSHOT_REPO_PATH="${OPENSEARCH_FS_SNAPSHOT_REPO_PATH:-}"
export DB_FS_SNAPSHOT_REPO_PATH="$OPENSEARCH_FS_SNAPSHOT_REPO_PATH"
export OPENSEARCH_NODE_ROLES="${OPENSEARCH_NODE_ROLES:-}"
export DB_NODE_ROLES="$OPENSEARCH_NODE_ROLES"
export OPENSEARCH_PLUGINS="${OPENSEARCH_PLUGINS:-}"
export DB_PLUGINS="$OPENSEARCH_PLUGINS"
export OPENSEARCH_TRANSPORT_PORT_NUMBER="${OPENSEARCH_TRANSPORT_PORT_NUMBER:-9300}"
export DB_TRANSPORT_PORT_NUMBER="$OPENSEARCH_TRANSPORT_PORT_NUMBER"
export OPENSEARCH_HTTP_PORT_NUMBER="${OPENSEARCH_HTTP_PORT_NUMBER:-9200}"
export DB_HTTP_PORT_NUMBER="$OPENSEARCH_HTTP_PORT_NUMBER"

# Opensearch Security configuration
export OPENSEARCH_ENABLE_SECURITY="${OPENSEARCH_ENABLE_SECURITY:-false}"
export DB_ENABLE_SECURITY="$OPENSEARCH_ENABLE_SECURITY"
export OPENSEARCH_PASSWORD="${OPENSEARCH_PASSWORD:-bitnami}"
export DB_PASSWORD="$OPENSEARCH_PASSWORD"
export OPENSEARCH_USERNAME="admin"
export DB_USERNAME="$OPENSEARCH_USERNAME"
export OPENSEARCH_TLS_VERIFICATION_MODE="${OPENSEARCH_TLS_VERIFICATION_MODE:-full}"
export DB_TLS_VERIFICATION_MODE="$OPENSEARCH_TLS_VERIFICATION_MODE"
export OPENSEARCH_TLS_USE_PEM="${OPENSEARCH_TLS_USE_PEM:-false}"
export DB_TLS_USE_PEM="$OPENSEARCH_TLS_USE_PEM"
export OPENSEARCH_KEYSTORE_PASSWORD="${OPENSEARCH_KEYSTORE_PASSWORD:-}"
export DB_KEYSTORE_PASSWORD="$OPENSEARCH_KEYSTORE_PASSWORD"
export OPENSEARCH_TRUSTSTORE_PASSWORD="${OPENSEARCH_TRUSTSTORE_PASSWORD:-}"
export DB_TRUSTSTORE_PASSWORD="$OPENSEARCH_TRUSTSTORE_PASSWORD"
export OPENSEARCH_KEY_PASSWORD="${OPENSEARCH_KEY_PASSWORD:-}"
export DB_KEY_PASSWORD="$OPENSEARCH_KEY_PASSWORD"
export OPENSEARCH_KEYSTORE_LOCATION="${OPENSEARCH_KEYSTORE_LOCATION:-${DB_CERTS_DIR}/opensearch.keystore.jks}"
export DB_KEYSTORE_LOCATION="$OPENSEARCH_KEYSTORE_LOCATION"
export OPENSEARCH_TRUSTSTORE_LOCATION="${OPENSEARCH_TRUSTSTORE_LOCATION:-${DB_CERTS_DIR}/opensearch.truststore.jks}"
export DB_TRUSTSTORE_LOCATION="$OPENSEARCH_TRUSTSTORE_LOCATION"
export OPENSEARCH_NODE_CERT_LOCATION="${OPENSEARCH_NODE_CERT_LOCATION:-${DB_CERTS_DIR}/tls.crt}"
export DB_NODE_CERT_LOCATION="$OPENSEARCH_NODE_CERT_LOCATION"
export OPENSEARCH_NODE_KEY_LOCATION="${OPENSEARCH_NODE_KEY_LOCATION:-${DB_CERTS_DIR}/tls.key}"
export DB_NODE_KEY_LOCATION="$OPENSEARCH_NODE_KEY_LOCATION"
export OPENSEARCH_CA_CERT_LOCATION="${OPENSEARCH_CA_CERT_LOCATION:-${DB_CERTS_DIR}/ca.crt}"
export DB_CA_CERT_LOCATION="$OPENSEARCH_CA_CERT_LOCATION"
export OPENSEARCH_SKIP_TRANSPORT_TLS="${OPENSEARCH_SKIP_TRANSPORT_TLS:-false}"
export DB_SKIP_TRANSPORT_TLS="$OPENSEARCH_SKIP_TRANSPORT_TLS"
export OPENSEARCH_TRANSPORT_TLS_USE_PEM="${OPENSEARCH_TRANSPORT_TLS_USE_PEM:-$DB_TLS_USE_PEM}"
export DB_TRANSPORT_TLS_USE_PEM="$OPENSEARCH_TRANSPORT_TLS_USE_PEM"
export OPENSEARCH_TRANSPORT_TLS_KEYSTORE_PASSWORD="${OPENSEARCH_TRANSPORT_TLS_KEYSTORE_PASSWORD:-$DB_KEYSTORE_PASSWORD}"
export DB_TRANSPORT_TLS_KEYSTORE_PASSWORD="$OPENSEARCH_TRANSPORT_TLS_KEYSTORE_PASSWORD"
export OPENSEARCH_TRANSPORT_TLS_TRUSTSTORE_PASSWORD="${OPENSEARCH_TRANSPORT_TLS_TRUSTSTORE_PASSWORD:-$DB_TRUSTSTORE_PASSWORD}"
export DB_TRANSPORT_TLS_TRUSTSTORE_PASSWORD="$OPENSEARCH_TRANSPORT_TLS_TRUSTSTORE_PASSWORD"
export OPENSEARCH_TRANSPORT_TLS_KEY_PASSWORD="${OPENSEARCH_TRANSPORT_TLS_KEY_PASSWORD:-$DB_KEY_PASSWORD}"
export DB_TRANSPORT_TLS_KEY_PASSWORD="$OPENSEARCH_TRANSPORT_TLS_KEY_PASSWORD"
export OPENSEARCH_TRANSPORT_TLS_KEYSTORE_LOCATION="${OPENSEARCH_TRANSPORT_TLS_KEYSTORE_LOCATION:-$DB_KEYSTORE_LOCATION}"
export DB_TRANSPORT_TLS_KEYSTORE_LOCATION="$OPENSEARCH_TRANSPORT_TLS_KEYSTORE_LOCATION"
export OPENSEARCH_TRANSPORT_TLS_TRUSTSTORE_LOCATION="${OPENSEARCH_TRANSPORT_TLS_TRUSTSTORE_LOCATION:-$DB_TRUSTSTORE_LOCATION}"
export DB_TRANSPORT_TLS_TRUSTSTORE_LOCATION="$OPENSEARCH_TRANSPORT_TLS_TRUSTSTORE_LOCATION"
export OPENSEARCH_TRANSPORT_TLS_NODE_CERT_LOCATION="${OPENSEARCH_TRANSPORT_TLS_NODE_CERT_LOCATION:-$DB_NODE_CERT_LOCATION}"
export DB_TRANSPORT_TLS_NODE_CERT_LOCATION="$OPENSEARCH_TRANSPORT_TLS_NODE_CERT_LOCATION"
export OPENSEARCH_TRANSPORT_TLS_NODE_KEY_LOCATION="${OPENSEARCH_TRANSPORT_TLS_NODE_KEY_LOCATION:-$DB_NODE_KEY_LOCATION}"
export DB_TRANSPORT_TLS_NODE_KEY_LOCATION="$OPENSEARCH_TRANSPORT_TLS_NODE_KEY_LOCATION"
export OPENSEARCH_TRANSPORT_TLS_CA_CERT_LOCATION="${OPENSEARCH_TRANSPORT_TLS_CA_CERT_LOCATION:-$DB_CA_CERT_LOCATION}"
export DB_TRANSPORT_TLS_CA_CERT_LOCATION="$OPENSEARCH_TRANSPORT_TLS_CA_CERT_LOCATION"
export OPENSEARCH_ENABLE_REST_TLS="${OPENSEARCH_ENABLE_REST_TLS:-true}"
export DB_ENABLE_REST_TLS="$OPENSEARCH_ENABLE_REST_TLS"
export OPENSEARCH_HTTP_TLS_USE_PEM="${OPENSEARCH_HTTP_TLS_USE_PEM:-$DB_TLS_USE_PEM}"
export DB_HTTP_TLS_USE_PEM="$OPENSEARCH_HTTP_TLS_USE_PEM"
export OPENSEARCH_HTTP_TLS_KEYSTORE_PASSWORD="${OPENSEARCH_HTTP_TLS_KEYSTORE_PASSWORD:-$DB_KEYSTORE_PASSWORD}"
export DB_HTTP_TLS_KEYSTORE_PASSWORD="$OPENSEARCH_HTTP_TLS_KEYSTORE_PASSWORD"
export OPENSEARCH_HTTP_TLS_TRUSTSTORE_PASSWORD="${OPENSEARCH_HTTP_TLS_TRUSTSTORE_PASSWORD:-$DB_TRUSTSTORE_PASSWORD}"
export DB_HTTP_TLS_TRUSTSTORE_PASSWORD="$OPENSEARCH_HTTP_TLS_TRUSTSTORE_PASSWORD"
export OPENSEARCH_HTTP_TLS_KEY_PASSWORD="${OPENSEARCH_HTTP_TLS_KEY_PASSWORD:-$DB_KEY_PASSWORD}"
export DB_HTTP_TLS_KEY_PASSWORD="$OPENSEARCH_HTTP_TLS_KEY_PASSWORD"
export OPENSEARCH_HTTP_TLS_KEYSTORE_LOCATION="${OPENSEARCH_HTTP_TLS_KEYSTORE_LOCATION:-$DB_KEYSTORE_LOCATION}"
export DB_HTTP_TLS_KEYSTORE_LOCATION="$OPENSEARCH_HTTP_TLS_KEYSTORE_LOCATION"
export OPENSEARCH_HTTP_TLS_TRUSTSTORE_LOCATION="${OPENSEARCH_HTTP_TLS_TRUSTSTORE_LOCATION:-$DB_TRUSTSTORE_LOCATION}"
export DB_HTTP_TLS_TRUSTSTORE_LOCATION="$OPENSEARCH_HTTP_TLS_TRUSTSTORE_LOCATION"
export OPENSEARCH_HTTP_TLS_NODE_CERT_LOCATION="${OPENSEARCH_HTTP_TLS_NODE_CERT_LOCATION:-$DB_NODE_CERT_LOCATION}"
export DB_HTTP_TLS_NODE_CERT_LOCATION="$OPENSEARCH_HTTP_TLS_NODE_CERT_LOCATION"
export OPENSEARCH_HTTP_TLS_NODE_KEY_LOCATION="${OPENSEARCH_HTTP_TLS_NODE_KEY_LOCATION:-$DB_NODE_KEY_LOCATION}"
export DB_HTTP_TLS_NODE_KEY_LOCATION="$OPENSEARCH_HTTP_TLS_NODE_KEY_LOCATION"
export OPENSEARCH_HTTP_TLS_CA_CERT_LOCATION="${OPENSEARCH_HTTP_TLS_CA_CERT_LOCATION:-$DB_CA_CERT_LOCATION}"
export DB_HTTP_TLS_CA_CERT_LOCATION="$OPENSEARCH_HTTP_TLS_CA_CERT_LOCATION"
export OPENSEARCH_SECURITY_DIR="${OPENSEARCH_SECURITY_DIR:-${DB_PLUGINS_DIR}/opensearch-security}"
export OPENSEARCH_SECURITY_CONF_DIR="${OPENSEARCH_SECURITY_CONF_DIR:-${DB_CONF_DIR}/opensearch-security}"
OPENSEARCH_DASHBOARDS_PASSWORD="${OPENSEARCH_DASHBOARDS_PASSWORD:-"${KIBANA_PASSWORD:-}"}"
export OPENSEARCH_DASHBOARDS_PASSWORD="${OPENSEARCH_DASHBOARDS_PASSWORD:-bitnami}"
export LOGSTASH_PASSWORD="${LOGSTASH_PASSWORD:-bitnami}"
export OPENSEARCH_SET_CGROUP="${OPENSEARCH_SET_CGROUP:-true}"
export OPENSEARCH_SECURITY_BOOTSTRAP="${OPENSEARCH_SECURITY_BOOTSTRAP:-false}"
export OPENSEARCH_SECURITY_NODES_DN="${OPENSEARCH_SECURITY_NODES_DN:-}"
export OPENSEARCH_SECURITY_ADMIN_DN="${OPENSEARCH_SECURITY_ADMIN_DN:-}"
export OPENSEARCH_SECURITY_ADMIN_CERT_LOCATION="${OPENSEARCH_SECURITY_ADMIN_CERT_LOCATION:-${DB_CERTS_DIR}/admin.crt}"
export OPENSEARCH_SECURITY_ADMIN_KEY_LOCATION="${OPENSEARCH_SECURITY_ADMIN_KEY_LOCATION:-${DB_CERTS_DIR}/admin.key}"

# Custom environment variables may be defined below
