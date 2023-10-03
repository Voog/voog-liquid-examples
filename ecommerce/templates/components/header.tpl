<!--[if !mso]><!-- -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--<![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!--[if mso]>
  <xml>
  <o:OfficeDocumentSettings>
    <o:AllowPNG/>
    <o:PixelsPerInch>96</o:PixelsPerInch>
  </o:OfficeDocumentSettings>
  </xml>
<![endif]-->
<!--[if lte mso 11]>
  <style type="text/css">
    .mj-outlook-group-fix { width:100% !important; }
  </style>
<![endif]-->

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
