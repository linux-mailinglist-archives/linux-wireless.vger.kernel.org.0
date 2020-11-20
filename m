Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94372BA44A
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 09:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgKTIGX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 03:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgKTIGX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 03:06:23 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49138C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 00:06:21 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id y4so8578128edy.5
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 00:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpGLXOu+I4pDQAyTvGunXOjKk/E9SQfIEk8giGAWObg=;
        b=dMhSBg41F7n1vi8e/oRCTOFzgNeX7X2/D2xo13+/xjc4HVeAhvpTRn2X6JLjoMB5vH
         UrtA9kM2Y7/yg8AfwrLETOx8yxaRIrm3+amXorWPlhRfHOPRqJVpxsxkIirOzJ7jh6L/
         9Bsd6yAHjkUZ2MNCU5g53t2l9X7rd8jUQDqUgrGZNXfo+rcyaHBiRucQB8VgLHFNUzPR
         6ZgRgqtI8fO+6Z/h5TqwbkcIwkqwPPc0YYDNk29o8/AVXMh/nYLQaP5kD+Qz3/04pjxB
         k0u9dHtAoqb+KA0vNdpYFWpphzo1r4MQTotJTBB2dcjIdguVJARF98EiB/SN1UbQ/m/2
         z10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpGLXOu+I4pDQAyTvGunXOjKk/E9SQfIEk8giGAWObg=;
        b=IWd0wAKvHDK5vIA4Wx5X/3d0figF7DCnBcIgkeKw5aItI4r18RlOAP6/v3jIdDQc9p
         yQbeUu7vbtJJXMk38qxuPwMIhmGA4ijKj/3t9HjFU+HA2elQrMwh/0tAPfagNAyVSz/O
         0S+atjQfahMivYOeFcXU3B5DK1TGFTIUiADvOGDqQ8mktSxL8hLmtkqQxYwJsVd099QE
         JIQu8BW/rQNKtjDFEnXOD0+b9wnvDvdW0sEoG0OV2qgTLdD1gqcYxQhN014LwFfBicj7
         jl7uvxBcwIeBPddMIqr+DF8KoMG1KShlAMXJfV6CTihBt3brXdHetdrpmbg7KeABqcXh
         JVfA==
X-Gm-Message-State: AOAM530D+IyRcHlgBbvG9F5kj7AEO+8nHEwGqW4JtNF0DDONwtsFqMbO
        FjN5dG/tfCdAw7MaQsH3dNwCTXtUIU8+Qv4RiNpAgQ==
X-Google-Smtp-Source: ABdhPJxqKDZZBbRRAJeXb0rzeukxh6cdzH11Hyp0rJmZtv+uBKam8QCCvWMENSLgRn441SW/1gchNeYcKbG5u+hLKSs=
X-Received: by 2002:aa7:d4da:: with SMTP id t26mr6820029edr.134.1605859579942;
 Fri, 20 Nov 2020 00:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20201120021403.2646574-1-bryan.odonoghue@linaro.org>
In-Reply-To: <20201120021403.2646574-1-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 20 Nov 2020 09:12:22 +0100
Message-ID: <CAMZdPi_tixQ_+uZELCjMh75QtC8RADTCU0ipiS-B6X4OTCbJ5A@mail.gmail.com>
Subject: Re: [PATCH] wcn36xx: Don't run scan_init multiple times
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Benjamin Li <benl@squareup.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 20 Nov 2020 at 03:13, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> Run scan_init only once. There's no need to run this command multiple times
> if it has already been run once.
>
> The software scan algorithm can end up repeatedly calling scan_init on each
> loop resulting in between four and eight milliseconds of lost time on each
> callout.
>
> Subtract the overhead now.

This command defines parameters like the BSSID we want to inform,
etc... So this can change depending on the scan is done while
connected or not. Moreover in the connected case, the scans are
interleaved with normal data listening period, and AFAIU, init/stop
scan allow to submit a null data packet with PS/non-PS bit when
mac80211 leaves the operating channel to scanning another one (so that
AP does no submit packet to it). So at first glance, this patch would
break that, right?



>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/smd.c     | 6 ++++++
>  drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
> index acf533fae46a..ec082cf3ab09 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -706,6 +706,10 @@ int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
>         int ret;
>
>         mutex_lock(&wcn->hal_mutex);
> +       if (wcn->scan_init) {
> +               ret = 0;
> +               goto out;
> +       }
>         INIT_HAL_MSG(msg_body, WCN36XX_HAL_INIT_SCAN_REQ);
>
>         msg_body.mode = mode;
> @@ -731,6 +735,7 @@ int wcn36xx_smd_init_scan(struct wcn36xx *wcn, enum wcn36xx_hal_sys_mode mode,
>                 wcn36xx_err("hal_init_scan response failed err=%d\n", ret);
>                 goto out;
>         }
> +       wcn->scan_init = true;
>  out:
>         mutex_unlock(&wcn->hal_mutex);
>         return ret;
> @@ -761,6 +766,7 @@ int wcn36xx_smd_start_scan(struct wcn36xx *wcn, u8 scan_channel)
>                 wcn36xx_err("hal_start_scan response failed err=%d\n", ret);
>                 goto out;
>         }
> +       wcn->scan_init = false;
>  out:
>         mutex_unlock(&wcn->hal_mutex);
>         return ret;
> diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> index 71fa9992b118..156df6d184c8 100644
> --- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> +++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
> @@ -235,6 +235,7 @@ struct wcn36xx {
>         struct ieee80211_vif    *sw_scan_vif;
>         struct mutex            scan_lock;
>         bool                    scan_aborted;
> +       bool                    scan_init;
>
>         /* DXE channels */
>         struct wcn36xx_dxe_ch   dxe_tx_l_ch;    /* TX low */
> --
> 2.28.0
>
