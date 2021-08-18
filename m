Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA953F0990
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 18:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhHRQtE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhHRQs5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 12:48:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15CDC061764
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 09:48:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i6so4161080edu.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=PMmul5AuLaq0ahSS50MkhxtuWSpwgbvmyQEcQtwJKMk=;
        b=K2+oKL6I3fi3XD7tqlWiPFza5KgDzTWjf+Aw5RyxHKg6MOltRiZWuH4XCA5Oj+GO5r
         4nw4CoDLbNFu33b4LfNMcKQudKFkFt/yRg9rVhjdtWM/tu9oyGFPlZ2l4791qt22vdPy
         kGnlSTi/qwFLrLKZyvZAfiXgywgmZslTovrR4LJb2b02Wqq6zUo8+0ohIEPPNFBB1c5J
         W01Hq3xXxfjt5qkpZ+V7P6Et0OQbMP/FTjKhyM8fEEMNqtxKQGF6ekB5AFxmrl+80LEf
         ajW+5MNrtFna+LF9np4bx0/m5XMNFpwIpwjIhT1MWc/FzZ7y5ZzxBgumCjwLLbQujNr+
         3TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=PMmul5AuLaq0ahSS50MkhxtuWSpwgbvmyQEcQtwJKMk=;
        b=ETSFnRpMYJEW0MKPy3L+jM+bGnV/Zd+OYnFrVHik3gQlzeTb0JIqTDrm2C3I85dide
         Sabag2RnH2tQaXwwogMX93Cdzr124R6HNxevRrmIx5D/jORQb42YtxYjT5uuOrjpQyPx
         k2W0c2rUSZW9s1gtPiJEHfc9qg0e2Gj4PKccpRgCvkRO6jUxFeoqtjr2doVNhNtpZK0S
         Wm/YOilew9ZVvEIU3Gsv4Djwa8RCjKMOaE6HLpe7vxWrFJJqIgKRoRTQZdzReCToGUQ1
         gPpD7yOsS8fe27EZZS0Q9sNhB+jsu8r8s7W/dvuKNDv0oc1NT5/amQjcfjJ4MiFbRE4e
         w20g==
X-Gm-Message-State: AOAM5322h9Pw4blR2FNYFeXdJlOY67raP3/FExOexv/u9yaKaNJQGmbq
        HM1XXRXxvFRvqUPWVW8M+tc=
X-Google-Smtp-Source: ABdhPJx5EvocEVtIHmFZY0f87MFyGTVp6LOz6J4uNhbKGV70JP4eKAcKZROhbqdLClnqOF/BHMnbQw==
X-Received: by 2002:aa7:c815:: with SMTP id a21mr11234196edt.274.1629305299271;
        Wed, 18 Aug 2021 09:48:19 -0700 (PDT)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id 8sm120683ejz.88.2021.08.18.09.48.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Aug 2021 09:48:18 -0700 (PDT)
From:   Arend van Spriel <aspriel@gmail.com>
To:     Fabio Estevam <festevam@denx.de>, <kvalo@codeaurora.org>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <hch@lst.de>, <erik.stromdahl@gmail.com>
Date:   Wed, 18 Aug 2021 18:48:15 +0200
Message-ID: <17b5a29d098.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <20210818150943.1630199-1-festevam@denx.de>
References: <20210818150943.1630199-1-festevam@denx.de>
User-Agent: AquaMail/1.30.1-1828 (build: 103001000)
Subject: Re: [PATCH] ath10k: Do not call dma_alloc_coherent() for SDIO and USB
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 18, 2021 5:11:10 PM Fabio Estevam <festevam@denx.de> wrote:

> When running the "hostapd" application on a i.MX7-based board with
> an ath10k device connected via SDIO, the following warning is seen:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 489 at kernel/dma/mapping.c:427 dma_alloc_attrs+0xd0/0x114
> Modules linked in: ath10k_sdio ath10k_core ath
> CPU: 0 PID: 489 Comm: hostapd Not tainted 5.10.48-stable-standard #1
> Hardware name: Freescale i.MX7 Dual (Device Tree)
> [<c0111378>] (unwind_backtrace) from [<c010bc04>] (show_stack+0x10/0x14)
> [<c010bc04>] (show_stack) from [<c0e26094>] (dump_stack+0xdc/0x104)
> [<c0e26094>] (dump_stack) from [<c0125574>] (__warn+0xd8/0x114)
> [<c0125574>] (__warn) from [<c0e20ecc>] (warn_slowpath_fmt+0x60/0xbc)
> [<c0e20ecc>] (warn_slowpath_fmt) from [<c01b9eac>] (dma_alloc_attrs+0xd0/0x114)
> [<c01b9eac>] (dma_alloc_attrs) from [<bf01373c>] 
> (ath10k_add_interface+0x2f0/0x1094 [ath10k_core])
> [<bf01373c>] (ath10k_add_interface [ath10k_core]) from [<c0d94470>] 
> (drv_add_interface+0x88/0x2fc)
>
> As explained by Christoph Hellwig:
>
> "Looking at the ath10k code ar->dev is set by ath10k_core_create, which
> has multiple callers.
>
> For ath10k_pci_probe it is a pci_dev, which should always have a
> dma_mask.
>
> For ath10k_ahb_probe is a device tree probed platform_device,
> which should have a dma mask.
>
> For ath10k_sdio_probe it is a sdio_func, which from my understanding is
> a virtual device can't do DMA itself.
>
> For ath10k_snoc_probe it is a platform device with an explicit
> dma_set_mask_and_coherent and above so the dma_mask is set.
>
> For ath10k_usb_probe it is an usb device which can't do USB."
>
> Fix the problem by not calling dma_alloc_coherent() when the device
> is not DMA capable, such as SDIO and USB.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Hi,
>
> I am not certain about the proper commit to include in the Fixes tag.
>
> Any suggestions?
>
> Thanks
>
> drivers/net/wireless/ath/ath10k/mac.c | 20 +++++++++++---------
> 1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c 
> b/drivers/net/wireless/ath/ath10k/mac.c
> index c272b290fa73..e85c3f107d2e 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -5576,15 +5576,17 @@ static int ath10k_add_interface(struct ieee80211_hw 
> *hw,
>  if (vif->type == NL80211_IFTYPE_ADHOC ||
>     vif->type == NL80211_IFTYPE_MESH_POINT ||
>     vif->type == NL80211_IFTYPE_AP) {
> - arvif->beacon_buf = dma_alloc_coherent(ar->dev,
> -       IEEE80211_MAX_FRAME_LEN,
> -       &arvif->beacon_paddr,
> -       GFP_ATOMIC);
> - if (!arvif->beacon_buf) {
> - ret = -ENOMEM;
> - ath10k_warn(ar, "failed to allocate beacon buffer: %d\n",
> -    ret);
> - goto err;
> + if (!(ar->hif.bus == ATH10K_BUS_SDIO) && !(ar->hif.bus == ATH10K_BUS_USB)) {

Does this mean you can not really setup a beaconing interface type for SDIO 
and USB?

Regards,
Arend


