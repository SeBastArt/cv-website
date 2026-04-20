{{/*
Expand the name of the chart.
*/}}
{{ define "sebastianschueler-website.name" -}}
{{ default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{ define "sebastianschueler-website.fullname" -}}
{{- if .Values.fullnameOverride }}
{{ .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{ printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{ define "sebastianschueler-website.chart" -}}
{{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{ define "sebastianschueler-website.labels" -}}
helm.sh/chart: {{ include "sebastianschueler-website.chart" . }}
{{ include "sebastianschueler-website.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{ define "sebastianschueler-website.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sebastianschueler-website.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{/*
F-006 (AUDIT-2026-04-19) — Image helpers.
*/}}
{{- define "website.image" -}}
{{- if .imageDigest -}}
{{ .image }}@{{ .imageDigest }}
{{- else -}}
{{ .image }}:{{ .imageVersion }}
{{- end -}}
{{- end }}

{{- define "website.imagePullPolicy" -}}
{{- if .imageDigest -}}IfNotPresent{{- else -}}Always{{- end -}}
{{- end }}
