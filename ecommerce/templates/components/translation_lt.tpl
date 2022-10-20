{
  "ecommerce_core": {
    "customer_mailer": {
      "offline_invoice_notification": {
        "heading": "Pirkimo informacija",
        "intro": "Dėkojame, kad perkate mūsų interneto parduotuvėje %{store_name}. Pasirinkote mokėjimo ne internetu būdą, todėl pateikiame sąskaitą faktūrą ir mokėjimo nurodymus. Užsakymas bus ruošiamas išsiųsti iškart po to, kai gausime mokėjimą. Jei turite klausimų, bet kuriuo metu kreipkitės į mus adresu %{store_email}.",
        "preview": "Dėkojame už pirkinį.",
        "subject": "Sąskaita faktūra %{code} iš %{store_name}"
      },
      "payment_notification": {
        "body": "Dėkojame už jūsų pirkinį parduotuvėje %{store_name}. Sėkmingai gavome jūsų mokėjimą, o apmokėtą sąskaitą faktūrą rasite priede.\nJūsų užsakymas bus išsiųstas kuo įmanoma greičiau. Jei turite klausimų, susisiekite per %{store_email}.",
        "heading": "Pirkimo patvirtinimas",
        "subject": "Sąskaita faktūra %{code} iš %{store_name}"
      },
      "payment_status_notification": {
        "body": "Jūsų užsakymo %{code} mokėjimas patvirtintas, ir užsakymą išsiųsime kuo įmanoma greičiau.",
        "heading": "Mokėjimas patvirtintas",
        "subject": "Užsakymo %{code} apmokėjimas patvirtintas"
      }
    },
    "shared": {
      "mailers": {
        "invoice_filename": "invoice_%{code}.pdf",
        "order": "Užsakymas %{code}",
        "order_details": {
          "additional_details": "Papildomi duomenys",
          "address": "Adresas",
          "billing_address": "Mokėjimo adresas",
          "company_name": "Įmonės pavadinimas",
          "customer_language": "Kliento kalba",
          "date": "Data",
          "description": "Aprašymas",
          "discount": "Nuolaida",
          "discount_cart": "Nuolaida visoms prekėms",
          "discount_cart_and_shipping": "Nuolaida visoms prekėms ir pristatymui",
          "discount_code": "Nuolaidos kodas",
          "discount_shipping": "Nuolaida pristatymui",
          "full_address": "Adresas",
          "information": "Informacija",
          "instructions": "Pristatymo pastabos",
          "invoice_for_order": "Užsakymo %{code} sąskaita faktūra",
          "item": {
            "one": "1 prekė",
            "few": "%{count} prekės",
            "many": "%{count} prekių",
            "other": "%{count} prekės"
          },
          "name": "Vardas",
          "note": "Pastaba",
          "order_details": "Užsakymo duomenys",
          "payment_instructions": "Mokėjimo nurodymai",
          "phone": "Telefonas",
          "pod_name": "Vieta",
          "recipient": "Gavėjas",
          "shipping": "Pristatymas",
          "shipping_address": "Pristatymo adresas",
          "total": "Iš viso",
          "vat": "PVM"
        }
      }
    }
  },
  "mailers": {
    "common": {
      "delivered_to": "%{brand} pristatė %{email}",
      "shop_powered_by": "Parduotuvė veikia %{brand} platformoje"
    }
  }
}