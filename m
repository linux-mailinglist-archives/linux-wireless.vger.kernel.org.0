Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7823AA71
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgHCQ1p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHCQ1p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 12:27:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0762C06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 09:27:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so30096224ljj.7
        for <linux-wireless@vger.kernel.org>; Mon, 03 Aug 2020 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZyvQV2E/1bzTIoQT9qYmbilPb07TQ7f9u6JOH0DmQN4=;
        b=QTqe5ox2bGaV5NWsEdek6Hf8ARBPUB7h25cw/bVdYka5lgB2AvoF7E3K27c5W6ZbgU
         KrONh9mZ38r6icWY9U3QvFrg4fgVYPh4nJ9UCQ8tQK3chM0vjhaM78pr8oFJ4t8HBHeh
         N1Rs5Wp/vGGa9Xzodalg+xFbW9u0LEsv748P8dCVZI7Q2zgh8XAGNU50dVgRY5I7AvgF
         ZAn9hDyqXRzxL+uVwnChh3hN+O5sGD04Pnjtju9t2f2Hk06MYVFNArnB53jUd6W1v6s0
         +k+2R4sXdM1M+z5PI8UDcBI9Hf4VT5Z6t/dwhqXz8uU1BGWik1DX5GZYRV3MRsRpLAX5
         r6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZyvQV2E/1bzTIoQT9qYmbilPb07TQ7f9u6JOH0DmQN4=;
        b=B0MQMqimXgYKhcmh6Jxd7KLiMi3IkhWFVWuqGGrNJitOKH7wcPDazOBIW078PYeD7L
         Dj13ngWULZGLPRPAb/LrT018uZ7jC+zqt3qZpyLe/dnNdDkWLQZd6JUCPkh9Yk6HXVPE
         FvHv4CvGEWjA3n7R6VuqkDCcPs96ybdqs9RKywOzs5PrJGgEiGF6ak3TvpxW4UkMqsu7
         Kga98m0dpTjUIB9R0ffAaAf+5pZxfeqrO0F8RZOwcKTZP2o++GnLxugCkPPxUyLCHwuq
         208p4jsqeamlxVcNoe9WtOMW9vYqmn1MrGQvRb1LG+HKvBHWGR8ugtFnO0u9iH4JlzhT
         K0tg==
X-Gm-Message-State: AOAM533RyoKaqeJkQ6PJrJpacnpuafFog764g6ld8FCwwV/g9xQZVT1y
        NWIz0uGKFKfBJcLdABIpJf4=
X-Google-Smtp-Source: ABdhPJyUAjJhmXn+p6MRZbGgG0klSOtXerwtwySrN+qKQxsIXI7nA5Uk2ts8xlQSilZxMJ5asjcBTQ==
X-Received: by 2002:a2e:9811:: with SMTP id a17mr2557113ljj.21.1596472063311;
        Mon, 03 Aug 2020 09:27:43 -0700 (PDT)
Received: from [192.168.2.145] (94-29-41-50.dynamic.spd-mgts.ru. [94.29.41.50])
        by smtp.googlemail.com with ESMTPSA id e14sm1681077ljl.96.2020.08.03.09.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 09:27:42 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] brcmfmac: reserve 2 credits for host tx control
 path
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
 <20200610152106.175257-4-chi-hsien.lin@cypress.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f0910f96-1d23-daf1-b517-363e59bff105@gmail.com>
Date:   Mon, 3 Aug 2020 19:27:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200610152106.175257-4-chi-hsien.lin@cypress.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

10.06.2020 18:21, Chi-Hsien Lin пишет:
> From: Amar Shankar <amsr@cypress.com>
> 
> It is observed that sometimes when sdiod is low in tx credits in low
> rssi scenarios, the data path consumes all sdiod rx all credits and
> there is no sdiod rx credit available for control path causing host
> and card to go out of sync resulting in link loss between host and
> card. So in order to prevent it some credits are reserved for control
> path.
> 
> Note that TXCTL_CREDITS can't be larger than the firmware default
> credit update threshold 2; otherwise there will be a deadlock for both
> side waiting for each other.
> 
> Signed-off-by: Amar Shankar <amsr@cypress.com>
> Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/sdio.c        | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index ce6f15284277..4da40436b4ab 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -635,6 +635,8 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
>  	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012)
>  };
>  
> +#define TXCTL_CREDITS	2
> +
>  static void pkt_align(struct sk_buff *p, int len, int align)
>  {
>  	uint datalign;
> @@ -648,8 +650,16 @@ static void pkt_align(struct sk_buff *p, int len, int align)
>  /* To check if there's window offered */
>  static bool data_ok(struct brcmf_sdio *bus)
>  {
> -	return (u8)(bus->tx_max - bus->tx_seq) != 0 &&
> -	       ((u8)(bus->tx_max - bus->tx_seq) & 0x80) == 0;
> +	/* Reserve TXCTL_CREDITS credits for txctl */
> +	return (bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
> +	       ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
> +}
> +
> +/* To check if there's window offered */
> +static bool txctl_ok(struct brcmf_sdio *bus)
> +{
> +	return (bus->tx_max - bus->tx_seq) != 0 &&
> +	       ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
>  }
>  
>  static int
> @@ -2655,7 +2665,7 @@ static void brcmf_sdio_dpc(struct brcmf_sdio *bus)
>  	brcmf_sdio_clrintr(bus);
>  
>  	if (bus->ctrl_frame_stat && (bus->clkstate == CLK_AVAIL) &&
> -	    data_ok(bus)) {
> +	    txctl_ok(bus)) {
>  		sdio_claim_host(bus->sdiodev->func1);
>  		if (bus->ctrl_frame_stat) {
>  			err = brcmf_sdio_tx_ctrlframe(bus,  bus->ctrl_frame_buf,
> @@ -2663,6 +2673,9 @@ static void brcmf_sdio_dpc(struct brcmf_sdio *bus)
>  			bus->ctrl_frame_err = err;
>  			wmb();
>  			bus->ctrl_frame_stat = false;
> +			if (err)
> +				brcmf_err("sdio ctrlframe tx failed err=%d\n",
> +					  err);
>  		}
>  		sdio_release_host(bus->sdiodev->func1);
>  		brcmf_sdio_wait_event_wakeup(bus);
> 

Hello,

This patch causes a severe WiFi performance regression on BCM4329.
Please fix or revert this patch, thanks in advance.

Before this patch:
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  17.2 MBytes  14.4 Mbits/sec    0             sender
[  5]   0.00-10.04  sec  16.9 MBytes  14.1 Mbits/sec
receiver


After this patch:
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.05 MBytes   881 Kbits/sec    3             sender
[  5]   0.00-14.01  sec   959 KBytes   561 Kbits/sec
receiver
