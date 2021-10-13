{
  "ecommerce_core": {
    "customer_mailer": {
      "offline_invoice_notification": {
        "heading": "Aankoopinformatie",
        "intro": "Bedankt voor uw aankoop in onze webwinkel, %{store_name}. U hebt gekozen voor de offline betaaloptie, daarom zijn hier de factuur en de betaalinstructies. Wij verzenden uw bestelling zodra de betaling binnen is. Hebt u nog vragen? Neem dan contact met ons op via %{store_email}.",
        "preview": "Bedankt voor uw aankoop.",
        "subject": "Factuur %{code} van %{store_name}"
      },
      "payment_notification": {
        "body": "Bedankt voor uw aankoop bij %{store_name}. Wij hebben uw betaling ontvangen en hebben u de voldaan-factuur als bijlage meegestuurd.\nUw bestelling wordt zo snel mogelijk verstuurd. Vragen? Neem contact op via %{store_email}.",
        "heading": "Aankoopbevestiging",
        "subject": "Factuur %{code} van %{store_name}"
      },
      "payment_status_notification": {
        "body": "Uw betaling voor bestelling %{code} is goedgekeurd en uw bestelling zal zo snel mogelijk worden verzonden.",
        "heading": "Betaling goedgekeurd",
        "subject": "Betaling goedgekeurd voor bestelling %{code}"
      }
    },
    "shared": {
      "mailers": {
        "invoice_filename": "factuur_%{code}.pdf",
        "order": "Bestelling %{code}",
        "order_details": {
          "additional_details": "Aanvullende gegevens",
          "address": "Adres",
          "billing_address": "Factuuradres",
          "company_name": "Bedrijfsnaam",
          "customer_language": "Taal van de klant",
          "date": "Datum",
          "description": "Beschrijving",
          "discount": "Korting",
          "discount_cart": "Korting op alle artikelen",
          "discount_cart_and_shipping": "Korting op alle artikelen en op verzending",
          "discount_code": "Kortingscode",
          "discount_shipping": "Korting op verzending",
          "full_address": "Adres",
          "information": "Informatie",
          "instructions": "Opmerkingen in verband met bezorging ",
          "invoice_for_order": "Factuur voor bestelling %{code}",
          "item": {
            "one": "1 artikel",
            "other": "%{count} artikelen"
          },
          "name": "Naam",
          "note": "Opmerking",
          "order_details": "Details bestelling",
          "payment_instructions": "Betaalinstructies",
          "phone": "Telefoon",
          "pod_name": "Locatie",
          "recipient": "Ontvanger",
          "shipping": "Verzending",
          "shipping_address": "Verzendadres",
          "total": "Totaal",
          "vat": "BTW"
        }
      }
    }
  },
  "mailers": {
    "common": {
      "delivered_to": "Afgeleverd aan %{email} door %{brand}",
      "shop_powered_by": "De winkel wordt aangedreven door %{brand}"
    }
  }
}