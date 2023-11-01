Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5A47DE44B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 16:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjKAP5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjKAP5I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 11:57:08 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040F6102
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 08:57:01 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 5876 invoked from network); 1 Nov 2023 16:56:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1698854216; bh=SLE5umc1+C++7OiQgwNSEy1l0uUJaxk0dXwHnUQQcLc=;
          h=From:To:Cc:Subject;
          b=qKhWrrdrO6NNRWXdUUmLyoaE7Zgjzf8qxszx4tn4vq2UQt1AToFZG+BVraFCeOS4i
           ESVuY8Bs6/oZWbGaAAvd9mTKWfnfFsgqjGfqkpe/zUcZer+CqXxzoCJhIKr+djQbJQ
           DQ0bE++dHemJ6wIIfxSdRxQ8ySrRhhnzI+v9XWT4=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 1 Nov 2023 16:56:56 +0100
Date:   Wed, 1 Nov 2023 16:56:55 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 1/3] wifi: rt2x00: introduce DMA busy check watchdog for
 rt2800
Message-ID: <20231101155655.GA559463@wp.pl>
References: <TYAP286MB0315F9EFFA3D13AA1AD7AEF4BCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB0315F9EFFA3D13AA1AD7AEF4BCA3A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: 7a02cafabffdd6aeaf20f3a457b528de
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [EWP0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Oct 28, 2023 at 08:15:30PM +0800, Shiji Yang wrote:
> When I tried to fix the watchdog of rt2800, I found that sometimes
> the watchdog could not reset the hung device. This is because the
> queue did not completely stop, it just became very slow. The Mediatek
> vendor driver for the new chips (MT7603/MT7612) has a DMA busy
> watchdog to detect device hangs by checking DMA busy status. This
> implementation is something similar to it. To reduce unnecessary
> watchdog reset, we can check the INT_STATUS register together as I
> found that when the radio hung, the RX/TX coherent interrupt will
> always stuck at triggered state.
> 
> This patch also changes the watchdog module parameters to the new
> 'hang_watchdog' and 'dma_busy_watchdog' so that we can control them
> separately. That's because they may have different behavior on
> specific chip.
> 
> This watchdog function is a slight schedule and it won't affect the
> WiFi transmission speed. Watchdog can help the driver automatically
> recover from the abnormal state. So I think it should be default on.
> Anyway it can be disabled by module parameter 'dma_busy_watchdog=0'.
> 
> Tested on MT7620 and RT5350.

I think this will not work on USB as INT_SOURCE_CSR is mmio/pci
specific. Did you tested on USB ? Or this is disabled for USB by
default? 

> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  .../net/wireless/ralink/rt2x00/rt2800lib.c    | 81 ++++++++++++++++---
>  drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  3 +
>  2 files changed, 72 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index 594dd3d9f..6ca2f2c23 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -30,9 +30,15 @@
>  #include "rt2800lib.h"
>  #include "rt2800.h"
>  
> -static bool modparam_watchdog;
> -module_param_named(watchdog, modparam_watchdog, bool, S_IRUGO);
> -MODULE_PARM_DESC(watchdog, "Enable watchdog to detect tx/rx hangs and reset hardware if detected");
> +static bool modparam_dma_wdt = true;
> +module_param_named(dma_busy_watchdog, modparam_dma_wdt, bool, 0444);
> +MODULE_PARM_DESC(dma_busy_watchdog, "Enable watchdog to detect tx/rx"
> +		 " DMA busy and reset hardware if detected");
> +
> +static bool modparam_hang_wdt;
> +module_param_named(hang_watchdog, modparam_hang_wdt, bool, 0444);
> +MODULE_PARM_DESC(hang_watchdog, "Enable watchdog to detect tx/rx hangs"
> +		 " and reset hardware if detected");

Do not have strong opinion here. But please consider to keep old module
parameter name and make it bitmask, 1 - hang_wdt, 2 dma_wdt, 3 - both.
Such way, it will keep old meaning if someone is using the parameter in
script/config.  

I also wandering if we need two implementations. If dma 
hang detection is superior, it should replace the old one IMHO.
Or queue hang should be used for USB and dma hang for pci/mmio ? 

Otherwise code looks fine/correct to me. 

Regards
Stanislaw
