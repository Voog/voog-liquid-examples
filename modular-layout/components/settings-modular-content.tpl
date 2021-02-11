<div class="content_settings-btn js-prevent-sideclick layout_settings-btn">
  <button disabled class="js-content-area-settings-btn js-settings-editor-btn">
    <div class="bold">{{ "blocks_settings" | lce }}</div>
    <div class="grey">{{ "set_the_number_of_blocks" | lce }}</div>
  </button>
</div>

<script>
  window.addEventListener('DOMContentLoaded', function(event) {
    {%- if _blockSettings %}
      var valuesObj = {{ _blockSettings | json }};
    {%- else %}
      var valuesObj = {};
    {%- endif %}

    if (!('block_count' in valuesObj)) {
      valuesObj.block_count = {{_blockCount}};
    }

    initSettingsEditor(
      {
        settingsBtn: document.querySelector('.js-content-area-settings-btn'),
        menuItems: [
          {
            "title": {{ "no_of_blocks" | lce | json }},
            "type": "select",
            "key": "block_count",
            "list": [
              {"title": "1", "value": 1},
              {"title": "2", "value": 2},
              {"title": "3", "value": 3},
              {"title": "4", "value": 4},
              {"title": "5", "value": 5}
            ]
          }
        ],
        dataKey: '{{blockSettingsKey}}',
        containerClass: ['bottom-settings-popover', 'first', 'editor_default'],
        values: valuesObj
      }
    )

    {% for id in (1.._blockCount) %}
      {%- assign blockColumnsSettingsKey = template_settings.page.block_columns_settings.key | append: id -%}

      {%- if page.data[blockColumnsSettingsKey] %}
        var valuesObj = {{ page.data[blockColumnsSettingsKey] | json }};
      {%- else %}
        var valuesObj = {};
      {%- endif %}

      if (!('col_h_padding' in valuesObj)) {
        {%- if _defaultBlockObj[blockColumnsSettingsKey].col_h_padding -%}
          valuesObj.col_h_padding = "{{_defaultBlockObj[blockColumnsSettingsKey].col_h_padding}}";
        {%- else -%}
          valuesObj.col_h_padding = "{{_defaultBlockObj.default.col_h_padding}}";
        {%- endif -%}
      }
      if (!('col_min_width' in valuesObj)) {
        {%- if _defaultBlockObj[blockColumnsSettingsKey].col_min_width -%}
          valuesObj.col_min_width = "{{_defaultBlockObj[blockColumnsSettingsKey].col_min_width}}";
        {%- else -%}
          valuesObj.col_min_width = "{{_defaultBlockObj.default.col_min_width}}";
        {%- endif -%}
      }

      if (!('col_max_width' in valuesObj)) {
        {%- if _defaultBlockObj[blockColumnsSettingsKey].col_max_width -%}
          valuesObj.col_max_width = "{{_defaultBlockObj[blockColumnsSettingsKey].col_max_width}}";
        {%- else -%}
          valuesObj.col_max_width = "{{_defaultBlockObj.default.col_max_width}}";
        {%- endif -%}
      }

      if (!('col_justification' in valuesObj)) {
        {%- if _defaultBlockObj[blockColumnsSettingsKey].col_justification -%}
          valuesObj.col_justification = "{{_defaultBlockObj[blockColumnsSettingsKey].col_justification}}";
        {%- else -%}
          valuesObj.col_justification = "{{_defaultBlockObj.default.col_justification}}";
        {%- endif -%}
      }

      if (!('block_v_padding' in valuesObj)) {
      {%- if _defaultBlockObj[blockColumnsSettingsKey].block_v_padding -%}
        valuesObj.block_v_padding = "{{_defaultBlockObj[blockColumnsSettingsKey].block_v_padding}}";
      {%- else -%}
        valuesObj.block_v_padding = "{{_defaultBlockObj.default.block_v_padding}}";
      {%- endif -%}
      }

      if (!('block_max_width' in valuesObj)) {
        {%- if _defaultBlockObj[blockColumnsSettingsKey].block_max_width -%}
          valuesObj.block_max_width = "{{_defaultBlockObj[blockColumnsSettingsKey].block_max_width}}";
        {%- else -%}
          valuesObj.block_max_width = "{{_defaultBlockObj.default.block_max_width}}";
        {%- endif -%}
      }

      if (!('block_justification' in valuesObj)) {
        {%- if _defaultBlockObj[blockColumnsSettingsKey].block_justification -%}
            valuesObj.block_justification = "{{_defaultBlockObj[blockColumnsSettingsKey].block_justification}}";
        {%- else -%}
          valuesObj.block_justification = "{{_defaultBlockObj.default.block_justification}}";
        {%- endif -%}
      }

      if (!('block_columns' in valuesObj)) {
        {%- if _defaultBlockObj[blockColumnsSettingsKey].col_count %}
          valuesObj['block_columns'] = {{_defaultBlockObj[blockColumnsSettingsKey].col_count}};
        {%- else %}
          valuesObj['block_columns'] = {{_defaultBlockObj.default.col_count}};
        {%- endif %}
      }

      initSettingsEditor(
        {
          settingsBtn: document.querySelector('.js-column-settings-btn-{{ id }}'),
          menuItems: [
            {
              "title": {{ "no_of_columns" | lce | json }},
              "type": "select",
              "key": "block_columns",
              "list": [
                {"title": "1", "value": 1},
                {"title": "2", "value": 2},
                {"title": "3", "value": 3},
                {"title": "4", "value": 4},
                {"title": "5", "value": 5}
              ]
            },
            {%- assign blockMaxWidthTr = "max_width" | lce -%}
            {%- assign blockMaxWidthCombinedTr = blockMaxWidthTr | append: ' (%)' -%}
            {
              "title": {{ blockMaxWidthCombinedTr| json }},
              "type": "number",
              "min": 1,
              "key": "block_max_width",
              "placeholder": {{ blockMaxWidthCombinedTr| json }}
            },
            {%- assign verticalSpacingTr = "vertical_spacing" | lce -%}
            {%- assign pxTr = "units.px" | lce -%}
            {%- assign verticalSpacingCombinedTr = verticalSpacingTr | append: ' (' | append: pxTr | append: ')' -%}
            {
              "title": {{verticalSpacingCombinedTr | json }},
              "type": "number",
              "min": 1,
              "key": "block_v_padding",
              "placeholder": {{verticalSpacingCombinedTr | json }}
            },
            {
              "title": {{ "column_distribution" | lce | json }},
              "type": "select",
              "key": "block_justification",
              "list": [
                {
                  "title": {{ "left" | lce | json }},
                  "value": "flex-start"
                },
                {
                  "title": {{ "center" | lce | json }},
                  "value": "center"
                },
                {
                  "title": {{ "right" | lce | json }},
                  "value": "flex-end"
                }
              ],
              "class": [
                'block_justification'
              ]
            },
            {%- assign colMaxWidthTr = "col_max_width" | lce -%}
            {%- assign pxTr = "units.px" | lce -%}
            {%- assign colMaxWidthCombinedTr = colMaxWidthTr | append: ' (' | append: pxTr | append: ')' -%}
            {
              "title": {{ colMaxWidthCombinedTr | json }},
              "type": "number",
              "min": 1,
              "key": "col_max_width",
              "placeholder": {{ colMaxWidthCombinedTr | json }}
            },
            {%- assign colMinWidthTr = "col_min_width" | lce -%}
            {%- assign pxTr = "units.px" | lce -%}
            {%- assign colMinWidthCombinedTr = colMinWidthTr | append: ' (' | append: pxTr | append: ')' -%}
            {
              "title": {{ colMinWidthCombinedTr | json }},
              "type": "number",
              "min": 1,
              "key": "col_min_width",
              "placeholder": {{ colMinWidthCombinedTr | json }}
            },
            {%- assign colHPadTr = "space_between_columns" | lce -%}
            {%- assign pxTr = "units.px" | lce -%}
            {%- assign colHPadCombinedTr = colHPadTr | append: ' (' | append: pxTr | append: ')' -%}
            {
              "title": {{ colHPadCombinedTr | json }},
              "type": "number",
              "min": 1,
              "key": "col_h_padding",
              "placeholder": {{ colHPadCombinedTr | json }}
            },
            {
              "title": {{ "column_distribution" | lce | json }},
              "type": "select",
              "key": "col_justification",
              "list": [
                {
                  "title": {{ "space_between_columns" | lce | json }},
                  "value": "between"
                },
                {
                  "title": {{ "space_around_columns" | lce | json }},
                  "value": "around"
                },
                {
                  "title": {{ "columns_are_evenly_distributed" | lce | json }},
                  "value": "evenly"
                }
              ]
            }
          ],
          dataKey: '{{blockColumnsSettingsKey}}',
          values: valuesObj,
          containerClass: ['block-settings-popover-{{ id }}', 'editor_default'],
          prevFunc: function(data) {
            {%- assign rowSettingsKey = id | append: '_block_columns' -%}
            {%- assign rowSettings = _blockSettings[rowSettingsKey] -%}

            if (data.block_max_width >= 1) {
              if ($(window).width() >= 720) {
                $('.block-{{ id }}').css({
                  width: data.block_max_width + '%'
                });
              } else {
                $('.block-{{ id }}').css({
                  width: '100%'
                });
              }
            }

            if (data.block_justification) {
              $('.block-container-{{ id }}').css({
                'justify-content': data.block_justification
              });
            }

            if (parseInt(data.col_h_padding) >= 0) {
              var col_h_padding = '0 ' + data.col_h_padding + 'px 32px';
              if ($(window).width() <= 720 && data.block_v_padding > 32) {
                $('.column-container-{{ id }} .col-item').css({
                  padding: col_h_padding / 2, width: 'calc(100% / {{rowSettings.block_count}} - ' + data.col_h_padding + 'px)'
                });

                $('.column-container-{{ id }}').css({
                  'margin': '0 -' + data.col_h_padding / 2 + 'px -32px'
                });
              } else {
                $('.column-container-{{ id }} .col-item').css({
                  padding: col_h_padding, width: 'calc(100% / {{rowSettings.block_count}} - ' + data.col_h_padding * 2 + 'px)'
                });

                $('.column-container-{{ id }}').css({
                  'margin': '0 -' + data.col_h_padding + 'px -32px'
                });
              }
            } else {
              $('.column-container-{{ id }} .col-item').css({
                padding: '0 0 32px', width: 'calc(100% / {{rowSettings.block_count}})'
              });

              $('.column-container-{{ id }}').css({
                'margin': '0 0 -32px'
              });
            }

            if (parseInt(data.block_v_padding) >= 0) {
              if ($(window).width() <= 720 && data.block_v_padding > 32) {
                $('.column-container-{{ id }}').css({
                  padding: data.block_v_padding / 2 + 'px 0'
                });
              } else {
                $('.column-container-{{ id }}').css({
                  padding: data.block_v_padding + 'px 0'
                });

                $('.column-container-{{ id }}').css({
                  padding: data.block_v_padding + 'px 0'
                });
              }
            }

            if (data.col_justification) {
              $('.column-container-{{ id }}').css({
                'justify-content': 'space-' + data.col_justification
              });
            }

            if ($(window).width() <= 720) {
              $('.column-container-{{ id }} .col-item').css({
                'max-width': '100%'
              });
            } else {
              if (parseInt(data.col_max_width) >= 1) {
                $('.column-container-{{ id }} .col-item').css({
                  'max-width': data.col_max_width + 'px'
                });
              } else {
                $('.column-container-{{ id }} .col-item').css({
                  'max-width': 'initial'
                });
              }
            }


            if (data.col_min_width >= 1) {
              $('.column-container-{{ id }} .col-item').css({
                'min-width': data.col_min_width + 'px'
              });
            } else {
              $('.column-container-{{ id }} .col-item').css({
                'min-width': 'initial'
              });
            }

            if (parseInt(data.block_max_width) < 100) {
              $('.block-settings-popover-{{ id }} .block_justification').show();
            } else {
              $('.block-settings-popover-{{ id }} .block_justification').hide();
            }
          }
        }
      );
    {%- endfor -%}
  });
</script>
