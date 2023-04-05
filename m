Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F876D7B8D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 13:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbjDELkm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 07:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbjDELkl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 07:40:41 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E43A9C
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 04:40:37 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1BBA5254;
        Wed,  5 Apr 2023 13:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1680694835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7dHIfryfDdUOPU48fgzzLGXZqCinqEvLNkxgYOperI=;
        b=hTBwwdWsPr1kfonXxlQgLHkqfX5zWRCFU/hsFXQbjRbhG25kuW2prGNuLwut0fQixvudpO
        C5uTqC83kP6j4sRckSDWhcM82UkViOl24aUzCdHk0D1NzgNVMPygyau/PMl/0D53GQv+c5
        e/jsZuriM67u2tImI/6ZK/KWAIOGzEK9/LiiVAU+T8K7wnGmoWJKzAqMpV8wtgxsB2a+IW
        gNbV1gXhDd/NE2Lqszs/aYS9ECX+lcdhz3rPI0GCnZCg5v/pAgOjDne8R4vX36IKV70fkg
        Vwt7lc4lyA9yDQazDwBAAbkgYTvpQpitWrbC7fq37fHD756T+bqPGYlOe/Bukg==
MIME-Version: 1.0
Date:   Wed, 05 Apr 2023 13:40:34 +0200
From:   Michael Walle <michael@walle.cc>
To:     Ajay.Kathat@microchip.com,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, mwalle@kernel.org
Subject: Re: [PATCH] wifi: wilc1000: fix kernel oops during interface down
 during background scan
In-Reply-To: <20230404012010.15261-1-ajay.kathat@microchip.com>
References: <20230404012010.15261-1-ajay.kathat@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f10d69fb17e03eb093d846d005d7496a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

[+ wireless and cfg80211 maintainers because I'm not familiar with
cfg80211 ]

> Fix for kernel crash observed with following test procedure [1]:
>   while true;
>     do ifconfig wlan0 up;
>     iw dev wlan0 scan &
>     ifconfig wlan0 down;
>   done
> 
> During the above test procedure, the scan results are received from 
> firmware
> for 'iw scan' command gets queued even when the interface is going 
> down. It
> was causing the kernel oops when dereferencing the freed pointers.
> 
> For synchronization, 'mac_close()' calls flush_workqueue() to block its
> execution till all pending work is completed. Afterwards 'wilc->close' 
> flag
> which is set before the flush_workqueue() should avoid adding new work.
> Added 'wilc->close' check in wilc_handle_isr() which is common for
> SPI/SDIO bus to ignore the interrupts from firmware that inturns adds 
> the
> work since the interface is getting closed.

With this patch I'm now getting
    wilc1000_sdio mmc0:0001:1 wlan0: Failed to send setup multicast

when you close the interface.

> 
> 1.
> https://lore.kernel.org/linux-wireless/20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de/

should be Link:

> Reported-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

Missing Fixes: tag. In this regard, most of the previous wilc fixes 
patches
miss a proper Fixes tag which makes the wilc1000 pretty unusable on 
stable
kernels IMHO :/

> ---
>  drivers/net/wireless/microchip/wilc1000/netdev.c | 9 +++------
>  drivers/net/wireless/microchip/wilc1000/wlan.c   | 3 +++
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c
> b/drivers/net/wireless/microchip/wilc1000/netdev.c
> index e9f59de31b0b..40edee10a81f 100644
> --- a/drivers/net/wireless/microchip/wilc1000/netdev.c
> +++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
> @@ -38,11 +38,6 @@ static irqreturn_t isr_bh_routine(int irq, void 
> *userdata)
>  {
>  	struct wilc *wilc = userdata;
> 
> -	if (wilc->close) {
> -		pr_err("Can't handle BH interrupt\n");
> -		return IRQ_HANDLED;
> -	}
> -

This check is still in the top half of the interrupt processing.
Shouldn't it be removed there, too? That way you can get rid of
the top half entirely and just let the irq subsys use the default
top half implementation.

>  	wilc_handle_isr(wilc);
> 
>  	return IRQ_HANDLED;
> @@ -781,13 +776,15 @@ static int wilc_mac_close(struct net_device 
> *ndev)
>  	if (vif->ndev) {
>  		netif_stop_queue(vif->ndev);
> 
> +		if (wl->open_ifcs == 0)
> +			wl->close = 1;

Ignoring the fact that this isn't protected somehow and that
there is no write barrier (maybe I'm overthinking this and
it isn't really needed for an 'int' field), this and your
reasoning with the flush_workqueue() sounds legit.

But I'm still not convinced a lock is not required.
wilc_user_scan_req::scan_result is at least updated in
wilc_disconnect() and wilc_deinit().

wilc_disconnect() is called from the cfg80211_ops::disconnect
callback. wilc_deinit() is called from net_device_ops::ndo_stop.
Is there any lock which prevents both functions be called in
parallel? wl->close is checked in the .disconnect op, but as
mentioned above, it is not protected by any lock.

-michael

> +
>  		wilc_handle_disconnect(vif);
>  		wilc_deinit_host_int(vif->ndev);
>  	}
> 
>  	if (wl->open_ifcs == 0) {
>  		netdev_dbg(ndev, "Deinitializing wilc1000\n");
> -		wl->close = 1;
>  		wilc_wlan_deinitialize(ndev);
>  	}
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c
> b/drivers/net/wireless/microchip/wilc1000/wlan.c
> index 58bbf50081e4..700cb657be00 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> @@ -1066,6 +1066,9 @@ void wilc_handle_isr(struct wilc *wilc)
>  {
>  	u32 int_status;
> 
> +	if (wilc->close)
> +		return;
> +
>  	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
>  	wilc->hif_func->hif_read_int(wilc, &int_status);
> 
> --
> 2.34.1
