{{- define "potee.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "potee.web.labels" -}}
{{ include "potee.web.selectorLabels" . }}
{{- end -}}

{{- define "potee.web.selectorLabels" -}}
component: web
{{- end -}}

{{- define "potee.web.fullname" -}}
{{- if .Values.web.fullnameOverride -}}
{{- .Values.web.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.web.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.web.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.web.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "potee.serviceAccountName.web" -}}
{{- if .Values.serviceAccounts.web.create -}}
    {{ default (include "potee.web.fullname" . ) .Values.serviceAccounts.web.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.web.name }}
{{- end -}}
{{- end -}}


{{- define "potee.admin.labels" -}}
{{ include "potee.admin.selectorLabels" . }}
{{- end -}}

{{- define "potee.admin.selectorLabels" -}}
component: admin
{{- end -}}

{{- define "potee.admin.fullname" -}}
{{- if .Values.admin.fullnameOverride -}}
{{- .Values.admin.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.admin.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.admin.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.admin.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "potee.serviceAccountName.admin" -}}
{{- if .Values.serviceAccounts.admin.create -}}
    {{ default (include "potee.admin.fullname" .) .Values.serviceAccounts.admin.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.admin.name }}
{{- end -}}
{{- end -}}


{{- define "potee.auth.labels" -}}
{{ include "potee.auth.selectorLabels" . }}
{{- end -}}

{{- define "potee.auth.selectorLabels" -}}
component: auth
{{- end -}}


{{- define "potee.auth.fullname" -}}
{{- if .Values.auth.fullnameOverride -}}
{{- .Values.auth.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.auth.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.auth.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.auth.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "potee.serviceAccountName.auth" -}}
{{- if .Values.serviceAccounts.auth.create -}}
    {{ default (include "potee.auth.fullname" .) .Values.serviceAccounts.auth.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.auth.name }}
{{- end -}}
{{- end -}}

{{- define "potee.checkers.labels" -}}
{{ include "potee.checkers.selectorLabels" . }}
{{- end -}}

{{- define "potee.checkers.selectorLabels" -}}
component: checkers
{{- end -}}

{{- define "potee.checkers.fullname" -}}
{{- if .Values.checkers.fullnameOverride -}}
{{- .Values.checkers.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.checkers.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.checkers.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.checkers.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "potee.serviceAccountName.checkers" -}}
{{- if .Values.serviceAccounts.checkers.create -}}
    {{ default (include "potee.checkers.fullname" .) .Values.serviceAccounts.checkers.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.checkers.name }}
{{- end -}}
{{- end -}}


{{- define "potee.entities.labels" -}}
{{ include "potee.entities.selectorLabels" . }}
{{- end -}}

{{- define "potee.entities.selectorLabels" -}}
component: entities
{{- end -}}

{{- define "potee.entities.fullname" -}}
{{- if .Values.entities.fullnameOverride -}}
{{- .Values.entities.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.entities.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.entities.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.entities.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "potee.serviceAccountName.entities" -}}
{{- if .Values.serviceAccounts.entities.create -}}
    {{ default (include "potee.entities.fullname" .) .Values.serviceAccounts.entities.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.entities.name }}
{{- end -}}
{{- end -}}


{{- define "potee.manager.labels" -}}
{{ include "potee.manager.selectorLabels" . }}
{{- end -}}

{{- define "potee.manager.selectorLabels" -}}
component: manager
{{- end -}}

{{- define "potee.manager.fullname" -}}
{{- if .Values.manager.fullnameOverride -}}
{{- .Values.manager.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.manager.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.manager.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.manager.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "potee.serviceAccountName.manager" -}}
{{- if .Values.serviceAccounts.manager.create -}}
    {{ default (include "potee.manager.fullname" .) .Values.serviceAccounts.manager.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.manager.name }}
{{- end -}}
{{- end -}}


{{- define "potee.events.labels" -}}
{{ include "potee.events.selectorLabels" . }}
{{- end -}}

{{- define "potee.events.selectorLabels" -}}
component: events
{{- end -}}


{{- define "potee.events.fullname" -}}
{{- if .Values.events.fullnameOverride -}}
{{- .Values.events.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.events.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.events.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.events.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "potee.serviceAccountName.events" -}}
{{- if .Values.serviceAccounts.events.create -}}
    {{ default (include "potee.events.fullname" .) .Values.serviceAccounts.events.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.events.name }}
{{- end -}}
{{- end -}}


{{- define "potee.score.labels" -}}
{{ include "potee.score.selectorLabels" . }}
{{- end -}}

{{- define "potee.score.selectorLabels" -}}
component: score
{{- end -}}


{{- define "potee.score.fullname" -}}
{{- if .Values.score.fullnameOverride -}}
{{- .Values.score.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.score.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.score.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.score.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "potee.serviceAccountName.score" -}}
{{- if .Values.serviceAccounts.score.create -}}
    {{ default (include "potee.score.fullname" .) .Values.serviceAccounts.score.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.score.name }}
{{- end -}}
{{- end -}}