{
  "ecommerce_core": {
    "customer_mailer": {
      "offline_invoice_notification": {
        "heading": "Informações da compra",
        "intro": "Obrigado por sua compra em nossa loja web, %{store_name}. Você escolheu a opção de pagamento offline, por isso aqui estão a fatura e as instruções de pagamento. Nós começaremos o envio assim que o pagamento for recebido. Perguntas? Contate-nos a qualquer momento em %{store_email}.",
        "preview": "Obrigado pela compra.",
        "subject": "Fatura %{code} de %{store_name}"
      },
      "payment_notification": {
        "body": "Obrigado por sua compra em %{store_name}. Nós recebemos com sucesso seu pagamento. Você pode encontrar a fatura paga no anexo.\nA sua encomenda será enviada assim que possível. Perguntas? Entre em contacto através de %{store_email}.",
        "heading": "Confirmação de compra",
        "subject": "Fatura %{code} de %{store_name}"
      },
      "payment_status_notification": {
        "body": "Seu pagamento do pedido %{code} foi confirmado e ele será enviado o quanto antes.",
        "heading": "Pagamento confirmado",
        "subject": "Pagamento confirmado do pedido %{code}"
      }
    },
    "shared": {
      "mailers": {
        "invoice_filename": "fatura_%{code}.pdf",
        "order": "Pedido %{code}",
        "order_details": {
          "additional_details": "Detalhes adicionais",
          "address": "Endereço",
          "billing_address": "Endereço de faturamento",
          "company_name": "Nome da empresa",
          "customer_language": "Idioma do cliente",
          "date": "Data",
          "description": "Descrição",
          "discount": "Desconto",
          "discount_cart": "Desconto em todos os itens",
          "discount_cart_and_shipping": "Desconto em todos os itens e envio",
          "discount_code": "Código de desconto",
          "discount_shipping": "Desconto no envio",
          "full_address": "Endereço",
          "information": "Informações",
          "instructions": "Notas de entrega",
          "invoice_for_order": "Fatura do pedido %{code}",
          "item": {
            "one": "1 item",
            "other": "%{count} itens"
          },
          "name": "Nome",
          "note": "Nota",
          "order_details": "Detalhes do pedido",
          "payment_instructions": "Instruções de pagamento",
          "phone": "Fone",
          "pod_name": "Localização",
          "recipient": "Destinatário",
          "shipping": "Envio",
          "shipping_address": "Endereço de envio",
          "total": "Total",
          "vat": "IVA"
        }
      }
    }
  },
  "mailers": {
    "common": {
      "delivered_to": "Entregue para %{email} pelo %{brand}",
      "shop_powered_by": "Loja otimizada por %{brand}"
    }
  }
}