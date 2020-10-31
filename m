Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21F2A14F9
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgJaJvW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Oct 2020 05:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgJaJvV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Oct 2020 05:51:21 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49904C0613D5
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 02:51:21 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id za3so11932445ejb.5
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=if9UshB7ng+YH792IkHMX3C1/nztgp+K729G9q9hkRA=;
        b=ObbksygWRBDrw08gjXw6LNn99sqrUGTfQPgGaDZv9X2UJZqgKtNjL0p5r6WR9EbqMr
         Pc+yPRDOzOaI2vrvOzvgnM3Hmd1n1IiK1CUjjtWADc3biJ4qpd+iSBkg4bqEO3ES0w4+
         mCdxAZ6bA4Bcqd/1cW51zrWYJC0SPByHFuAu8mf1KTtcDpoNroSSNeaS+BJzsTLqZRJ/
         qcZB2XPtl9w+N1A3pFdqalHTYsOdSmKQ+z183VPjrA1itDyDRSkEHu1VhXMOX6+YA0kw
         UH5BJaIr2oh/uCEVHtIoMFtBIkGeDNwfeqKWB9z665iGtUW784bWNVNTyEQKRD3eOSM3
         pWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=if9UshB7ng+YH792IkHMX3C1/nztgp+K729G9q9hkRA=;
        b=t9VK0f5pACQsn2f6iAzZ9dqPUqg8q73oF252zO3YXvpB1HvTo5fcQHIwQ7Uqz/QNkS
         51QJEYpTNBCnA2deLJG5pu+q7mmaYEytdp8PTllgcJP/sldr8HIS2QPPC5rbiBW27PUk
         FaiMSy8HAVcVBZv17Pf2vxQ1wHiCinuugCm0VUc2wW7k8YfGYBQiDNTfthlQr0dZHgmb
         rR9ZvbwM768tp/jZjXKT45IDxnMWvFxy2r+xh2R6mu9WdvKwMZp6Q97kuLUIHarOXaz1
         TyA+nt9MC9tBQH7J9Lfph5RTSSOyklPf7LHOz3glh3d24SPd8JTJFiRFv2yB91pgRRyO
         u+Bw==
X-Gm-Message-State: AOAM531n1LDLPh357q8F+aTh16s5i4ePcc1GaGq4t/wb7AUdqfflZ5qc
        2wjto3Zq8qXF9Ie5glnK1GEq3RQe8+3PNNwyxl3qgA==
X-Google-Smtp-Source: ABdhPJzVDUMI6WeBorryRNb6mEvTnwCa83yAjOyfjDfCbxinprCp6ELB7KUshJDWWZZhQJCGTOrXIj7oabek32qJaF4=
X-Received: by 2002:a17:906:2cc5:: with SMTP id r5mr6538796ejr.328.1604137879980;
 Sat, 31 Oct 2020 02:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201031022311.1677337-1-bryan.odonoghue@linaro.org> <20201031022311.1677337-3-bryan.odonoghue@linaro.org>
In-Reply-To: <20201031022311.1677337-3-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Sat, 31 Oct 2020 10:57:15 +0100
Message-ID: <CAMZdPi8+_17YSOK3G+MX3dFb0vejeikBYarRR6EckysZD4G70A@mail.gmail.com>
Subject: Re: [PATCH 2/3] wcn36xx: Enable firmware link monitoring
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 31 Oct 2020 at 03:22, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> This patch switches on CONNECTION_MONITOR. Once done it is up to the
> firmware to send keep alive and to monitor the link state.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index 706728fba72d..e924cc4acde0 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1246,6 +1246,7 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
>         ieee80211_hw_set(wcn->hw, HAS_RATE_CONTROL);
>         ieee80211_hw_set(wcn->hw, SINGLE_SCAN_ON_ALL_BANDS);
>         ieee80211_hw_set(wcn->hw, REPORTS_TX_ACK_STATUS);
> +       ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR);

The problem could be that when connection monitor is enabled, mac80211
stop sending regular null/probe packet to the AP (as expected), but
also stop monitoring beacon miss:
https://elixir.bootlin.com/linux/v5.10-rc1/source/net/mac80211/mlme.c#L115

That's not a big problem, but that would mean that in active mode
(power_save disabled, non PS), the mac80211 will not detect if the AP
has left immediately, and in worst case, only after 30 seconds. Note
that in PS mode, beacon monitoring is well done by the firmware.

>
>         wcn->hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
>                 BIT(NL80211_IFTYPE_AP) |
> --
> 2.28.0
>
