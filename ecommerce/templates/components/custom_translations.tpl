{%- comment -%}
  {%- assign current_file = "custom_translations_" | append: order.customer.language  -%}

  {%- capture "custom_translations_json" %}
    {% include current_file %}
  {% endcapture -%}

  {%- if custom_translations_json == blank %}
    {% capture "custom_translations_json" %}
      {% include "custom_translations_en" %}
    {% endcapture %}
  {% endif -%}

  {%- assign custom_translations = custom_translations_json | json_parse -%}
{%- endcomment -%}