Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D56F8F8B
	for <lists+linux-wireless@lfdr.de>; Sat,  6 May 2023 08:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEFG5l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 May 2023 02:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFG5k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 May 2023 02:57:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F52727;
        Fri,  5 May 2023 23:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F04B60E9D;
        Sat,  6 May 2023 06:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08A3C433D2;
        Sat,  6 May 2023 06:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683356257;
        bh=SKrqn2Kf7IyTjWUu3zTHQ7N8L6W4rk8BWQ+SFkk8n6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADHvX3JmL0/4Z3Mml7MQfpkM8jJn8SBHsMF7qDZ2i96Z+u1zFFLapvNtXDAzqOmVT
         olavraTQxrjMbgFyLogJWNpThKd8EsMKWQoeqiEjHDnVCbUW3516FRDH6K9rj2dKng
         ekHIPhrSxqrjXY7EEaFN6AN3OXd/OgX81DBtbNgQ=
Date:   Sat, 6 May 2023 14:52:25 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, Claudiu.Beznea@microchip.com,
        Sripad.Balwadgi@microchip.com, stable@vger.kernel.org,
        mwalle@kernel.org
Subject: Re: [PATCH v2] wifi: wilc1000: fix kernel oops during interface down
 during background scan
Message-ID: <2023050645-vaguely-unruffled-fd81@gregkh>
References: <20230505232902.22651-1-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505232902.22651-1-ajay.kathat@microchip.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 05, 2023 at 11:42:51PM +0000, Ajay.Kathat@microchip.com wrote:
> Fix for kernel crash observed with following test procedure:
>   while true;
>     do ifconfig wlan0 up;
>     iw dev wlan0 scan &
>     ifconfig wlan0 down;
>   done
> 
> During the above test procedure, the scan results are received from firmware
> for 'iw scan' command gets queued even when the interface is going down. It
> was causing the kernel oops when dereferencing the freed pointers.
> 
> For synchronization, 'mac_close()' calls flush_workqueue() to block its
> execution till all pending work is completed. Afterwards 'wilc->close' flag
> which is set before the flush_workqueue() should avoid adding new work.
> Added 'wilc->close' check in wilc_handle_isr() which is common for
> SPI/SDIO bus to ignore the interrupts from firmware that inturns adds the
> work since the interface is getting closed.
> 
> Also, removed isr_uh_routine() as it's not necessary after 'wl->close' check
> is added in wilc_handle_isr(). So now the default primary handler would be
> used for threaded IRQ.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Michael Walle <mwalle@kernel.org>
> Link: https://lore.kernel.org/linux-wireless/20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de/
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  changes since v1:
>   - updated commit description and included 'Link:' tag
>   - use atomic_t type for 'close' variable
>   - set close state after clearing ongoing scan operation
>   - make use of default primary handler for threaded_irq
>   - avoid false failure debug message during mac_close
> 
>  .../wireless/microchip/wilc1000/cfg80211.c    |  2 +-
>  drivers/net/wireless/microchip/wilc1000/hif.c |  2 +-
>  .../net/wireless/microchip/wilc1000/netdev.c  | 33 ++++++-------------
>  .../net/wireless/microchip/wilc1000/netdev.h  |  2 +-
>  .../net/wireless/microchip/wilc1000/wlan.c    |  3 ++
>  5 files changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> index b545d93c6e37..a90a75094486 100644
> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> @@ -461,7 +461,7 @@ static int disconnect(struct wiphy *wiphy, struct net_device *dev,
>  	if (!wilc)
>  		return -EIO;
> 
> -	if (wilc->close) {
> +	if (atomic_read(&wilc->close)) {

What happens if this changes right after you read from this?

Don't reimplement locks on your own, use a real one please.

thanks,

greg k-h
