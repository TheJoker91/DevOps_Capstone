{{/* Chart name */}}
{{- define "capstone-api.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Full resource name */}}
{{- define "capstone-api.fullname" -}}
{{- if contains .Chart.Name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/* Chart name and version */}}
{{- define "capstone-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Selector labels */}}
{{- define "capstone-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "capstone-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Common labels */}}
{{- define "capstone-api.labels" -}}
helm.sh/chart: {{ include "capstone-api.chart" . }}
{{ include "capstone-api.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* Service account name */}}
{{- define "capstone-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "capstone-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/* Container image with a required immutable tag */}}
{{- define "capstone-api.image" -}}
{{- $tag := required "image.tag is required: set it to an immutable commit SHA" .Values.image.tag }}
{{- if eq $tag "latest" }}
{{- fail "image.tag must not be latest: use an immutable commit SHA" }}
{{- end }}
{{- printf "%s:%s" .Values.image.repository $tag }}
{{- end }}