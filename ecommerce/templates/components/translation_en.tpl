{
  "ecommerce_core": {
    "customer_mailer": {
      "offline_invoice_notification": {
        "heading": "Purchase info",
        "intro": "Thank you for your purchase at our webstore, %{store_name}. You chose the offline payment option, so here are the invoice and payment instructions. We'll start delivering once the payment is received. Questions? Contact us anytime at %{store_email}.",
        "preview": "Thank you for your purchase.",
        "subject": "Invoice %{code} from %{store_name}"
      },
      "payment_notification": {
        "body": "Thank you for your purchase at %{store_name}. We have successfully received your payment and you can find the paid up invoice in the attachment.\nYour order will be delivered as soon as possible. Questions? Get in contact via %{store_email}.",
        "heading": "Purchase confirmation",
        "subject": "Invoice %{code} from %{store_name}"
      },
      "payment_status_notification": {
        "body": "Your payment for order %{code} has been confirmed, and it will be delivered as soon as possible.",
        "heading": "Payment confirmed",
        "subject": "Payment confirmed for order %{code}"
      }
    },
    "shared": {
      "mailers": {
        "invoice_filename": "invoice_%{code}.pdf",
        "order": "Order %{code}",
        "order_details": {
          "additional_details": "Additional details",
          "address": "Address",
          "billing_address": "Billing address",
          "company_name": "Company name",
          "customer_language": "Customer language",
          "date": "Date",
          "description": "Description",
          "discount": "Discount",
          "discount_cart": "Discount on all items",
          "discount_cart_and_shipping": "Discount on all items and shipping",
          "discount_code": "Discount code",
          "discount_shipping": "Discount on shipping",
          "full_address": "Address",
          "information": "Information",
          "instructions": "Delivery notes",
          "invoice_for_order": "Invoice for order %{code}",
          "item": {
            "one": "1 item",
            "other": "%{count} items"
          },
          "name": "Name",
          "note": "Note",
          "order_details": "Order details",
          "payment_instructions": "Payment instructions",
          "phone": "Phone",
          "pod_name": "Location",
          "recipient": "Recipient",
          "shipping": "Shipping",
          "shipping_address": "Shipping address",
          "sku": "Product code",
          "total": "Total",
          "vat": "VAT"
        }
      }
    }
  },
  "mailers": {
    "common": {
      "delivered_to": "Delivered to %{email} by %{brand}",
      "shop_powered_by": "Shop is powered by %{brand}"
    }
  }
}