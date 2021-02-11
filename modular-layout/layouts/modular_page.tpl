<!DOCTYPE html>
{% include "template-settings" %}
{% include "template-variables" %}
<html class="{% if editmode %}editmode{% else %}publicmode{% endif %}" lang="{{ page.language_code }}">
  <head prefix="og: http://ogp.me/ns#">
  {% stylesheet_link "settings-editor-style.css?modular=1.0" %}
  </head>
  <body>
    <div>
      {% include 'modular-blocks',
        _blockSettings: page.data[blockSettingsKey],
        _commonPage: true,
        _defaultBlockObj: template_settings.page.block_columns_settings.value
      %}
    </div>

    {% if editmode %}
      {% editorjsblock %}
        <script src="{{ site.static_asset_host }}/libs/edicy-tools/latest/edicy-tools.js"></script>
        {% include "settings-editor" %}
      {% endeditorjsblock %}
    {% endif %}
  </body>
</html>
