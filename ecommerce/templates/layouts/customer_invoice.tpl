<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>{{ 'ecommerce.invoice.title' | lc | escape_once }}</title>

    <style media="all">
      @font-face {
        font-family: "Avenir Next";
        font-style: normal;
        font-weight: 400;
        src: local('Avenir Next'), url('http://static.voog.com/libs/edicy-tools/latest/svgavenir-next-regular.woff') format('woff');
      }

      @font-face {
        font-family: "Avenir Next";
        font-style: bold;
        font-weight: 700;
        src: local('Avenir Next'), url('http://static.voog.com/libs/edicy-tools/latest/avenir-next-bold.woff') format('woff');
      }

      body {
        font: 12pt/18pt "Avenir Next";
        color: black;
      }

      .container {
        width: 540pt;
        height: 790pt;
        position: relative;
        margin: 22pt auto 0 auto;
      }

      .separator {
        height: 1pt;
        background-color: rgba(0,0,0,0.3);
      }

      .clearfix {
        clear: both;
      }

      .store-name {
        text-align: right;
      }

      .store-name img {
        max-height: 180px;
        max-width: 33%;
      }

      .header {
        font-size: 10pt;
        line-height: 14pt;
        padding-bottom: 14pt;
      }

      .recipient {
        width: 50%;
        float: left;
      }

      .invoice-info {
        text-align: right;
      }

      .invoice-info h2 {
        font-size: 14pt;
        font-weight: bold;
        margin: 0 0 17pt 0;
      }

      .dates {
        display: inline-table;
        white-space: nowrap;
        border-collapse: collapse;
      }

      .dates td:first-child {
        padding-right: 1em;
      }

      .invoice-nr {
        font-size: 24pt;
        font-weight: bold;
        text-align: center;
        padding: 36pt;
        line-height: 33pt;
      }

      .main {
        padding-top: 24pt;
      }

      .items {
        width: 100%;
      }

      .items th {
        font-size: 10pt;
        text-align: right;
        font-weight: bold;
      }

      .items th:first-child {
        text-align: left;
      }

      .items tr, .items th {
        page-break-inside: avoid;
      }

      .items td {
        text-align: right;
      }

      .items td:first-child {
        text-align: left;
        width: 75%;
      }

      .items td:nth-child(2) {
        width: 12%;
      }

      .items-multi td:first-child {
        width: 65%;
      }

      .items-multi td:nth-child(4) {
        width: 10%;
      }

      .items-total {
        padding-top: 18pt;
        page-break-inside: avoid;
      }

      .note {
        padding-top: 18pt;
      }

      .footer {
        width: 540pt;
        page-break-inside: avoid;
        font-size: 10pt;
        line-height: 14pt;
      }

      .footer-singlepage {
        position: absolute;
        bottom: 1pt;
      }

      .footer-multipage {
        margin-top: 30pt;
        page-break-inside: avoid;
      }

      .seller-info {
        padding-top: 15pt;
        padding-bottom: 15pt;
      }

      .seller-info-table {
        width: 100%;
      }

      .seller-info td {
        text-align: center;
        vertical-align: top;
      }

      .seller-info td:first-of-type {
        text-align: left;
      }
      .seller-info td:last-of-type {
        text-align: right;
      }

      .footer-banner {
        padding-top: 22pt;
      }

      .footer-banner-table {
        width: 100%;
      }

      .footer-banner-table td {
        vertical-align: middle;
      }

      .footer-logo {
        text-align: right;
      }

      .footer-logo img {
        display: block;
      }

      .items td.invoice-paid-up {
        font-size: 24px;
        text-align: center;
        padding: 30px 0;
        font-weight: bold;
        color: #e9e9e8;
      }
    </style>

    {% capture dont_render %}
      {% assign order_data_rows = 0 %}
      {% assign items_displayed_discount = 0 %}

      {% unless order.shipping_method == blank %}
        {% assign order_data_rows = order_data_rows | plus: 1 %}
      {% endunless %}

      {% if order.discount %}
        {% if order.discount.applies_to == "cart_and_shipping" %}
          {% assign order_total_original_amount = order.items_original_amount | plus: order.shipping_original_amount %}
          {% assign order_total_subtotal_amount = order.items_subtotal_amount | plus: order.shipping_subtotal_amount %}
          {% assign order_total_discount = order_total_subtotal_amount | minus: order_total_original_amount %}
        {% elsif order.discount.applies_to == "cart" or order.discount.applies_to == "products" %}
          {% assign order_total_discount = order.items_subtotal_amount | minus: order.items_original_amount %}
        {% elsif order.discount.applies_to == "shipping" %}
          {% assign order_total_discount = order.shipping_subtotal_amount | minus: order.shipping_original_amount %}
        {% else %}
          {% assign order_total_discount = 0 %}
        {% endif %}

        {% if order.discount.applies_to_cart? or order.discount.applies_to_shipping? %}
          {% assign order_data_rows = order_data_rows | plus: 1 %}
        {% endif %}
      {% endif %}

      {% if store.image? and order.paid? %}
        {% assign allowed_rows_per_page = 5 %}
      {% elsif store.image? %}
        {% assign allowed_rows_per_page = 10 %}
      {% elsif order.paid? %}
        {% assign allowed_rows_per_page = 9 %}
      {% else %}
        {% assign allowed_rows_per_page = 12 %}
      {% endif %}
    {% endcapture %}
  </head>
  <body>
    <div class="container">
      <h2 class="store-name">
        {% if store.image? %}
          <img src="{{ store.image.url }}" alt="{{ store.company_name | escape }}" />
        {% else %}
          {{ store.company_name | escape_once }}
        {% endif %}
      </h2>
      <div class="header">
        <div class="recipient">
          <b>{{ 'ecommerce.invoice.recipient' | lc | escape_once }}:</b><br/>
          {% if order.billing_address.company_name != blank %}
            {{ order.billing_address.company_name | escape_once }}<br>
          {% elsif order.billing_address.name != blank %}
            {{ order.billing_address.name | escape_once }}<br>
          {% endif %}
          {{ order.billing_address.full_location | escape_once | newline_to_br }}
        </div>

        <div class="invoice-info">
          <table class="dates">
            <tr>
              <td>{{ 'ecommerce.invoice.invoiced_on' | lc | escape_once }}</td>
              <td>{{ order.issued_date | format_date: "long" }}</td>
            </tr>
            <tr>
              <td>{{ 'ecommerce.invoice.due_date' | lc | escape_once }}</td>
              <td>{{ order.value_date | format_date: "long" }}</td>
            </tr>
          </table>
        </div>

        <div class="clearfix"></div>
      </div>
      <div class="separator"></div>
      <div class="invoice-nr">
        {{ 'ecommerce.invoice.invoice_no' | lc | escape_once }} {{ order.code | escape_once }}
      </div>
      <div class="separator"></div>
      <div class="main">

        {% if order.tax_amounts.size > 1 %}
        {% comment %}Multi tax invoice{% endcomment %}

        <table class="items items-multi">
          <thead>
            <tr>
              <th>{{ 'ecommerce.invoice.item' | lc | escape_once }}</th>
              <th>{{ 'ecommerce.invoice.quantity' | lc | escape_once }}</th>
              <th>{{ 'ecommerce.invoice.vat' | lc | escape_once }}</th>
              <th>{{ 'ecommerce.invoice.price' | lc | escape_once }}</th>
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
                  {{ item.product_name | escape_once }}{% if item.product_is_variant %} ({{ item.product_variant_description | escape_once }}){% endif %}{% unless item.note == blank %} ({{ item.note | escape_once }}){% endunless %}
                </td>
                <td>{{ 'ecommerce.invoice.items' | lcc: item.quantity }}</td>
                <td>{% assign tax_rate_int = item.tax_rate | floor %}{% if tax_rate_int == item.tax_rate %}{{ tax_rate_int }}{% else %}{{ item.tax_rate }}{% endif %}%</td>
                <td>{{ item_products_original_price | money_with_currency: order.currency }}</td>
              </tr>

              {% if order.discount != blank and order.discount.applies_to_cart? %}
                {% assign display_discount_row = false %}
              {% elsif item.has_item_discount == false %}
                {% assign display_discount_row = false %}
              {% else %}
                {% assign display_discount_row = true %}
              {% endif %}

              {% if display_discount_row %}
                {% assign
                  item_discount = item.subtotal_amount | minus: item_products_original_price
                %}
                {% assign
                  items_displayed_discount = items_displayed_discount | plus: item_discount
                %}

                <tr>
                  <td>
                    {{ 'ecommerce.invoice.discount' | lc | escape_once }}

                    {% if order.discount.fixed? and item.discount != blank %}
                      -{{ order.discount.amount | money_with_currency: order.discount.currency }}
                    {% endif %}
                  </td>

                  {% if order.discount.percentage? and item.discount != blank %}
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
                  {{ 'ecommerce.invoice.discount_cart' | lc | escape_once }}

                  {% if order.discount.fixed? %}
                    -{{ order.discount.amount | money_with_currency: order.discount.currency }}
                  {% endif %}
                </td>

                {% if order.discount.percentage? %}
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
                <td>{{ 'ecommerce.invoice.shipping' | lc | escape_once }}: {{ order.shipping_method.name | escape_once }}{% if order.shipping_method.option != blank %} — {{ order.shipping_method.option | escape_once }}{% endif %}</td>
                <td></td>
                <td>{% assign tax_rate_int = order.shipping_tax_rate | floor %}{% if tax_rate_int == order.shipping_tax_rate %}{{ tax_rate_int }}{% else %}{{ order.shipping_tax_rate }}{% endif %}%</td>
                <td>{{ order.shipping_original_amount | money_with_currency: order.currency }}</td>
              </tr>

              {% if order.cart_rules_applied != true
                and order.discount
                and order.discount.applies_to_shipping?
              %}
                <tr>
                  <td>
                    {% if order.discount.applies_to == "shipping" %}
                      {{ 'ecommerce.invoice.discount_shipping' | lc | escape_once }}
                    {% else %}
                      {{ 'ecommerce.invoice.discount_cart_and_shipping' | lc | escape_once }}
                    {% endif %}

                    {% if order.discount.discount_type == "fixed" %}
                      -{{ order.discount.amount | money_with_currency: order.discount.currency }}
                    {% endif %}
                  </td>

                  {% if order.discount.fixed? %}
                    <td>-{{ order.discount.amount | strip_insignificant_zeros }}%</td>
                  {% else %}
                    <td>{{ 'ecommerce.invoice.items' | lcc: 1 }}</td>
                  {% endif %}

                  <td></td>

                  {% if order.discount.percentage? %}
                    <td>{{ order.shipping_subtotal_amount | minus: order.shipping_original_amount | money_with_currency: order.currency }}</td>
                  {% else %}
                    <td>{{ order_total_discount | money_with_currency: order.currency }}</td>
                  {% endif %}
                </tr>
              {% endif %}
            {% endunless %}

            {% if order.cart_rules_applied and order.effective_discount? %}
              <tr>
                <td>{{ 'ecommerce.invoice.discount' | lc | escape_once }}</td>
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
                {{ 'ecommerce.invoice.invoice_paid_up' | lc | escape_once }}
              </td>
            </tr>
            {% endif %}

            <tr>
              <td colspan="2"></td>
              <td>{{ 'ecommerce.invoice.total' | lc | escape_once }}</td>
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
                <td>{{ 'ecommerce.invoice.total_discount' | lc | escape_once }}</td>
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
                  {{ 'ecommerce.invoice.vat' | lc | escape_once }}
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
              <td><b>{{ 'ecommerce.invoice.to_be_paid' | lc | escape_once }}</b></td>
              <td><b>{{ order.total_amount | money_with_currency: order.currency }}</b></td>
            </tr>
          </tbody>
        </table>

        {% else %}
        {% comment %}Single tax invoice{% endcomment %}

        <table class="items">
          <thead>
            <tr>
              <th>{{ 'ecommerce.invoice.item' | lc | escape_once }}</th>
              <th>{{ 'ecommerce.invoice.quantity' | lc | escape_once }}</th>
              <th>{{ 'ecommerce.invoice.price' | lc | escape_once }}</th>
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
                  {{ item.product_name | escape_once }}{% unless item.note == blank %} ({{ item.note | escape_once }}){% endunless %}{% if item.product_is_variant %} ({{ item.product_variant_description | escape_once }}){% endif %}
                </td>
                <td>{{ 'ecommerce.invoice.items' | lcc: item.quantity }}</td>
                <td>{{ item_products_original_price | money_with_currency: order.currency }}</td>
              </tr>

              {% if order.discount != blank and order.discount.applies_to_cart? %}
                {% assign display_discount_row = false %}
              {% elsif item.has_item_discount == false %}
                {% assign display_discount_row = false %}
              {% else %}
                {% assign display_discount_row = true %}
              {% endif %}

              {% if display_discount_row %}
                {% assign
                  item_discount = item.subtotal_amount | minus: item_products_original_price
                %}
                {% assign
                  items_displayed_discount = items_displayed_discount | plus: item_discount
                %}

                <tr>
                  <td>
                    {{ 'ecommerce.invoice.discount' | lc | escape_once }}

                    {% if order.discount.fixed? and item.discount != blank %}
                      -{{ order.discount.amount | money_with_currency: order.discount.currency }}
                    {% endif %}
                  </td>

                  {% if order.discount.percentage? and item.discount != blank %}
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
                  {{ 'ecommerce.invoice.discount_cart' | lc | escape_once }}

                  {% if order.discount.fixed? %}
                    -{{ order.discount.amount | money_with_currency: order.discount.currency }}
                  {% endif %}
                </td>

                {% if order.discount.percentage? %}
                  <td>-{{ order.discount.amount | strip_insignificant_zeros }}%</td>
                {% else %}
                  <td>{{ 'ecommerce.invoice.items' | lcc: 1 }}</td>
                {% endif %}

                <td>{{ order_total_discount | money_with_currency: order.currency }}</td>
              </tr>
            {% endif %}

            {% unless order.shipping_method == blank %}
              <tr>
                <td>{{ 'ecommerce.invoice.shipping' | lc | escape_once }}: {{ order.shipping_method.name | escape_once }}{% if order.shipping_method.option != blank %} — {{ order.shipping_method.option | escape_once }}{% endif %}</td>
                <td></td>
                <td>{{ order.shipping_original_amount | money_with_currency: order.currency }}</td>
              </tr>

              {% if order.cart_rules_applied != true
                and order.discount
                and order.discount.applies_to_shipping?
              %}
                <tr>
                  <td>
                    {% if order.discount.applies_to == "shipping" %}
                      {{ 'ecommerce.invoice.discount_shipping' | lc | escape_once }}
                    {% else %}
                      {{ 'ecommerce.invoice.discount_cart_and_shipping' | lc | escape_once }}
                    {% endif %}

                    {% if order.discount.fixed? %}
                      -{{ order.discount.amount | money_with_currency: order.discount.currency }}
                    {% endif %}
                  </td>

                  {% if order.discount.percentage? %}
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
                <td>{{ 'ecommerce.invoice.discount' | lc | escape_once }}</td>
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
                {{ 'ecommerce.invoice.invoice_paid_up' | lc | escape_once }}
              </td>
            </tr>
            {% endif %}

            {% if order.tax_amounts.first.tax_rate > 0 %}
              <tr>
                <td></td>
                <td>{{ 'ecommerce.invoice.total' | lc | escape_once }}</td>
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
                  <td>{{ 'ecommerce.invoice.total_discount' | lc | escape_once }}</td>
                  <td>
                    -{{ order.effective_discount_amount | money_with_currency: order.currency }}
                  </td>
                </tr>
              {% endif %}

              {% for rate_amounts in order.tax_amounts %}
                <tr>
                  <td></td>
                  <td>
                    {{ 'ecommerce.invoice.vat' | lc | escape_once }}
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
              <td><b>{{ 'ecommerce.invoice.to_be_paid' | lc | escape_once }}</b></td>
              <td><b>{{ order.total_amount | money_with_currency: order.currency }}</b></td>
            </tr>
          </tbody>
        </table>
        {% endif %}

        {% comment %} Order note {% endcomment %}
        {% unless order.note == blank %}
        <table class="note">
          <tbody>
            <td>{{ 'ecommerce.invoice.note' | lc | escape_once }}: {{ order.note | escape_once }}</td>
          </tbody>
        </table>
        {% endunless %}
      </div>

      {% if order_data_rows >= allowed_rows_per_page %}
        {% assign footer_class = "footer-multipage" %}
      {% else %}
        {% assign footer_class = "footer-singlepage" %}
      {% endif %}

      <div class="footer {{ footer_class }}">
        <div class="separator"></div>
        <div class="seller-info">
          <table class="seller-info-table">
            <tr>
              <td class="address1">
                {% if store.address.company_name != blank %}<b>{{ store.address.company_name | escape_once }}</b><br>{% endif %}
                {{ store.address.full_location | escape_once | newline_to_br }}
              </td>
              <td class="address2">
              </td>
              <td class="payment-info">
                {{ store.bank_details | escape_once | newline_to_br }}
              </td>
            </tr>
          </table>
        </div>
        <div class="separator"></div>
        {% if store.invoice_branding %}
        <div class="footer-banner">
          <table class="footer-banner-table">
            <tr>
              <td>
                {{ 'ecommerce.invoice.footer_text' | lc | escape_once }}
              </td>
              <td class="footer-logo">
                <img src="http://static.voog.com/libs/edicy-tools/latest/voog-logo-brand-blue.svg" alt="" />
              </td>
            </tr>
          </table>
        </div>
        {% endif %}
      </div>
    </div>
  </body>
</html>
