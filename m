Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481767BD2E7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 07:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345129AbjJIFzs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 01:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbjJIFzr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 01:55:47 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB21A4
        for <linux-wireless@vger.kernel.org>; Sun,  8 Oct 2023 22:55:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qpjEv-00042z-Kq; Mon, 09 Oct 2023 07:55:37 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qpjEq-000L3W-Gp; Mon, 09 Oct 2023 07:55:32 +0200
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qpjEq-00DU3G-EO; Mon, 09 Oct 2023 07:55:32 +0200
Date:   Mon, 9 Oct 2023 07:55:32 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, neo_jou <neo_jou@realtek.com>,
        Hans Ulli Kroll <linux@ulli-kroll.de>
Subject: Re: [PATCH] wifi: rtw88: Remove duplicate NULL check before calling
 usb_kill/free_urb()
Message-ID: <20231009055532.GB3114228@pengutronix.de>
References: <20231008025852.1239450-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008025852.1239450-1-ruanjinjie@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Oct 08, 2023 at 10:58:52AM +0800, Jinjie Ruan wrote:
> Both usb_kill_urb() and usb_free_urb() do the NULL check itself, so there
> is no need to duplicate it prior to calling.
> 
> Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/wireless/realtek/rtw88/usb.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index d879d7e3dc81..e6ab1ac6d709 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -611,8 +611,7 @@ static void rtw_usb_cancel_rx_bufs(struct rtw_usb *rtwusb)
>  
>  	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
>  		rxcb = &rtwusb->rx_cb[i];
> -		if (rxcb->rx_urb)
> -			usb_kill_urb(rxcb->rx_urb);
> +		usb_kill_urb(rxcb->rx_urb);
>  	}
>  }
>  
> @@ -623,10 +622,8 @@ static void rtw_usb_free_rx_bufs(struct rtw_usb *rtwusb)
>  
>  	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
>  		rxcb = &rtwusb->rx_cb[i];
> -		if (rxcb->rx_urb) {
> -			usb_kill_urb(rxcb->rx_urb);
> -			usb_free_urb(rxcb->rx_urb);
> -		}
> +		usb_kill_urb(rxcb->rx_urb);
> +		usb_free_urb(rxcb->rx_urb);
>  	}
>  }
>  
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
