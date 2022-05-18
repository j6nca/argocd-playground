{{/*
Returns value by corresponding to key in nested maps or empty string if not found

Usage:

{{- $args := dict "the_path" "helm.alexztestapp123.enabled" "the_map" $deployment_settings }}
{{- $v := ( include "getStringValue" $args ) }}

It should return value for key 'enabled' from map of this structure:
helm:
  alexztestapp123:
    enabled: 1235
*/}}

{{- define "getStringValue" }}
{{- $the_keys := splitList "." .the_path }}
{{- $value := "" }}
{{- $last_map := .the_map }}
{{- $path_not_found := 0 }}
{{- range $k := $the_keys }}
  {{- if ne "map" (kindOf $last_map) }}
    {{- $path_not_found = 1 }}
  {{- end }}
  {{- if not $path_not_found }}
    {{- $value = (get $last_map $k) }}
    {{- $last_map = $value }}
  {{- end }}
{{- end }}
{{- if $path_not_found }}
  {{- print "" }}
{{- else }}
  {{- printf "%v" $last_map }}
{{- end }}
{{- end }}

