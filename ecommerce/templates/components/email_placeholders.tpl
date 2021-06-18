{% comment %}Workarond: Liquid doesn't support curly brackets between "{{ ... }}".{% endcomment %}
{%- capture placeholders_str %}
  {
    "code": "%{code}",
    "count": "%{count}",
    "store_email": "%{store_email}",
    "store_name": "%{store_name}",
    "brand": "%{brand}",
    "email": "%{email}"
  }
{% endcapture -%}

{%- assign placeholders = placeholders_str | json_parse -%}
{%- assign boldLinkTemplate = '<a href="%link_href%" class="bold-link">%link_label%</a>' -%}
{%- assign emailLinkTemplate = '<a href="mailto:%email%" class="blue-link">%email%</a>' -%}