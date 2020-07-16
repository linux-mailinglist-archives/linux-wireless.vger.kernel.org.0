Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB4221DCE
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 10:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgGPIEQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 04:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPIEP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 04:04:15 -0400
Received: from mout1.freenet.de (mout1.freenet.de [IPv6:2001:748:100:40::2:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E2EC061755
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 01:04:15 -0700 (PDT)
Received: from [195.4.92.165] (helo=mjail2.freenet.de)
        by mout1.freenet.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port 25) (Exim 4.92 #3)
        id 1jvys6-0008NN-4B; Thu, 16 Jul 2020 10:04:02 +0200
Received: from localhost ([::1]:34246 helo=mjail2.freenet.de)
        by mjail2.freenet.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (Exim 4.92 #3)
        id 1jvys6-0004qW-3P; Thu, 16 Jul 2020 10:04:02 +0200
Received: from sub0.freenet.de ([195.4.92.119]:50510)
        by mjail2.freenet.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (Exim 4.92 #3)
        id 1jvypl-000395-7a; Thu, 16 Jul 2020 10:01:37 +0200
Received: from p200300e707002e000785056b8e3c0b45.dip0.t-ipconnect.de ([2003:e7:700:2e00:785:56b:8e3c:b45]:51162 helo=[127.0.0.1])
        by sub0.freenet.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de) (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256) (port 465) (Exim 4.92 #3)
        id 1jvypl-00008D-4c; Thu, 16 Jul 2020 10:01:37 +0200
Subject: Re: [PATCH 1/1] ath9k: Fix regression with Atheros 9271
To:     Mark O'Donovan <shiftee@posteo.net>, linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, hqjagain@gmail.com,
        ath9k-devel@qca.qualcomm.com, davem@davemloft.net, kuba@kernel.org,
        Roman Mamedov <rm@romanrm.net>
References: <20200711043324.8079-1-shiftee@posteo.net>
From:   =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= 
        <viktor_jaegerskuepper@freenet.de>
Message-ID: <184f6897-40f8-949c-eca5-2bdb0d2aa8fb@freenet.de>
Date:   Thu, 16 Jul 2020 10:01:29 +0200
MIME-Version: 1.0
In-Reply-To: <20200711043324.8079-1-shiftee@posteo.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Originated-At: 2003:e7:700:2e00:785:56b:8e3c:b45!51162
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[I fixed my e-mail address and CC'ed Roman]

Mark O'Donovan:
> This fix allows ath9k_htc modules to connect to WLAN once again.
> 
> Fixes: 2bbcaaee1fcb (ath9k: Fix general protection fault in
> ath9k_hif_usb_rx_cb )
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=208251
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>

This fixes the issue for me. Please don't forget:
Reported-by: Roman Mamedov <rm@romanrm.net>

And if you want to add this:
Tested-by: Viktor Jägersküpper <viktor_jaegerskuepper@freenet.de>

These additional lines are mainly useful if the patch doesn't work for someone
else and they decide to report it, so hopefully Roman and I would receive the
report, too. And we already have three threads for this bug.

> ---
>  drivers/net/wireless/ath/ath9k/hif_usb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
> index 4ed21dad6a8e..3f563e02d17d 100644
> --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
> +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
> @@ -733,11 +733,13 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
>  			return;
>  		}
>  
> +		rx_buf->skb = nskb;
> +
>  		usb_fill_int_urb(urb, hif_dev->udev,
>  				 usb_rcvintpipe(hif_dev->udev,
>  						 USB_REG_IN_PIPE),
>  				 nskb->data, MAX_REG_IN_BUF_SIZE,
> -				 ath9k_hif_usb_reg_in_cb, nskb, 1);
> +				 ath9k_hif_usb_reg_in_cb, rx_buf, 1);
>  	}
>  
>  resubmit:
> 
