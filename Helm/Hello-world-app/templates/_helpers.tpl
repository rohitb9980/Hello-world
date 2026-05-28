{{- define "hello-world-app.name" -}}
hello-world-app
{{- end -}}

{{- define "hello-world-app.fullname" -}}
{{ include "hello-world-app.name" . }}
{{- end -}}

{{- define "hello-world-app.labels" -}}
app.kubernetes.io/name: {{ include "hello-world-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}