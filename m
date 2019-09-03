Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2977CA6DDA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 18:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfICQRf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 12:17:35 -0400
Received: from mail.taht.net ([176.58.107.8]:58616 "EHLO mail.taht.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729705AbfICQRf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 12:17:35 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2019 12:17:33 EDT
Received: from dancer.taht.net (unknown [IPv6:2603:3024:1536:86f0:eea8:6bff:fefe:9a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.taht.net (Postfix) with ESMTPSA id 7B95A21B3D;
        Tue,  3 Sep 2019 16:09:47 +0000 (UTC)
From:   Dave Taht <dave@taht.net>
To:     Wen Gong <wgong@qti.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
        <1566302108-18219-3-git-send-email-wgong@codeaurora.org>
Date:   Tue, 03 Sep 2019 09:09:35 -0700
In-Reply-To: <1566302108-18219-3-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Tue, 20 Aug 2019 19:55:03 +0800")
Message-ID: <87k1apnyyo.fsf@taht.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


In terms of deeply grokking what increasing buffering to achieve high
bandwidth on a testbench, vs what it can do to clobber latency in the
real world at low bandwidths, I tend to point folk at:

https://www.youtube.com/watch?v=Rb-UnHDw02o&t=25m40s

where I got a whole bunch of hackers to stand up and act like packets
in an aggregating FIFO wifi queue.

This key section is only 8 minutes long, and I promise, y'all laugh
at least 3 times at the demonstration.

At the time, also, the ath10k was so overbuffered that on one test
I could try to start 100 flows, and only get five.

https://lwn.net/Articles/705884/

and on my slides:

https://blog.linuxplumbersconf.org/2016/ocw//system/presentations/3963/original/linuxplumbers_wifi_latency-3Nov.pdf


Wen Gong <wgong@codeaurora.org> writes:

> The max bundle size support by firmware is 32, change it from 8 to 32
> will help performance. This results in significant performance
> improvement on RX path.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/htc.h  | 2 +-
>  drivers/net/wireless/ath/ath10k/sdio.c | 5 +++--
>  drivers/net/wireless/ath/ath10k/sdio.h | 4 ++--
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
> index f55d3ca..8c79b9e 100644
> --- a/drivers/net/wireless/ath/ath10k/htc.h
> +++ b/drivers/net/wireless/ath/ath10k/htc.h
> @@ -39,7 +39,7 @@
>   * 4-byte aligned.
>   */
>  
> -#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        8
> +#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        32
>  
>  enum ath10k_htc_tx_flags {
>  	ATH10K_HTC_FLAG_NEED_CREDIT_UPDATE = 0x01,
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index d9395f0..baa6051 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -24,8 +24,8 @@
>  #include "trace.h"
>  #include "sdio.h"
>  
> -#define ATH10K_SDIO_DMA_BUF_SIZE	(32 * 1024)
> -#define ATH10K_SDIO_VSG_BUF_SIZE	(32 * 1024)
> +#define ATH10K_SDIO_DMA_BUF_SIZE	(64 * 1024)
> +#define ATH10K_SDIO_VSG_BUF_SIZE	(64 * 1024)
>  
>  /* inlined helper functions */
>  
> @@ -501,6 +501,7 @@ static int ath10k_sdio_mbox_alloc_bundle(struct ath10k *ar,
>  	int ret, i;
>  
>  	*bndl_cnt = FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, htc_hdr->flags);
> +	*bndl_cnt += (FIELD_GET(GENMASK(3, 2), htc_hdr->flags) << 4);
>  
>  	if (*bndl_cnt > HTC_HOST_MAX_MSG_PER_RX_BUNDLE) {
>  		ath10k_warn(ar,
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
> index 4896eca..3ca76c7 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.h
> +++ b/drivers/net/wireless/ath/ath10k/sdio.h
> @@ -89,10 +89,10 @@
>   * to the maximum value (HTC_HOST_MAX_MSG_PER_RX_BUNDLE).
>   *
>   * in this case the driver must allocate
> - * (HTC_HOST_MAX_MSG_PER_RX_BUNDLE * HTC_HOST_MAX_MSG_PER_RX_BUNDLE) skb's.
> + * (HTC_HOST_MAX_MSG_PER_RX_BUNDLE * 2) skb's.
>   */
>  #define ATH10K_SDIO_MAX_RX_MSGS \
> -	(HTC_HOST_MAX_MSG_PER_RX_BUNDLE * HTC_HOST_MAX_MSG_PER_RX_BUNDLE)
> +	(HTC_HOST_MAX_MSG_PER_RX_BUNDLE * 2)
>  
>  #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL   0x00000868u
>  #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL_DISABLE_SLEEP_OFF 0xFFFEFFFF
