{{/* Helm standard labels */}}
{{- define "weave-scope-frontend.helm_std_labels" }}
chart: {{ .Chart.Name }}-{{ .Chart.Version }}
heritage: {{ .Release.Service }}
release: {{ .Release.Name }}
app: {{ template "toplevel.name" . }}
{{- end }}

{{/* Weave Scope default annotations */}}
{{- define "weave-scope-frontend.annotations" }}
cloud.weave.works/launcher-info: |-
  {
    "server-version": "master-4fe8efe",
    "original-request": {
      "url": "/k8s/v1.7/scope.yaml"
    },
    "email-address": "support@weave.works",
    "source-app": "weave-scope",
    "weave-cloud-component": "scope"
  }
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "weave-scope-frontend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expand the name of the top-level chart.
*/}}
{{- define "toplevel.name" -}}
{{- default (.Template.BasePath | split "/" )._0 .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.  We truncate at 63 chars.
*/}}
{{- define "weave-scope-frontend.fullname" -}}
{{- printf "%s-%s" .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a fully qualified name that always uses the name of the top-level chart.
*/}}
{{- define "toplevel.fullname" -}}
{{- $name := default (.Template.BasePath | split "/" )._0 .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the apiVerion of deployment.
*/}}
{{- define "deployment.apiVersion" -}}
{{- if semverCompare "<1.14-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "networking.k8s.io/v1" -}}
{{- else if semverCompare ">=1.14-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}
