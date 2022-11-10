{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "rancher-demo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rancher-demo.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rancher-demo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "check-cluster-name" }}
{{- $length := len .Values.app.localization.title -}}
{{- if (gt $length 80)}}
{{- fail "Your `clusterName` isn’t valid it has to be below 81 chars." -}}
{{- end}}
{{- if not (regexMatch "^([a-z]([a-z0-9\\-]*[a-z0-9])?\\.)*([a-z]([a-z0-9\\-]*[a-z0-9])?)$" .Values.app.localization.title) -}}
{{- fail "Your `clusterName` isn’t valid. It must be dot-separated tokens where a token start with a lowercase letter followed by lowercase letters, numbers, or hyphens, can only end with a with [a-z0-9] and has to be below 80 chars." -}}
{{- end -}}
{{- end -}}
