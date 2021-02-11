{%- capture template_settings_json -%}
  {% include 'template-settings-json' %}
{%- endcapture -%}

{%- assign template_settings = template_settings_json | replace: "PREFIX", 'rmk' | json_parse -%}
{%- assign blockSettingsKey = template_settings.page.block_settings.key -%}
