{
  "ecommerce_core": {
    "customer_mailer": {
      "offline_invoice_notification": {
        "heading": "Infos sur l’achat",
        "intro": "Nous vous remercions de votre achat dans notre boutique en ligne, %{store_name}. Vous avez choisi l'option de paiement hors connexion, voici donc la facture ainsi que les instructions concernant le paiement. Nous allons procéder à la livraison une fois le paiement reçu. Des questions ? Contactez-nous à tout moment à %{store_email}.",
        "preview": "Merci pour votre achat.",
        "subject": "Facture %{code} à part de %{store_name}"
      },
      "payment_notification": {
        "body": "Merci pour votre achat chez %{store_name}. Nous avons bien réceptionné votre paiement et annexé la facture réglée en pièce jointe.\nVotre commande sera expédiée dès que possible. Des questions? Entrez en contact via %{store_email}.",
        "heading": "Confirmation d'achat",
        "subject": "Facture %{code} à part de %{store_name}"
      },
      "payment_status_notification": {
        "body": "Votre paiement pour la commande %{code} a été confirmé et la livraison sera exécutée dès que possible.",
        "heading": "Paiement accepté",
        "subject": "Paiement confirmé pour la commande %{code}"
      }
    },
    "shared": {
      "mailers": {
        "invoice_filename": "facture_%{code}.pdf",
        "order": "Commande %{code}",
        "order_details": {
          "additional_details": "Détails additionnels",
          "address": "Adresse",
          "billing_address": "adresse de facturation",
          "company_name": "Nom de l’entreprise",
          "customer_language": "Langue du client",
          "date": "Date",
          "description": "Description",
          "discount": "Réduction",
          "discount_cart": "Réduction sur tous les produits",
          "discount_cart_and_shipping": "Réduction sur tous les produits et envois",
          "discount_code": "Code de réduction",
          "discount_shipping": "Réduction sur les envois",
          "full_address": "Adresse",
          "information": "Information",
          "instructions": "Notes concernant la livraison",
          "invoice_for_order": "Facture pour la commande %{code}",
          "item": {
            "one": "1 article",
            "other": "%{count} articles"
          },
          "name": "Nom",
          "note": "Note",
          "order_details": "Détails de la commande",
          "payment_instructions": "Instructions de paiement",
          "phone": "Tél",
          "pod_name": "Lieu",
          "recipient": "Destinataire",
          "shipping": "Livraison",
          "shipping_address": "Infos d'expédition",
          "total": "Total",
          "vat": "TVA"
        }
      }
    }
  },
  "mailers": {
    "common": {
      "delivered_to": "Envoyé à %{email} par %{brand}",
      "shop_powered_by": "Boutique optimisée par %{brand}"
    }
  }
}