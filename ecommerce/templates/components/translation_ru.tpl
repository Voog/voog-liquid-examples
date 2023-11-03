{
  "ecommerce_core": {
    "customer_mailer": {
      "offline_invoice_notification": {
        "heading": "Информация о покупке",
        "intro": "Благодарим Вас за покупку в нашем интернет-магазине %{store_name}. Поскольку Вы выбрали возможность офлайновой оплаты, высылаем Вам счет и инструкции по оплате покупки. Мы приступим к отправке товара сразу после получения платежа. Есть вопросы? Обращайтесь к нам в любое время по адресу %{store_email}.",
        "preview": "Благодарим Вас за покупку.",
        "subject": "Счет %{code} от %{store_name}"
      },
      "payment_notification": {
        "body": "Благодарим Вас за покупку в %{store_name}. Мы получили Ваш платеж. В приложении Вы найдете счет за оплаченный товар.\nВаш заказ будет отправлен как можно скорее. Есть вопросы? Свяжитесь с нами по адресу %{store_email}.",
        "heading": "Подтверждение покупки",
        "subject": "Счет %{code} от %{store_name}"
      },
      "payment_status_notification": {
        "body": "Ваша оплата по заказу %{code} подтверждена, заказ будет отправлен при первой возможности.",
        "heading": "Оплата подтверждена",
        "subject": "Подтверждена оплата по заказу %{code}"
      }
    },
    "shared": {
      "mailers": {
        "invoice_filename": "счет_%{code}.pdf",
        "order": "Заказ%{code}",
        "order_details": {
          "additional_details": "Дополнительная информация",
          "address": "Адрес",
          "billing_address": "Адрес получателя счета",
          "company_name": "Наименование компании",
          "customer_language": "Язык клиента",
          "date": "Дата",
          "description": "Описание",
          "discount": "Скидка",
          "discount_cart": "Скидка на все объекты",
          "discount_cart_and_shipping": "Скидка на все объекты и доставку",
          "discount_code": "Код скидки",
          "discount_shipping": "Скидка на доставку",
          "full_address": "Адрес",
          "information": "Информация",
          "instructions": "Примечания к доставке",
          "invoice_for_order": "Счет за заказ %{code}",
          "item": {
            "one": "1 объект",
            "few": "%{count} объекта",
            "many": "%{count} объектов",
            "other": "%{count} объектов"
          },
          "name": "Название",
          "note": "Примечание",
          "order_details": "Подробная информация о заказе",
          "payment_instructions": "Инструкции по оплате",
          "phone": "Телефон",
          "pod_name": "Местоположение",
          "recipient": "Получатель",
          "shipping": "Отправка",
          "shipping_address": "Адрес доставки",
          "sku": "Код продукта",
          "total": "Итого",
          "vat": "НСО"
        }
      }
    }
  },
  "mailers": {
    "common": {
      "delivered_to": "Доставлено %{brand} адресату %{email}",
      "shop_powered_by": "Магазин работает на %{brand}"
    }
  }
}