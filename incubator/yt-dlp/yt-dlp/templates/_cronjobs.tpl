{{- define "yt-dlp.ytdlp_jobs" -}}
{{ range $cj := .Values.ytdlp_jobs }}
  {{ $name := $cj.name }}
  {{ $command := $cj.command }}
  {{ $schedule := $cj.schedule }}

{{ $name }}:
  enabled: true
  type: CronJob
  schedule: {{ $schedule | quote }}
  podSpec:
    restartPolicy: Never
    containers:
      {{ $name }}:
        enabled: true
        primary: true
        imageSelector: image
        resources:
          excludeExtra: true
        command:
          - yt-dlp
          - |
            {{ range $command }}
              {{ . | nindent 12 }}
            {{ end }}
        probes:
          liveness:
            enabled: false
          readiness:
            enabled: false
          startup:
            enabled: false
{{ end }}
{{- end -}}
