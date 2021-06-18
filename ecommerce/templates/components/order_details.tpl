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
<div class="main">

  {% if order.tax_amounts.size > 1 %}
  {% comment %}Multi tax invoice{% endcomment %}

  <table class="items items-multi">
    <thead>
      <tr>
        <th>{{ 'ecommerce.invoice.item' | lc }}</th>
        <th>{{ 'ecommerce.invoice.quantity' | lc }}</th>
        <th>{{ 'ecommerce.invoice.vat' | lc }}</th>
        <th>{{ 'ecommerce.invoice.price' | lc }}</th>
      </tr>
    </thead>
    <tbody>
      {% for item in order.items %}
        {% if item.has_item_discount %}
          {% assign order_data_rows = order_data_rows | plus: 2 %}
        {% else %}
          {% assign order_data_rows = order_data_rows | plus: 1 %}
        {% endif %}

        {% assign item_products_original_price = item.original_price | times: item.quantity %}

        <tr>
          <td>
            {{ item.product_name }}{% if item.product_is_variant %} ({{ item.product_variant_description }}){% endif %}{% unless item.note == blank %} ({{ item.note }}){% endunless %}
          </td>
          <td>{{ 'ecommerce.invoice.items' | lcc: item.quantity }}</td>
          <td>{% assign tax_rate_int = item.tax_rate | floor %}{% if tax_rate_int == item.tax_rate %}{{ tax_rate_int }}{% else %}{{ item.tax_rate }}{% endif %}%</td>
          <td>{{ item_products_original_price | money_with_currency: order.currency }}</td>
        </tr>

        {% if item.has_item_discount %}
          {% assign
            item_discount = item.subtotal_amount | minus: item_products_original_price
          %}
          {% assign
            items_displayed_discount = items_displayed_discount | plus: item_discount
          %}

          <tr>
            <td>
              {{ 'ecommerce.invoice.discount' | lc }}

              {% if order.discount.discount_type == "fixed" %}
                -{{ order.discount.amount | money_with_currency: order.discount.currency }}
              {% endif %}
            </td>

            {% if order.discount.discount_type == "percentage" %}
              <td>-{{ order.discount.amount | strip_insignificant_zeros }}%</td>
            {% else %}
              <td>{{ 'ecommerce.invoice.items' | lcc: item.quantity }}</td>
            {% endif %}
            <td></td>
            <td>{{ item_discount | money_with_currency: order.currency }}</td>
          </tr>
        {% endif %}
      {% endfor %}

      {% if order.discount and order.discount.applies_to == "cart" %}
        {% assign
          items_displayed_discount = items_displayed_discount | plus: order_total_discount
        %}

        <tr>
          <td>
            {{ 'ecommerce.invoice.discount_cart' | lc }}

            {% if order.discount.discount_type == "fixed" %}
              -{{ order.discount.amount | money_with_currency: order.discount.currency }}
            {% endif %}
          </td>

          {% if order.discount.discount_type == "percentage" %}
            <td>-{{ order.discount.amount | strip_insignificant_zeros }}%</td>
          {% else %}
            <td>{{ 'ecommerce.invoice.items' | lcc: 1 }}</td>
          {% endif %}

          <td></td>
          <td>{{ order_total_discount | money_with_currency: order.currency }}</td>
        </tr>
      {% endif %}

      {% unless order.shipping_method == blank %}
        <tr>
          <td>{{ 'ecommerce.invoice.shipping' | lc }}: {{ order.shipping_method.name }}{% if order.shipping_method.option != blank %} — {{ order.shipping_method.option }}{% endif %}</td>
          <td></td>
          <td>{% assign tax_rate_int = order.shipping_tax_rate | floor %}{% if tax_rate_int == order.shipping_tax_rate %}{{ tax_rate_int }}{% else %}{{ order.shipping_tax_rate }}{% endif %}%</td>
          <td>{{ order.shipping_original_amount | money_with_currency: order.currency }}</td>
        </tr>

        {% if order.cart_rules_applied != true
          and order.discount
          and discount_applies_to_cart_and_or_shipping
        %}
          <tr>
            <td>
              {% if order.discount.applies_to == "shipping" %}
                {{ 'ecommerce.invoice.discount_shipping' | lc }}
              {% else %}
                {{ 'ecommerce.invoice.discount_cart_and_shipping' | lc }}
              {% endif %}

              {% if order.discount.discount_type == "fixed" %}
                -{{ order.discount.amount | money_with_currency: order.discount.currency }}
              {% endif %}
            </td>

            {% if order.discount.discount_type == "percentage" %}
              <td>-{{ order.discount.amount | strip_insignificant_zeros }}%</td>
            {% else %}
              <td>{{ 'ecommerce.invoice.items' | lcc: 1 }}</td>
            {% endif %}

            <td></td>

            {% if order.discount.applies_to == "shipping" %}
              <td>{{ order.shipping_subtotal_amount | minus: order.shipping_original_amount | money_with_currency: order.currency }}</td>
            {% else %}
              <td>{{ order_total_discount | money_with_currency: order.currency }}</td>
            {% endif %}
          </tr>
        {% endif %}
      {% endunless %}

      {% if order.cart_rules_applied and order.effective_discount? %}
        <tr>
          <td>{{ 'ecommerce.invoice.discount' | lc }}</td>
          <td></td>
          <td></td>
          <td>-{{
            order.effective_discount_amount
            | plus: items_displayed_discount
            | money_with_currency: order.currency
          }}</td>
        </tr>
      {% endif %}
    </tbody>
  </table>

  <table class="items items-multi items-total">
    <tbody>
      {% if order.paid? %}
      <tr>
        <td colspan="4" class="invoice-paid-up">
          {{ 'ecommerce.invoice.invoice_paid_up' | lc }}
        </td>
      </tr>
      {% endif %}

      <tr>
        <td colspan="2"></td>
        <td>{{ 'ecommerce.invoice.total' | lc }}</td>
        <td>
          {{
            order.items_original_amount |
            plus: order.shipping_original_amount |
            money_with_currency: order.currency
          }}
        </td>
      </tr>

      {% if order.effective_discount? %}
        <tr>
          <td></td>
          <td></td>
          <td>{{ 'ecommerce.invoice.total_discount' | lc }}</td>
          <td>
            -{{ order.effective_discount_amount | money_with_currency: order.currency }}
          </td>
        </tr>
      {% endif %}

      {% for rate_amounts in order.tax_amounts %}
        <tr>
          <td></td>
          <td></td>
          <td>
            {{ 'ecommerce.invoice.vat' | lc }}
            {% assign tax_rate_int = rate_amounts.tax_rate | floor %}
            {% if tax_rate_int == rate_amounts.tax_rate %}
              {{ tax_rate_int }}%
            {% else %}
              {{ rate_amounts.tax_rate }}%
            {% endif %}
          </td>
          <td>
            {{ rate_amounts.tax_amount | money_with_currency: order.currency }}
          </td>
        </tr>
      {% endfor %}

      <tr class="price-summary">
        <td></td>
        <td></td>
        <td><b>{{ 'ecommerce.invoice.to_be_paid' | lc }}</b></td>
        <td><b>{{ order.total_amount | money_with_currency: order.currency }}</b></td>
      </tr>
    </tbody>
  </table>

  {% else %}
  {% comment %}Single tax invoice{% endcomment %}

  <table class="items">
    <thead>
      <tr>
        <th>{{ 'ecommerce.invoice.item' | lc }}</th>
        <th>{{ 'ecommerce.invoice.quantity' | lc }}</th>
        <th>{{ 'ecommerce.invoice.price' | lc }}</th>
      </tr>
    </thead>
    <tbody>
      {% for item in order.items %}
        {% if item.has_item_discount %}
          {% assign order_data_rows = order_data_rows | plus: 2 %}
        {% else %}
          {% assign order_data_rows = order_data_rows | plus: 1 %}
        {% endif %}

        {% assign item_products_original_price = item.original_price | times: item.quantity %}

        <tr>
          <td>
            {{ item.product_name }}{% unless item.note == blank %} ({{ item.note }}){% endunless %}{% if item.product_is_variant %} ({{ item.product_variant_description }}){% endif %}
          </td>
          <td>{{ 'ecommerce.invoice.items' | lcc: item.quantity }}</td>
          <td>{{ item_products_original_price | money_with_currency: order.currency }}</td>
        </tr>

        {% if item.has_item_discount %}
          {% assign
            item_discount = item.subtotal_amount | minus: item_products_original_price
          %}
          {% assign
            items_displayed_discount = items_displayed_discount | plus: item_discount
          %}

          <tr>
            <td>
              {{ 'ecommerce.invoice.discount' | lc }}

              {% if order.discount.discount_type == "fixed" %}
                -{{ order.discount.amount | money_with_currency: order.discount.currency }}
              {% endif %}
            </td>

            {% if order.discount.discount_type == "percentage" %}
              <td>-{{ order.discount.amount | strip_insignificant_zeros }}%</td>
            {% else %}
              <td>{{ 'ecommerce.invoice.items' | lcc: item.quantity }}</td>
            {% endif %}
            <td>{{ item_discount | money_with_currency: order.currency }}</td>
          </tr>
        {% endif %}
      {% endfor %}

      {% if order.discount and order.discount.applies_to == "cart" %}
        {% assign
          items_displayed_discount = items_displayed_discount | plus: order_total_discount
        %}

        <tr>
          <td>
            {{ 'ecommerce.invoice.discount_cart' | lc }}

            {% if order.discount.discount_type == "fixed" %}
              -{{ order.discount.amount | money_with_currency: order.discount.currency }}
            {% endif %}
          </td>

          {% if order.discount.discount_type == "percentage" %}
            <td>-{{ order.discount.amount | strip_insignificant_zeros }}%</td>
          {% else %}
            <td>{{ 'ecommerce.invoice.items' | lcc: 1 }}</td>
          {% endif %}

          <td>{{ order_total_discount | money_with_currency: order.currency }}</td>
        </tr>
      {% endif %}

      {% unless order.shipping_method == blank %}
        <tr>
          <td>{{ 'ecommerce.invoice.shipping' | lc }}: {{ order.shipping_method.name }}{% if order.shipping_method.option != blank %} — {{ order.shipping_method.option }}{% endif %}</td>
          <td></td>
          <td>{{ order.shipping_original_amount | money_with_currency: order.currency }}</td>
        </tr>

        {% if order.cart_rules_applied != true
          and order.discount
          and discount_applies_to_cart_and_or_shipping
        %}
          <tr>
            <td>
              {% if order.discount.applies_to == "shipping" %}
                {{ 'ecommerce.invoice.discount_shipping' | lc }}
              {% else %}
                {{ 'ecommerce.invoice.discount_cart_and_shipping' | lc }}
              {% endif %}

              {% if order.discount.discount_type == "fixed" %}
                -{{ order.discount.amount | money_with_currency: order.discount.currency }}
              {% endif %}
            </td>

            {% if order.discount.discount_type == "percentage" %}
              <td>-{{ order.discount.amount | strip_insignificant_zeros }}%</td>
            {% else %}
              <td>{{ 'ecommerce.invoice.items' | lcc: 1 }}</td>
            {% endif %}

            {% if order.discount.applies_to == "shipping" %}
              <td>{{ order.shipping_subtotal_amount | minus: order.shipping_original_amount | money_with_currency: order.currency }}</td>
            {% else %}
              <td>{{ order_total_discount | money_with_currency: order.currency }}</td>
            {% endif %}
          </tr>
        {% endif %}
      {% endunless %}

      {% if order.cart_rules_applied and order.effective_discount? %}
        <tr>
          <td>{{ 'ecommerce.invoice.discount' | lc }}</td>
          <td></td>
          <td>-{{
            order.effective_discount_amount
            | plus: items_displayed_discount
            | money_with_currency: order.currency
          }}</td>
        </tr>
      {% endif %}
    </tbody>
  </table>

  <table class="items items-total">
    <tbody>
      {% if order.paid? %}
      <tr>
        <td class="invoice-paid-up" colspan="3">
          {{ 'ecommerce.invoice.invoice_paid_up' | lc }}
        </td>
      </tr>
      {% endif %}

      {% if order.tax_amounts.first.tax_rate > 0 %}
        <tr>
          <td></td>
          <td>{{ 'ecommerce.invoice.total' | lc }}</td>
          <td>
            {{
              order.items_original_amount |
              plus: order.shipping_original_amount |
              money_with_currency: order.currency
            }}
          </td>
        </tr>

        {% if order.effective_discount? %}
          <tr>
            <td></td>
            <td>{{ 'ecommerce.invoice.total_discount' | lc }}</td>
            <td>
              -{{ order.effective_discount_amount | money_with_currency: order.currency }}
            </td>
          </tr>
        {% endif %}

        {% for rate_amounts in order.tax_amounts %}
          <tr>
            <td></td>
            <td>
              {{ 'ecommerce.invoice.vat' | lc }}
              {% assign tax_rate_int = rate_amounts.tax_rate | floor %}
              {% if tax_rate_int == rate_amounts.tax_rate %}
                {{ tax_rate_int }}%
              {% else %}
                {{ rate_amounts.tax_rate }}%
              {% endif %}
            </td>
            <td>
              {{ rate_amounts.tax_amount | money_with_currency: order.currency }}
            </td>
          </tr>
        {% endfor %}
      {% endif %}

      <tr class="price-summary">
        <td></td>
        <td><b>{{ 'ecommerce.invoice.to_be_paid' | lc }}</b></td>
        <td><b>{{ order.total_amount | money_with_currency: order.currency }}</b></td>
      </tr>
    </tbody>
  </table>
  {% endif %}

  {% comment %} Order note {% endcomment %}
  {% unless order.note == blank %}
  <table class="note">
    <tbody>
      <td>{{ 'ecommerce.invoice.note' | lc }}: {{ order.note }}</td>
    </tbody>
  </table>
  {% endunless %}
</div>
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