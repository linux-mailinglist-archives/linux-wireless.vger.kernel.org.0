Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3B6131897
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 20:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgAFTT1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 14:19:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46581 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgAFTT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so50902229wrl.13
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1DiUbn/uge4ZdZwSZw1/xSvzuKtRN5x2iHMem43HB8Q=;
        b=LI+Il05dGaGaAFvZ7nINzPFXom+zumQtKFnxIrRG39Vu6dj4EcSFCuGEb1UqtJP6mI
         WvfUICKFOII7dfooq8Gg+3vxvS8yiFOYxm6NV5HER5t20Ef9lXw3dNL2194noM7wLJkb
         FDcGOThRjt2vW/PAHOTAoalBX35/5wdb6qv2ClSqjn75licL2p0O7AV6gKYm9m9H/2T5
         DlFRe+FtZFiWY6xvmDyI+mZ4HRUfkHuw03Ht+dw6c/7K9t/HAmylmHVp3ILouxq6qPNu
         w6DhkzBUyxfu9HSabcsrX96MNk+VPqF0V6Hl+UGE87Ivb6HD00NmPCVKDQ6mpPWkkk+B
         WDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1DiUbn/uge4ZdZwSZw1/xSvzuKtRN5x2iHMem43HB8Q=;
        b=bfSU+ap/TRLzLVCiPXKtjQqOZGy0popeSHaLfW7HNMCm2LMF8yfa06WilJ1zY74Obx
         Lvxl+qW5Mv1OeFqBYA/P/0aNz06YPKBiI3tALGO1qucv18/8q2ilF6FC/QhmhIhmVuke
         nQaNVnHn3pydvo4tAHd3BgaZu7k355yThCBYOJ3QcPA80LqWP7LuN4Q1/ZBO+PvuMSsH
         RtX1XyaaiV/VKwSyjEvfAPQDY3lruOe5A2XQ6gNY000dHbaLliTF6eSk9e8NpRgAhNPH
         lkdlQhpvExvNZeh3UrEy/bpY6OStiy5r4IpuAKTcuFpuE8/b94iv9ZfNe2+tErNdsmAj
         1VVQ==
X-Gm-Message-State: APjAAAWLefRCesEr1I0DSDMQtspl1pwJJHGV54H/umqnUzGFDHAoQ2oC
        wbYaWCir8Il7MhxVx8Qy2HmB4Q==
X-Google-Smtp-Source: APXvYqyzNYcpxQB7KuyEARjMmiPeO3GDXFQaHaE6c9tJ5UN7KMiwgFVxOBX9llyIb6rwjf7khc2uEg==
X-Received: by 2002:adf:c147:: with SMTP id w7mr108157303wre.389.1578338365461;
        Mon, 06 Jan 2020 11:19:25 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id q11sm72195148wrp.24.2020.01.06.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:24 -0800 (PST)
Date:   Mon, 6 Jan 2020 20:19:19 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        hdegoede@redhat.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, kvalo@codeaurora.org, davem@davemloft.net
Subject: Re: [PATCH] brcmfmac: sdio: Fix OOB interrupt initialization on
 brcm43362
Message-ID: <20200106191919.GA826263@myrica>
References: <20191226092033.12600-1-jean-philippe@linaro.org>
 <16f419a7070.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <141f055a-cd1d-66cb-7052-007cda629d3a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141f055a-cd1d-66cb-7052-007cda629d3a@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dmitry,

On Thu, Dec 26, 2019 at 05:37:58PM +0300, Dmitry Osipenko wrote:
> I haven't seen any driver probe failures due to OOB on NVIDIA Tegra,
> only suspend-resume was problematic due to the unbalanced OOB
> interrupt-wake enabling.
> 
> But maybe checking whether OOB interrupt-wake works by invoking
> enable_irq_wake() during brcmf_sdiod_intr_register() causes trouble for
> the cubietruck board.
> 
> @Jean-Philippe, could you please try this change (on top of recent
> linux-next):

Sorry for the delay, linux-next doesn't boot for me at the moment and I
have little time to investigate why, so I might retry closer to the merge
window.

However, isn't the interrupt-wake issue independent from the problem
(introduced in v4.17) that my patch fixes? I applied "brcmfmac: Keep OOB
wake-interrupt disabled when it shouldn't be enabled" on v5.5-rc5 and it
doesn't seem to cause a regression, but the wifi only works if I apply my
patch as well.

Thanks,
Jean

> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index b684a5b6d904..80d7106b10a9 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -115,13 +115,6 @@ int brcmf_sdiod_intr_register(struct brcmf_sdio_dev
> *sdiodev)
>                 }
>                 sdiodev->oob_irq_requested = true;
> 
> -               ret = enable_irq_wake(pdata->oob_irq_nr);
> -               if (ret != 0) {
> -                       brcmf_err("enable_irq_wake failed %d\n", ret);
> -                       return ret;
> -               }
> -               disable_irq_wake(pdata->oob_irq_nr);
> -
>                 sdio_claim_host(sdiodev->func1);
> 
>                 if (sdiodev->bus_if->chip == BRCM_CC_43362_CHIP_ID) {
