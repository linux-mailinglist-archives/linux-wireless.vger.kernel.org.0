Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42F474E32
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 23:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhLNWs1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 17:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhLNWsZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 17:48:25 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF13C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 14:48:24 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id x6so26756096iol.13
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 14:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXv/DtzT+RrVII/ZrToN2ofTA5+xjSjZP2wWKJOuS5k=;
        b=m7u5do6kEqS/yNJotc7vURvyVHtIY4LPihgG2+Q6Ucu5lAjpSWyNKgjSKZMvQXo7eL
         ru1Iqg5bdj1O7/RsdWMyhPd1+1b4jZk7MggskgtLsEEmHf0sv2cfE/+08hjd97vqyHOs
         LHFMSZaDaxCFs1Vsb/P9GFPbTL11VxrVTJRqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXv/DtzT+RrVII/ZrToN2ofTA5+xjSjZP2wWKJOuS5k=;
        b=ho4V/MfX/Y07rtH7sHFYBxnK21spg9uAxspskJPokGFxFChrL5WTVk1FFpopOejL4G
         36NST9H2bFPynin/aA3s6lb7k5MZGkHqbxIMjpcVBrbZmieaApSzXbZfrvuZ8rx9eoZh
         jNI6C86dDjfWW0U+oV7dX/IdTBXuzvvqN9syBsKXAguQcv7hlA2v1ubsEpuG0WG3LTGj
         BSaM7FUi8Vns/8qJ6moUnl7oBHNvXCf1XEjEKaLAUbl6qgHHAwx1GQh34p8ohYSb9ZYm
         fghstCWZpjhq9l6N1rsOX30QFDC4mcgmLys1zlmvyEgV2iFVC9dX3B1iCURYmdmQA1Dj
         JZIA==
X-Gm-Message-State: AOAM5327HPf2ejP7HetvoTK9PHQuaKma99iWMsWihQNHoyUs0SdHSizH
        EkB97CZgeuVgB+NnxMsV5J1L+6rWos0OSI5fKzvBQg==
X-Google-Smtp-Source: ABdhPJwhPBYy3YkhpWPba0anVBjfvoXbIbG2xjp4g5uA3wsijJAtQub1bOlhDmNO/tfHCSUs1QnrSOvce1nGtdLL3rM=
X-Received: by 2002:a05:6638:134d:: with SMTP id u13mr4477072jad.360.1639522104190;
 Tue, 14 Dec 2021 14:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20211214223901.1.I777939e0ef1e89872d4ab65340f3fd756615a047@changeid>
In-Reply-To: <20211214223901.1.I777939e0ef1e89872d4ab65340f3fd756615a047@changeid>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Tue, 14 Dec 2021 14:48:13 -0800
Message-ID: <CACTWRwtn+xwVfdFC_1ZAEGC41+gqjDNpTk46vctejnF74Pf+AQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: enable threaded napi on ath10k driver
To:     kvalo@codeaurora.org, briannorris@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        dianders@chromium.org, pillair@codeaurora.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath10k@lists.infradead.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi All,

This patch is to trigger a discussion on the best approach to enable
threaded NAPI on ath10k. Threaded NAPI feature was added in (net:
extract napi poll functionality to __napi_poll() commit
898f8015ffe74118e7b461827451f2cc6e51035b) and showed good results on
ath10k snoc based solution.

If we come to a consensus with this as the best approach to enable
threaded NAPI on ath10k, then we can moved ahead with the
implementation and enable across sdio and pci, or if there is any
objection then we can discuss it here.

Thanks
Abhishek

On Tue, Dec 14, 2021 at 2:41 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
>
> NAPI poll can be done in threaded context along with soft irq
> context. Threaded context can be scheduled efficiently, thus
> creating less of bottleneck during Rx processing. This patch is
> to enable threaded NAPI on ath10k driver.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2-00696-QCAHLSWMTPL-1
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> ---
>
>  drivers/net/wireless/ath/ath10k/pci.c  | 1 +
>  drivers/net/wireless/ath/ath10k/sdio.c | 1 +
>  drivers/net/wireless/ath/ath10k/snoc.c | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
> index 4d4e2f91e15c..584307574d99 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -1958,6 +1958,7 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
>
>         ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot hif start\n");
>
> +       dev_set_threaded(&ar->napi_dev, true);
>         ath10k_core_napi_enable(ar);
>
>         ath10k_pci_irq_enable(ar);
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index 63e1c2d783c5..52ef74d9811a 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -1862,6 +1862,7 @@ static int ath10k_sdio_hif_start(struct ath10k *ar)
>         struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
>         int ret;
>
> +       dev_set_threaded(&ar->napi_dev, true);
>         ath10k_core_napi_enable(ar);
>
>         /* Sleep 20 ms before HIF interrupts are disabled.
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 9513ab696fff..e7d12dbb3fa5 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -926,7 +926,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
>         struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
>
>         bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
> -
> +       dev_set_threaded(&ar->napi_dev, true);
>         ath10k_core_napi_enable(ar);
>         ath10k_snoc_irq_enable(ar);
>         ath10k_snoc_rx_post(ar);
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
