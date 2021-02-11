
{%- if _blockSettings.block_count != blank -%}
  {%- assign blockCount = _blockSettings.block_count | to_num -%}
{%- elsif _defaultBlockObj -%}
  {%- assign blockCount = _defaultBlockObj.size -%}
{%- endif -%}

{%- for id in (1..blockCount) -%}
  {%- assign blockColumnsSettingsKey = template_settings.page.block_columns_settings.key | append: id -%}
  {%- assign blockColumnsSettings = page.data[blockColumnsSettingsKey] -%}

  {%- assign blockColumnsCount = blockColumnsSettings.block_columns -%}

  {%- if blockColumnsCount != blank -%}
    {%- assign blockColumnsCount = blockColumnsCount -%}
  {%- else -%}
    {%- if _defaultBlockObj[blockColumnsSettingsKey].col_count -%}
      {%- assign blockColumnsCount = _defaultBlockObj[blockColumnsSettingsKey].col_count -%}
    {%- else -%}
      {%- assign blockColumnsCount = _defaultBlockObj.default.col_count -%}
    {%- endif -%}
  {%- endif -%}

  {%- if blockColumnsSettings.col_h_padding != blank -%}
    {%- assign hPadding = blockColumnsSettings.col_h_padding | plus: 0 -%}
  {%- else -%}
    {%- if _defaultBlockObj[blockColumnsSettingsKey].col_h_padding -%}
      {%- assign hPadding = _defaultBlockObj[blockColumnsSettingsKey].col_h_padding | plus: 0 -%}
    {%- else -%}
      {%- assign hPadding = _defaultBlockObj.default.col_h_padding | plus: 0 -%}
    {%- endif -%}
  {%- endif -%}

  {%- if blockColumnsSettings.block_v_padding != blank -%}
    {%- assign vPadding = blockColumnsSettings.block_v_padding | plus: 0 -%}
  {%- else -%}
    {%- if _defaultBlockObj[blockColumnsSettingsKey].block_v_padding -%}
      {%- assign vPadding = _defaultBlockObj[blockColumnsSettingsKey].block_v_padding | plus: 0 -%}
    {%- else -%}
      {%- assign vPadding = _defaultBlockObj.default.block_v_padding | plus: 0 -%}
    {%- endif -%}
  {%- endif -%}

  {%- if blockColumnsSettings.col_min_width != blank -%}
    {%- assign minWidth = blockColumnsSettings.col_min_width -%}
  {%- else -%}
    {%- if _defaultBlockObj[blockColumnsSettingsKey].col_min_width -%}
      {%- assign minWidth = _defaultBlockObj[blockColumnsSettingsKey].col_min_width -%}
    {%- else -%}
      {%- assign minWidth = _defaultBlockObj.default.col_min_width -%}
    {%- endif -%}
  {%- endif -%}

  {%- if blockColumnsSettings.col_justification != blank -%}
    {%- assign colJustification = blockColumnsSettings.col_justification -%}
  {%- else -%}
    {%- if _defaultBlockObj[blockColumnsSettingsKey].col_justification -%}
      {%- assign colJustification = _defaultBlockObj[blockColumnsSettingsKey].col_justification -%}
    {%- else -%}
      {%- assign colJustification = _defaultBlockObj.default.col_justification -%}
    {%- endif -%}
  {%- endif -%}

  {%- if blockColumnsSettings.col_max_width != blank and blockColumnsSettings.col_max_width != 0 -%}
    {%- assign col_max_width = blockColumnsSettings.col_max_width -%}
  {%- else -%}
    {%- if blockColumnsSettings.col_max_width == 0 -%}
      {%- assign col_max_width = 'none' -%}
    {%- else -%}
      {%- if _defaultBlockObj[blockColumnsSettingsKey].col_max_width -%}
        {%- assign col_max_width = _defaultBlockObj[blockColumnsSettingsKey].col_max_width -%}
      {%- else -%}
        {%- assign col_max_width = _defaultBlockObj.default.col_max_width -%}
      {%- endif -%}
    {%- endif -%}
  {%- endif -%}

  {%- if blockColumnsSettings.block_max_width != blank and blockColumnsSettings.block_max_width != 0 -%}
    {%- assign maxBlockWidth = blockColumnsSettings.block_max_width -%}
  {%- else -%}
    {% if blockColumnsSettings.block_max_width == 0 %}
      {%- assign maxBlockWidth = 100 -%}
    {% else %}
      {%- if _defaultBlockObj[blockColumnsSettingsKey].block_max_width -%}
        {%- assign maxBlockWidth = _defaultBlockObj[blockColumnsSettingsKey].block_max_width -%}
      {%- else -%}
        {%- assign maxBlockWidth = _defaultBlockObj.default.block_max_width -%}
      {%- endif -%}
    {% endif %}
  {%- endif -%}

  {%- if blockColumnsSettings.block_justification != blank -%}
    {%- assign blockJustification = blockColumnsSettings.block_justification -%}
  {%- else -%}
    {%- if _defaultBlockObj[blockColumnsSettingsKey].block_justification -%}
      {%- assign blockJustification = _defaultBlockObj[blockColumnsSettingsKey].block_justification -%}
    {%- else -%}
      {%- assign blockJustification = _defaultBlockObj.default.block_justification -%}
    {%- endif -%}
  {%- endif -%}

  <style>
    .block-container-{{ id }} {
      display: -webkit-box;
      display: -ms-flexbox;
      display: flex;
      justify-content: {{blockJustification}};
      margin-bottom: 8px;
    }

    .block-{{ id }} {
      width: 100%;
    }

    @media screen and (min-width: 720px) {
      .block-{{ id }} {
        width: {{maxBlockWidth}}%;
      }
    }

    {%- comment -%}
      Remove col-item bottom padding on last row
      and add margin subtraction to v-pad
    {%- endcomment -%}

    .column-container-{{ id }} {
      margin: 0 -{{hPadding}}px -32px;
      padding: {{vPadding}}px 0;
      justify-content: space-{{colJustification}};
      display: -webkit-box;
      display: -ms-flexbox;
      display: flex;
      -ms-flex-wrap: wrap;
          flex-wrap: wrap;
    }

    .column-container-{{ id }} .col-item {
      min-width: {{minWidth}}px;
      padding: 0 {{hPadding}}px 32px;
      -webkit-box-flex: 1;
          -ms-flex: auto;
              flex: auto;
      -webkit-box-sizing: border-box;
              box-sizing: border-box;
    }

    .column-container-{{blockColumnsCount}}-{{ id }} .col-item {
      width: calc(100% / {{blockColumnsCount}} - {{hPadding}}*2px);
      max-width: {%- if col_max_width == "none" -%}none{%- else -%}{{col_max_width}}px{%- endif -%};
    }

    @media screen and (max-width: 720px) {
      {%- if vPadding > 32 -%}
        {%- assign vPadding = vPadding | divided_by: 2 -%}
      {%- endif -%}

      {%- if hPadding > 32 -%}
        {%- assign hPadding = hPadding | divided_by: 2 -%}
      {%- endif -%}

      .column-container-{{ id }} {
        margin: 0 -{{hPadding}}px -32px;
        padding: {{vPadding}}px 0;
      }

      .column-container-{{ id }} .col-item {
        padding: 0 {{hPadding}}px 32px;
      }

      .column-container-{{blockColumnsCount}}-{{ id }} .col-item {
        width: calc(100% / {{blockColumnsCount}} - {{hPadding}}*2px);
      }

      .column-container-{{blockColumnsCount}}-{{ id }} .col-item {
        max-width: 100%;
      }
    }
  </style>
  <script>
    window.addEventListener('DOMContentLoaded', function(event) {
      var setMinWidth = function() {
        var colItem = $(".column-container-{{id}} .col-item");

        if (parseFloat(colItem.css('min-width')) > colItem.closest(".editor_default-container").width()) {
          colItem.css('min-width', '100%');
        } else {
          colItem.css('min-width', "{{minWidth}}");
        }
      }

      setMinWidth();

      $(window).resize(function() {
        setMinWidth();
        if ($(window).width() >= 720) {
          $('.block-{{ id }}').css({
            width: "{{maxBlockWidth}}%"
          });
        } else {
          $('.block-{{ id }}').css({
            width: '100%'
          });
          $('.column-container-{{ id }} .col-item').css({
            'max-width': '100%'
          });
        }
      });
    });
  </script>
{%- endfor -%}

{%- for id in (1..blockCount) -%}
  <section class="block-container-{{ id }} content-formatted">
    <div class="block-{{ id }} editor_default-container">
      {%- if editmode -%}
        <button disabled class="js-column-settings-btn-{{ id }} js-settings-editor-btn">{{ "block" | lce  | escape_once }} {{ id }}</button>
      {%- endif -%}
      {%- assign blockColumnsSettingsKey = template_settings.page.block_columns_settings.key | append: id -%}
      {%- assign blockColumnsCount = page.data[blockColumnsSettingsKey].block_columns -%}


      {%- if blockColumnsCount -%}
        {%- assign columnCount = blockColumnsCount | to_num -%}
      {%- else -%}
        {%- if _defaultBlockObj[blockColumnsSettingsKey].col_count %}
          {%- assign columnCount = _defaultBlockObj[blockColumnsSettingsKey].col_count -%}
        {%- else %}
          {%- assign columnCount = _defaultBlockObj.default.col_count -%}
        {%- endif %}

      {%- endif -%}

      <div class="column-container-{{ id }} column-container-{{ columnCount }}-{{ id }}">
        {%- for i in (1..columnCount) -%}
          {%- assign name = "content-" | append: i | append: "-" | append: id -%}
          <div class="col-item" data-search-indexing-allowed="true">
            {%- content name=name -%}
          </div>
        {%- endfor -%}
      </div>
    </div>
  </section>
{%- endfor -%}

{% include 'settings-popover',
  _blockSettings: _blockSettings, _commonPage: _commonPage,
  _defaultBlockObj: _defaultBlockObj, _blockCount: blockCount
%}