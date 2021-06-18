{%- assign current_file = "translation_" | append: order.customer.language  -%}

{%- capture "translation_json" %}
  {% include current_file %}
{% endcapture -%}

{%- if translation_json == blank %}
  {% capture "translation_json" %}
    {% include "translation_en" %}
  {% endcapture %}
{% endif -%}

{%- assign translations = translation_json | json_parse -%}
{%- include "email_placeholders" %}

{% include 'custom_translations' %}