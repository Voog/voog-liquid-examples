<td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; vertical-align: top !important; width: 50% !important" valign="top !important">
  <div style="font-size: 16px !important; font-weight: bold !important; line-height: 28px !important; margin-bottom: 13px !important">
    {{ translations.ecommerce_core.shared.mailers.order_details.shipping_address }}
  </div>
  {% if order.shipping_address.name != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.name }} — {{ order.shipping_address.name | escape_once }}<br>
  {% endif %}
  {% if order.shipping_address.company_name != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.company_name }} — {{ order.shipping_address.company_name | escape_once }}<br>
  {% endif %}
  {% if order.shipping_address.phone != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.phone }} — {{ order.shipping_address.phone | escape_once }}<br>
  {% endif %}
  {% if order.shipping_address.pod_name != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.pod_name }} — {{ order.shipping_address.pod_name }}<br>
  {% endif %}
  {% if order.shipping_address.full_location != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.address }} — {{ order.shipping_address.full_location | escape_once }}<br>
  {% endif %}
  {% if order.shipping_address.instructions != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.instructions }} — {{ order.shipping_address.instructions | escape_once }}
  {% endif %}
</td>