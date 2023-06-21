Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96D173812A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjFUJbd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 05:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjFUJbG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 05:31:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629142102
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 02:30:41 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qBuAb-00066z-FZ; Wed, 21 Jun 2023 11:30:33 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qBuAa-0000pP-6D; Wed, 21 Jun 2023 11:30:32 +0200
Date:   Wed, 21 Jun 2023 11:30:32 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] [v4] wifi: rtw88: remove unused USB bulkout size set
Message-ID: <20230621093032.GF18491@pengutronix.de>
References: <20230621092313.65965-1-dmantipov@yandex.ru>
 <20230621092313.65965-3-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621092313.65965-3-dmantipov@yandex.ru>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 21, 2023 at 12:22:15PM +0300, Dmitry Antipov wrote:
> Drop no longer used 'bulkout_size' of 'struct rtw_usb' as well
> as related macros from usb.h and leftovers in 'rtw_usb_parse()'.
> This follows commit 462c8db6a011 ("wifi: rtw88: usb: drop
> now unnecessary URB size check").
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> v4: remove all bulkout size leftovers (Ping-Ke Shih, Sascha Hauer)
> ---
>  drivers/net/wireless/realtek/rtw88/usb.c | 17 -----------------
>  drivers/net/wireless/realtek/rtw88/usb.h |  5 -----
>  2 files changed, 22 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 6862338b1d51..6423140c6005 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -141,7 +141,6 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
>  	struct usb_host_interface *host_interface = &interface->altsetting[0];
>  	struct usb_interface_descriptor *interface_desc = &host_interface->desc;
>  	struct usb_endpoint_descriptor *endpoint;
> -	struct usb_device *usbd = interface_to_usbdev(interface);
>  	int num_out_pipes = 0;
>  	int i;
>  	u8 num;
> @@ -183,22 +182,6 @@ static int rtw_usb_parse(struct rtw_dev *rtwdev,
>  		}
>  	}
>  
> -	switch (usbd->speed) {
> -	case USB_SPEED_LOW:
> -	case USB_SPEED_FULL:
> -		rtwusb->bulkout_size = RTW_USB_FULL_SPEED_BULK_SIZE;
> -		break;
> -	case USB_SPEED_HIGH:
> -		rtwusb->bulkout_size = RTW_USB_HIGH_SPEED_BULK_SIZE;
> -		break;
> -	case USB_SPEED_SUPER:
> -		rtwusb->bulkout_size = RTW_USB_SUPER_SPEED_BULK_SIZE;
> -		break;
> -	default:
> -		rtw_err(rtwdev, "failed to detect usb speed\n");
> -		return -EINVAL;
> -	}
> -
>  	rtwdev->hci.bulkout_num = num_out_pipes;
>  
>  	if (num_out_pipes < 1 || num_out_pipes > 4) {
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.h b/drivers/net/wireless/realtek/rtw88/usb.h
> index fad998005ec8..86697a5c0103 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.h
> +++ b/drivers/net/wireless/realtek/rtw88/usb.h
> @@ -18,10 +18,6 @@
>  
>  #define RTW_USB_VENQT_CMD_IDX		0x00
>  
> -#define RTW_USB_SUPER_SPEED_BULK_SIZE	1024
> -#define RTW_USB_HIGH_SPEED_BULK_SIZE	512
> -#define RTW_USB_FULL_SPEED_BULK_SIZE	64
> -
>  #define RTW_USB_TX_SEL_HQ		BIT(0)
>  #define RTW_USB_TX_SEL_LQ		BIT(1)
>  #define RTW_USB_TX_SEL_NQ		BIT(2)
> @@ -73,7 +69,6 @@ struct rtw_usb {
>  	__le32 *usb_data;
>  	unsigned int usb_data_index;
>  
> -	u32 bulkout_size;
>  	u8 pipe_interrupt;
>  	u8 pipe_in;
>  	u8 out_ep[RTW_USB_EP_MAX];
> -- 
> 2.41.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
