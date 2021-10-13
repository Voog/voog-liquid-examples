{
  "ecommerce_core": {
    "customer_mailer": {
      "offline_invoice_notification": {
        "heading": "Información de compra",
        "intro": "Gracias por realizar tu compra en nuestra tienda en línea, %{store_name}. Elegiste la opción de pago fuera de línea, de modo que aquí tienes la factura y las instrucciones de pago. Te enviaremos el pedido una vez recibido el pago. ¿Tienes alguna pregunta? Ponte en contacto con nosotros en cualquier momento en %{store_email}.",
        "preview": "Gracias por su compra.",
        "subject": "Factura %{code} de %{store_name}"
      },
      "payment_notification": {
        "body": "Gracias por tu compra en %{store_name}. Hemos recibido el pago de manera correcta. Podrás encontrar la factura abonada en el archivo adjunto. Te enviaremos el pedido lo antes posible. ¿Tienes alguna pregunta? Ponte en contacto con nosotros en %{store_email}.",
        "heading": "Confirmación de compra",
        "subject": "Factura %{code} de %{store_name}"
      },
      "payment_status_notification": {
        "body": "Se ha confirmado el pago de tu pedido %{code} y te lo enviaremos lo antes posible.",
        "heading": "Pago confirmado",
        "subject": "Confirmado el pago del pedido %{code}"
      }
    },
    "shared": {
      "mailers": {
        "invoice_filename": "factura_%{code}.pdf",
        "order": "Pedido %{code}",
        "order_details": {
          "additional_details": "Información adicional",
          "address": "Dirección",
          "billing_address": "Dirección de facturación",
          "company_name": "Nombre de la empresa",
          "customer_language": "Idioma del cliente",
          "date": "Fecha",
          "description": "Descripción",
          "discount": "Descuento",
          "discount_cart": "Descuento en todos los artículos",
          "discount_cart_and_shipping": "Descuento en todos los artículos y el envío",
          "discount_code": "Código de descuento",
          "discount_shipping": "Descuento en el envío",
          "full_address": "Dirección",
          "information": "Detalles",
          "instructions": "Albaranes",
          "invoice_for_order": "Factura del pedido %{code}",
          "item": {
            "one": "1 artículo",
            "other": "%{count} artículos"
          },
          "name": "Nombre",
          "note": "Observaciones",
          "order_details": "Detalles del pedido",
          "payment_instructions": "Instrucciones de pago",
          "phone": "Teléfono",
          "pod_name": "Ubicación",
          "recipient": "Destinatario",
          "shipping": "Envío",
          "shipping_address": "Dirección de envío",
          "total": "Total",
          "vat": "IVA"
        }
      }
    }
  },
  "mailers": {
    "common": {
      "delivered_to": "Enviado a %{email} por %{brand}",
      "shop_powered_by": "Tienda desarrollada con %{brand}"
    }
  }
}