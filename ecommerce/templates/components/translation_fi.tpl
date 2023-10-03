{
  "ecommerce_core": {
    "customer_mailer": {
      "offline_invoice_notification": {
        "heading": "Tilaustiedot",
        "intro": "Kiitos ostostasi verkkokaupassamme %{store_name}. Valitsit offline-maksun, joten tässä on lasku ja maksuohjeet. Toimitamme tilauksen, kun olemme vastaanottaneet maksun. Kysymyksiä? Ota yhteyttä lähettämällä sähköpostia osoitteeseen %{store_email}.",
        "preview": "Kiitos ostoksestasi.",
        "subject": "Lasku %{code} kaupasta %{store_name}"
      },
      "payment_notification": {
        "body": "Kiitos tilauksestasi verkkokaupassamme %{store_name}. Olemme vastaanottaneet maksusi onnistuneesti. Kuitti maksusta on liitteessä.\nTilauksesi lähetetään mahdollisimman pian. Onko sinulla kysymyksiä? Ota yhteyttä lähettämällä sähköpostia osoitteeseen %{store_email}.",
        "heading": "Maksun kuittaus",
        "subject": "Kuitti %{code} kaupasta %{store_name}"
      },
      "payment_status_notification": {
        "body": "Maksusi tilaukselle %{code} on vahvistettu. Tilaus toimitetaan mahdollisimma pian.",
        "heading": "Maksu vahvistettu",
        "subject": "Maksu on hyväksytty tilaukselle %{code}"
      }
    },
    "shared": {
      "mailers": {
        "invoice_filename": "lasku_%{code}.pdf",
        "order": "Tilaus %{code}",
        "order_details": {
          "additional_details": "Lisätiedot",
          "address": "Osoite",
          "billing_address": "Laskutusosoite",
          "company_name": "Yrityksen nimi",
          "customer_language": "Asiakkaan kieli",
          "date": "Päiväys",
          "description": "Kuvaus",
          "discount": "Alennus",
          "discount_cart": "Alennus kaikille tuotteille",
          "discount_cart_and_shipping": "Alennus kaikille tuotteille ja toimitusmaksuille",
          "discount_code": "Alennuskoodi",
          "discount_shipping": "Alennus toimitusmaksulle",
          "full_address": "Osoite",
          "information": "Tiedot",
          "instructions": "Viesti kaupalle",
          "invoice_for_order": "Lasku tilaukseen %{code}",
          "item": {
            "one": "1 kpl",
            "other": "%{count} kpl"
          },
          "name": "Nimi",
          "note": "Kuitti",
          "order_details": "Tilauksen tiedot",
          "payment_instructions": "Maksuohjeet",
          "phone": "Puhelin",
          "pod_name": "Paikka",
          "recipient": "Vastaanottaja",
          "shipping": "Toimituskulut",
          "shipping_address": "Toimitusosoite",
          "total": "Yhteensä",
          "vat": "ALV"
        }
      }
    }
  },
  "mailers": {
    "common": {
      "delivered_to": "Toimitettu osoitteeseen %{email} %{brand}in toimesta",
      "shop_powered_by": "Kaupan tarjoaa %{brand}"
    }
  }
}