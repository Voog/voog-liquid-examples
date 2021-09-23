<td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; vertical-align: top !important; width: 50% !important" valign="top !important">
  <div style="font-size: 16px !important; font-weight: bold !important; line-height: 28px !important; margin-bottom: 13px !important">
    {% if order.addresses_equal? %}
      {{ translations.ecommerce_core.shared.mailers.order_details.address }}
    {% else %}
      {{ translations.ecommerce_core.shared.mailers.order_details.billing_address }}
    {% endif %}
  </div>
  {% if order.billing_address.name != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.name }} — {{ order.billing_address.name | escape_once }}<br>
  {% endif %}
  {% if order.billing_address.company_name != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.company_name }} — {{ order.billing_address.company_name | escape_once }}<br>
  {% endif %}
  {% if order.billing_address.phone != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.phone }} — {{ order.billing_address.phone | escape_once }}<br>
  {% endif %}
  {% if order.billing_address.email != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.email}} — {{ order.billing_address.email | escape_once }}<br>
  {% endif %}
  {% if order.billing_address.full_location != blank %}
    {{ translations.ecommerce_core.shared.mailers.order_details.full_address }} — {{ order.billing_address.full_location | escape_once }}
  {% endif %}
</td>