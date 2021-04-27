{{- define "pega.installer.config" -}}
{{- $arg := .mode -}}
# Node type specific configuration for {{ .name }}
kind: ConfigMap
apiVersion: v1
metadata:
  name: {{ .name }}
  namespace: {{ .root.Release.Namespace }}
data:
# Start of Pega Installer Configurations

{{ if eq $arg "installer-config" }}

{{- $prconfigTemplatePath := "config/prconfig.xml.tmpl" }}
{{- $setupDatabasePath := "config/setupDatabase.properties" }}
{{- $setupDatabasetemplatePath := "config/setupDatabase.properties.tmpl" }}
{{- $prbootstraptemplatePath := "config/prbootstrap.properties.tmpl" }}
{{- $prpcUtilsPropertiestemplatePath := "config/prpcUtils.properties.tmpl" }}
{{- $migrateSystempropertiestemplatePath := "config/migrateSystem.properties.tmpl" }}
{{- $custom_config := .root.Values.custom }}

  prconfig.xml.tmpl: |-
{{- if $custom_config.prconfig }}
{{ $custom_config.prconfig | indent 6 }}
{{ else }}
{{ if .root.Files.Glob $prconfigTemplatePath }}
{{ .root.Files.Get $prconfigTemplatePath | indent 6 }}
{{- end }}
{{- end }}

  setupDatabase.properties: |-
{{- if $custom_config.setupDatabase }}
{{ $custom_config.setupDatabase | indent 6 }}
{{ else }}
{{ if .root.Files.Glob $setupDatabasePath }}
{{ .root.Files.Get $setupDatabasePath | indent 6 }}
{{- end }}
{{- end }}

  setupDatabase.properties.tmpl: |-
{{- if $custom_config.setupDatabase }}
{{ $custom_config.setupDatabase | indent 6 }}
{{ else }}
{{ if .root.Files.Glob $setupDatabasetemplatePath }}
{{ .root.Files.Get $setupDatabasetemplatePath | indent 6 }}
{{- end }}
{{- end }}

  prbootstrap.properties.tmpl: |-
{{- if $custom_config.prbootstrap }}
{{ $custom_config.prbootstrap | indent 6 }}
{{ else }}
{{ if .root.Files.Glob $prbootstraptemplatePath }}
{{ .root.Files.Get $prbootstraptemplatePath | indent 6 }}
{{- end }}
{{- end }}

  prpcUtils.properties.tmpl: |-
{{- if $custom_config.prpcUtils }}
{{ $custom_config.prpcUtils | indent 6 }}
{{ else }}
{{ if .root.Files.Glob $prpcUtilsPropertiestemplatePath }}
{{ .root.Files.Get $prpcUtilsPropertiestemplatePath | indent 6 }}
{{- end }}
{{- end }}

  migrateSystem.properties.tmpl: |-
{{- if $custom_config.migrateSystem }}
{{ $custom_config.migrateSystem | indent 6 }}
{{ else }}
{{ if .root.Files.Glob $migrateSystempropertiestemplatePath }}
{{ .root.Files.Get $migrateSystempropertiestemplatePath | indent 6 }}
{{- end }}
{{- end }}

  prlog4j2.xml: |-
{{- if $custom_config.prlog4j2 }}
{{ $custom_config.prlog4j2.xml | indent 6 }}
{{ else }}
{{- $prlog4j2Path := "config/prlog4j2.xml" }}
{{ .root.Files.Get $prlog4j2Path | indent 6 }}
{{- end }}}

{{- $dbType := .dbType }}
{{- $postgresConfPath := "config/postgres/postgres.conf" }}
{{- $oracledateConfPath := "config/oracledate/oracledate.conf" }}
{{- $db2zosConfPath := "config/db2zos/db2zos.conf" }}
{{- $mssqlConfPath := "config/mssql/mssql.conf" }}
{{- $udbConfPath := "config/udb/udb.conf" }}
{{- $zosPropertiesPath := "config/db2zos/DB2SiteDependent.properties" }}

{{ if and (eq $dbType "postgres") ( $postgresConf := .root.Files.Glob $postgresConfPath ) }}
  postgres.conf: |-
{{ .root.Files.Get $postgresConfPath | indent 6 }}
{{- end }}

{{ if and (eq $dbType "oracledate") ( $oracledateConf := .root.Files.Glob $oracledateConfPath ) }}
  oracledate.conf: |-
{{ .root.Files.Get $oracledateConfPath | indent 6 }}
{{- end }}

{{ if and (eq $dbType "mssql") ( $mssqlConf := .root.Files.Glob $mssqlConfPath ) }}
  mssql.conf: |-
{{ .root.Files.Get $mssqlConfPath | indent 6 }}
{{- end }}

{{ if and (eq $dbType "db2zos") ( $db2zosConf := .root.Files.Glob $db2zosConfPath ) ( $db2zosProperties := .root.Files.Glob $zosPropertiesPath ) }}
  db2zos.conf: |-
{{ .root.Files.Get $db2zosConfPath | indent 6 }}
  DB2SiteDependent.properties: |-
{{ .root.Files.Get $zosPropertiesPath | indent 6 }}
{{- end }}

{{ if and (eq $dbType "udb") ( $udbConf := .root.Files.Glob $udbConfPath ) }}
  udb.conf: |-
{{ .root.Files.Get $udbConfPath | indent 6 }}
{{- end }}

{{- end }}
# End of Pega Installer Configurations
{{- end }}
