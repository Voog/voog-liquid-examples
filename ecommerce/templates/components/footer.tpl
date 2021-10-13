<tr>
  <td
    style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 0px; word-break: break-word">
    <!--[if mso | IE]>
    
        <table role="presentation" border="0" cellpadding="0" cellspacing="0"><tr><td height="16" style="vertical-align:top;height:16px;">
      
    <![endif]-->
    <div style="height: 22px"> &nbsp; </div>
    <!--[if mso | IE]>
    
        </td></tr></table>
      
    <![endif]-->
  </td>
</tr>

<tr>
  <td style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 10px 20px; word-break: break-word">
    <p style="border-top-color: #efefef; border-top-style: solid; border-top-width: 1px; display: block; font-size: 1px; margin: 0 auto; width: 100%"></p>
    <!--[if mso | IE]>
      <table align="center" border="0" cellpadding="0" cellspacing="0" style="border-top:solid 1px #efefef;font-size:1px;margin:0px auto;width:560px;" role="presentation" width="560px">
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
  <td align="center" style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 14px 20px 0px; word-break: break-word">
    <div style="color: #8d9091; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 12px; font-weight: 500; line-height: 24px; text-align: center" align="center">
      {{ translations.mailers.common.delivered_to | replace: placeholders.email, order.customer.email | replace: placeholders.brand, 'Voog'}}
    </div>
  </td>
</tr>
<tr>
  <td align="center" style="border-collapse: collapse; font-size: 0px; mso-table-lspace: 0pt; mso-table-rspace: 0pt; padding: 20px 20px 0px; word-break: break-word">
    <div style="color: #8d9091; font-family: Sharp Sans, Avenir Next, Avenir, Helvetica Neue, Helvetica, sans-serif; font-size: 12px; font-weight: 500; line-height: 24px; text-align: center" align="center">
      <img src="//static.voog.com/libs/edicy-mailers/latest/logo-gray-square.png" alt="Voog logo" style="-ms-interpolation-mode: bicubic; border: 0; height: 24px !important; line-height: 100%; margin-right: 4px !important; outline: none; text-decoration: none; vertical-align: middle !important; width: 24px !important">
      {{ translations.mailers.common.shop_powered_by | replace: placeholders.brand, boldLinkTemplate | replace:  "%link_href%", "https://www.voog.com" | replace: "%link_label%", "Voog" }}
    </div>
  </td>
</tr>