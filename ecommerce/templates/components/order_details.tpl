<tr>
  <td align="left" style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; word-break: break-word">
    <div style="color: #1b2124; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 16px; font-weight: bold; line-height: 28px; text-align: left" align="left">
      {{ translations.ecommerce_core.shared.mailers.order_details.order_details }}
    </div>
  </td>
</tr>
<tr>
  <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 16px 0px 0px; word-break: break-word">
    <p style="border-top-color: #efefef; border-top-style: solid; border-top-width: 1px; display: block; font-size: 1px; margin: 0 auto; width: 100%"></p>
    <!--[if mso | IE]>
      <table
        align="center" border="0" cellpadding="0" cellspacing="0" style="border-top:solid 1px #efefef;font-size:1px;margin:0px auto;width:560px;" role="presentation" width="560px"
      >
        <tr>
          <td style="height:0;line-height:0;">
            &nbsp;
          </td>
        </tr>
      </table>
    <![endif]-->
  </td>
</tr>
<tr>
  <td align="left" style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; word-break: break-word">
    <table cellpadding="0" cellspacing="0" width="100%" border="0" style="border-collapse: collapse; border: none; color: #1b2124; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 16px; line-height: 28px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; table-layout: auto; width: 100%">
      <tbody>
        {% for item in order.items %}
          {% assign item_products_original_price = item.original_price | times: item.quantity %}
          <tr style="border-bottom-color: #efefef !important; border-bottom-style: solid !important; border-bottom-width: 1px !important; font-size: 14px !important; font-weight: 600 !important; line-height: 20px !important">
            <td style="border-collapse: collapse; font-weight: 700 !important; height: 80px !important; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding-left: 0px !important; white-space: normal !important; width: 67% !important">
              {{ item.product_name }}

              {% if item.note != blank or item.product_is_variant %}
                <br>
                <span style="color: #8d9091 !important; font-size: 12px !important; font-weight: 600 !important; line-height: 16px !important">
                  {% if item.product_is_variant %} {{ item.product_variant_description }}{% endif %}
                  {% unless item.note == blank %} ({{ item.note }}){% endunless %}
                </span>
              {% endif %}

              {% if item.product.sku %}
                <br>
                <span style="color: #8d9091 !important; font-size: 12px !important; font-weight: 600 !important; line-height: 16px !important">
                  {{ translations.ecommerce_core.shared.mailers.order_details.sku }}: {{ item.product.sku }}
                </span>
              {% endif %}
            </td>
            <td style="border-collapse: collapse; height: 80px !important; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding-left: 20px !important; white-space: nowrap !important">
              {{ 'ecommerce.invoice.items' | lcc: item.quantity }}
            </td>
            <td style="border-collapse: collapse; height: 80px !important; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding-left: 20px !important; text-align: right !important; white-space: nowrap !important">
              {{ item_products_original_price | money_with_currency: order.currency }}
              {% if item.has_item_discount %}
                {% assign item_discount = item.subtotal_amount | minus: item_products_original_price %}
                {% assign items_displayed_discount = items_displayed_discount | plus: item_discount %}
                <br>
                <span style="color: #8d9091 !important; font-size: 12px !important; font-weight: 600 !important; line-height: 16px !important">
                {% if order.discount.percentage? and item.discount != blank %}
                  -{{ order.discount.amount | strip_insignificant_zeros }}% ({{ item_discount | money_with_currency: order.discount.currency }})
                {% else %}
                  {{ item_discount | money_with_currency: order.discount.currency }}
                {% endif %}
              </span>
              {% endif %}
            </td>
          </tr>
        {% endfor %}
      </tbody>
    </table>
  </td>
</tr>

<tr>
  <td style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; word-break: break-word">
    <!--[if mso | IE]>

    <table role="presentation" border="0" cellpadding="0" cellspacing="0"><tr><td height="24" style="vertical-align:top;height:24px;">

    <![endif]-->
    <div style="height: 24px"> &nbsp; </div>
    <!--[if mso | IE]>

    </td></tr></table>

    <![endif]-->
  </td>
</tr>
<tr>
  <td align="left" style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; word-break: break-word">
    <table cellpadding="0" cellspacing="0" width="100%" border="0" style="border-collapse: collapse; border: none; color: #000000; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 13px; line-height: 22px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; table-layout: auto; width: 100%">
      <tbody>
        {% if order.discount and order.discount.applies_to == "cart" %}
        {% assign items_displayed_discount = items_displayed_discount | plus: order_total_discount %}
        <tr style="color: #8d9091 !important; font-size: 14px !important; font-weight: 500 !important; line-height: 28px !important; text-align: right !important" align="right">
          <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt">
            {{ 'ecommerce.invoice.discount_cart' | lc }} (
            {%- if order.discount.fixed? -%}
              -{{ order.discount.amount | money_with_currency: order.discount.currency }}
            {%- endif -%}
            {%- if order.discount.percentage? -%}
              -{{ order.discount.amount | strip_insignificant_zeros }}%
            {%- endif -%})
          </td>
          <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding-left: 32px !important; white-space: nowrap !important; width: 1px !important">
            {{ order_total_discount | money_with_currency: order.currency }}
          </td>
        </tr>
        {% endif %}
        {% unless order.shipping_method == blank %}
        <tr style="color: #8d9091 !important; font-size: 14px !important; font-weight: 500 !important; line-height: 28px !important; text-align: right !important" align="right">
          <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt">
            {{ 'ecommerce.invoice.shipping' | lc }}
            ({{ order.shipping_method.name }}{% if order.shipping_method.option != blank %} — {{ order.shipping_method.option }}{% endif %})
          </td>
          <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding-left: 32px !important; white-space: nowrap !important; width: 1px !important">
            {{ order.shipping_original_amount | money_with_currency: order.currency }}
          </td>
        </tr>
        {% if order.cart_rules_applied != true and order.discount and order.discount.applies_to_shipping? %}
        <tr style="color: #8d9091 !important; font-size: 14px !important; font-weight: 500 !important; line-height: 28px !important; text-align: right !important" align="right">
          <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt">
            {% if order.discount.applies_to == "shipping" %}
              {{ 'ecommerce.invoice.discount_shipping' | lc }}
            {% else %}
              {{ 'ecommerce.invoice.discount_cart_and_shipping' | lc }}
            {% endif %}

            {% if order.discount.fixed? %}
              (-{{ order.discount.amount | money_with_currency: order.discount.currency }})
            {% endif %}
            {% if order.discount.percentage? %}
              (-{{ order.discount.amount | strip_insignificant_zeros }}%)
            {% endif %}

          </td>

          <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding-left: 32px !important; white-space: nowrap !important; width: 1px !important">
            {% if order.discount.applies_to == "shipping" %}
              {{ order.shipping_subtotal_amount | minus: order.shipping_original_amount | money_with_currency: order.currency }}
            {% else %}
              {{ order_total_discount | money_with_currency: order.currency }}
            {% endif %}
          </td>
        </tr>
        {% endif %}
        {% endunless %}
        {% if order.cart_rules_applied and order.effective_discount? %}
        <tr style="color: #8d9091 !important; font-size: 14px !important; font-weight: 500 !important; line-height: 28px !important; text-align: right !important" align="right">
          <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt">
            {{ 'ecommerce.invoice.discount' | lc }}
          </td>
          <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding-left: 32px !important; white-space: nowrap !important; width: 1px !important">
            -{{ order.effective_discount_amount | plus: items_displayed_discount | money_with_currency: order.currency }}
          </td>
        </tr>
        {% endif %}
        {% if order.tax_amounts.first.tax_rate > 0 %}
          {% for rate_amounts in order.tax_amounts %}
          <tr style="color: #8d9091 !important; font-size: 14px !important; font-weight: 500 !important; line-height: 28px !important; text-align: right !important">
            <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt">
              {{ 'ecommerce.invoice.vat' | lc }}
              ({% assign tax_rate_int = rate_amounts.tax_rate | floor %}{% if tax_rate_int == rate_amounts.tax_rate %}{{ tax_rate_int }}%{% else %}{{ rate_amounts.tax_rate }}%{% endif %})
            </td>
            <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding-left: 32px !important; white-space: nowrap !important; width: 1px !important">
              {{ rate_amounts.tax_amount | money_with_currency: order.currency }}
            </td>
          </tr>
          {% endfor %}
        {% endif %}
        <tr style="color: #000000 !important; font-size: 18px !important; font-weight: bold !important; line-height: 32px !important; text-align: right !important">
          <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt">
            {{ 'ecommerce.invoice.total' | lc }}
          </td>
          <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding-left: 32px !important; white-space: nowrap !important; width: 1px !important">
            {{ order.total_amount | money_with_currency: order.currency }}
          </td>
        </tr>
      </tbody>
    </table>
  </td>
</tr>


<tr>
  {% comment %} Order note {% endcomment %}
  {% unless order.note == blank %}
  <table class="note">
    <tbody>
      <td>{{ 'ecommerce.invoice.note' | lc }}: {{ order.note }}</td>
    </tbody>
  </table>
  {% endunless %}
</tr>


<tr>
  <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 32px 0px 16px; word-break: break-word">
    <p style="border-top-color: #efefef; border-top-style: solid; border-top-width: 1px; display: block; font-size: 1px; margin: 0 auto; width: 100%"></p>
    <!--[if mso | IE]>
      <table
        align="center" border="0" cellpadding="0" cellspacing="0" style="border-top:solid 1px #efefef;font-size:1px;margin:0px auto;width:560px;" role="presentation" width="560px"
      >
        <tr>
          <td style="height:0;line-height:0;">
            &nbsp;
          </td>
        </tr>
      </table>
    <![endif]-->
  </td>
</tr>
