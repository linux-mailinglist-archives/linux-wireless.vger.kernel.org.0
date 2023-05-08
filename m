Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9F6FA2B6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjEHI6h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEHI6g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:58:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0401E98B
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:58:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pvwhJ-0004uU-5b; Mon, 08 May 2023 10:58:21 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pvwhI-0006Md-DS; Mon, 08 May 2023 10:58:20 +0200
Date:   Mon, 8 May 2023 10:58:20 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@kernel.org, tony0620emma@gmail.com, stable@vger.kernel.org,
        dan.carpenter@linaro.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: correct qsel_to_ep[] type as int
Message-ID: <20230508085820.GU29365@pengutronix.de>
References: <20230508085539.46795-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508085539.46795-1-pkshih@realtek.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 08, 2023 at 04:55:39PM +0800, Ping-Ke Shih wrote:
> qsel_to_ep[] can be assigned negative value, so change type from 'u8' to
> 'int'. Otherwise, Smatch static checker warns:
>   drivers/net/wireless/realtek/rtw88/usb.c:219 rtw_usb_parse() warn:
>   assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[8]'
> 
> Cc: stable@vger.kernel.org
> Fixes: a6f187f92bcc ("wifi: rtw88: usb: fix priority queue to endpoint mapping")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-wireless/c3f70197-829d-48ed-ae15-66a9de80fa90@kili.mountain/
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/net/wireless/realtek/rtw88/usb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/usb.h b/drivers/net/wireless/realtek/rtw88/usb.h
> index 30647f0dd61c6..ad1d7955c6a51 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.h
> +++ b/drivers/net/wireless/realtek/rtw88/usb.h
> @@ -78,7 +78,7 @@ struct rtw_usb {
>  	u8 pipe_interrupt;
>  	u8 pipe_in;
>  	u8 out_ep[RTW_USB_EP_MAX];
> -	u8 qsel_to_ep[TX_DESC_QSEL_MAX];
> +	int qsel_to_ep[TX_DESC_QSEL_MAX];
>  	u8 usb_txagg_num;
>  
>  	struct workqueue_struct *txwq, *rxwq;
> -- 
> 2.25.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
