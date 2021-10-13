{% if order.custom_fields %}
<tr>
  <td align="left" style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; padding-bottom: 0px; word-break: break-word">
    <div style="color: #1b2124; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 16px; font-weight: bold; line-height: 28px; text-align: left" align="left">
      {{ translations.ecommerce_core.shared.mailers.order_details.additional_details }}
    </div>
  </td>
</tr>
<tr>
  <td style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; word-break: break-word">
    <!--[if mso | IE]>
    
        <table role="presentation" border="0" cellpadding="0" cellspacing="0"><tr><td height="16" style="vertical-align:top;height:16px;">
      
    <![endif]-->
    <div style="height: 16px"> &nbsp; </div>
    <!--[if mso | IE]>
    
        </td></tr></table>
      
    <![endif]-->
  </td>
</tr>
<tr>
  <td align="left"
    style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; word-break: break-word">
    <div
      style="color: #000000; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 13px; line-height: 1; text-align: left" align="left">
      <p style="display: block; font-size: 12px !important; font-weight: 500 !important; line-height: 24px !important; margin: 0">
        {%- for field in order.custom_fields -%}
          {{ field.last.label }} — {{ field.last.formatted_value }}{%- unless forloop.last -%}<br>{%- endunless -%}
        {%- endfor -%}
      </p>
    </div>
  </td>
</tr>
{% endif %}