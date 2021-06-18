{% include "translations" %}
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

  <head>
    <title>
    </title>
    {% include 'header' %}
  </head>

  <body style="-ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%; margin: 0; padding: 0">
    {% include 'styles' %}
    <div>
      <!--[if mso | IE]>
        <table
          align="center" border="0" cellpadding="0" cellspacing="0" class="" style="width:600px;" width="600"
        >
          <tr>
            <td style="line-height:0px;font-size:0px;mso-line-height-rule:exactly;">
      <![endif]-->
      <div style="margin: 0px auto; max-width: 600px">
        <table align="center" border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%">
          <tbody>
            <tr>
              <td style="border-collapse: collapse; direction: ltr; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 20px; text-align: center" align="center">
                <!--[if mso | IE]>
                  <table role="presentation" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                    <td class="" style="vertical-align:top;width:560px;">
                <![endif]-->
                <div style="direction: ltr; display: inline-block; font-size: 0px; text-align: left; vertical-align: top; width: 100%" align="left">
                  <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; vertical-align: top" width="100%">
                    <tr>
                      <td align="left" style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 12px 0px 15px; word-break: break-word">
                        <table border="0" cellpadding="0" cellspacing="0" role="presentation" style="border-collapse: collapse; border-spacing: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt">
                          <tbody>
                            <tr>
                              <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 32px">
                                <img alt="Voog logo" height="32" src="//static.voog.com/libs/edicy-mailers/latest/logo-black-square.png" style="-ms-interpolation-mode: bicubic; border: 0; display: block; font-size: 13px; height: 32px; line-height: 100%; outline: none; text-decoration: none; width: 100%" width="32">
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 10px 0px; word-break: break-word">
                        <p style="border-top-color: #efefef; border-top-style: solid; border-top-width: 1px; display: block; font-size: 1px; margin: 0 auto; width: 100%">
                        </p>
                        <!--[if mso | IE]>
                          <table
                            align="center" border="0" cellpadding="0" cellspacing="0" style="border-top:solid 1px #efefef;font-size:1px;margin:0px auto;width:560px;" role="presentation" width="560px"
                          >
                            <tr>
                              <td style="height:0;line-height:0;">
                                &nbsp;
                              </td>
                            </tr>
                          </table>
                        <![endif]-->
                      </td>
                    </tr>
                    <tr>
                      <td style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; word-break: break-word">
                        <!--[if mso | IE]>
                          <table role="presentation" border="0" cellpadding="0" cellspacing="0"><tr><td height="12" style="vertical-align:top;height:12px;">
                        <![endif]-->
                        <div style="height: 12px">   </div>
                        <!--[if mso | IE]>
                          </td></tr></table>
                        <![endif]-->
                      </td>
                    </tr>
                    <tr>
                      <td align="left" style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 18px 0px 16px; word-break: break-word">
                        <div style="color: black; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 40px; font-weight: 600; line-height: 40px; text-align: left" align="left">
                          {{ translations.ecommerce_core.customer_mailer.payment_notification.heading }}
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td align="left" style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; word-break: break-word">
                        <div style="color: #8d9091; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 18px; font-weight: 500; line-height: 32px; text-align: left" align="left">
                          {{ translations.ecommerce_core.shared.mailers.order | replace: placeholders.code, order.code }}
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td align="left" style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 18px 0px 38px; word-break: break-word">
                        <div style="color: #1b2124; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 16px; font-weight: 500; line-height: 28px; text-align: left" align="left">
                          <p style="display: block; margin: 0">
                            {{ translations.ecommerce_core.customer_mailer.payment_notification.body | replace: placeholders.store_email, emailLinkTemplate | replace: "%email%", store.reply_email | replace: placeholders.store_name, store.company_name }}
                          </p>
                        </div>
                      </td>
                    </tr>

                    {% include 'order_details' %}
                    <tr>
                      <td align="left" style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; word-break: break-word">
                        <table cellpadding="0" cellspacing="0" width="100%" border="0" style="border-collapse: collapse; border: none; color: #000000; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 13px; line-height: 22px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; table-layout: auto; width: 100%">
                          <tr>
                            <td style="border-collapse: collapse; mso-table-lspace: 0pt; mso-table-rspace: 0pt; vertical-align: top !important; width: 50% !important" valign="top !important">
                              <div style="font-size: 16px !important; font-weight: bold !important; line-height: 28px !important; margin-bottom: 13px !important">
                                {{ translations.ecommerce_core.shared.mailers.order_details.address }}
                              </div>
                              {{ translations.ecommerce_core.shared.mailers.order_details.company_name }} - {{order.billing_address.company_name}}
                              <br>
                              {{
                                translations.ecommerce_core.shared.mailers.order_details.address
                              }}  - {{order.billing_address.full_location}}
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    {% include 'footer' %}
                  </table>
                </div>
                <!--[if mso | IE]>
                      </td>
                    </tr>
                  </table>
                <![endif]-->
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <!--[if mso | IE]>
            </td>
          </tr>
        </table>
      <![endif]-->
    </div>
  </body>

</html>
