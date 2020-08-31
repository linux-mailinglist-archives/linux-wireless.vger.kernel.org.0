Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2710257715
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgHaKDi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 06:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgHaKDg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 06:03:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2ABC061573
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 03:03:36 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so6272688ejb.4
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUrNPwHAyEJZ173srl7yJ4zWD6iw8Xe5jBm0QFIHtEs=;
        b=HT7iwe2b5hSQiz6MGgc3XjqYjTkOpStUMQ7oWRdfIqDMY9Jf66CfYaxp/ocA+kleAr
         b3bPuVThJ7SkFYgfkUi0J5novpnwr9/0SIJ9nadvBS96r7kzt7dwPEtyJnmCbPkU2ArK
         G75EZHJ65VqNawSGmcqhAPOHSA3JKXqkf4Z073ChpPvhizfVevwiLwPLuia+YSHAGu0t
         fdup4EqO52gLMB+VngdXS2tC+qqx02jtQ2u6pHTRfqgDnQhzg36TgPC3vzXosOPngwBy
         kqE2K0dnVjkqZIV0netkLMvdywfYo65au0+zhRt36BLvj5/JT0VzuBWc48WDSDd4dXGm
         dY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUrNPwHAyEJZ173srl7yJ4zWD6iw8Xe5jBm0QFIHtEs=;
        b=tiCoHaxRzw6R6dDhPvJ9jxStilRr7PiP3gHN2DJZH2h4AD+zCvtWIoa3XWJalMx22B
         3GoTRKsvybrWLnD/rQyk0oryMH7lMlNcouu6kXyrlPtst1jewOle0VInCQETu41my/ZU
         1VXwhqNDfp+quRboacD7e41fE8XbhYtPMV6m11Fork2qdvrUQ8EiYrhb3+xsiRDAao6n
         IjhhhSWXGBaCIXKwmx5s5ZA5UB+5gpxNuZNdlAXLgl2YdLsxdAVZ5GmtxUypOFsOT4tD
         TgTj/7w2FhO6JLmeRrZGDmtYJqOgZ+A5IqGgQPnU8a45c1mzC9D2nWmEB5lYlQzL5kHZ
         YMTg==
X-Gm-Message-State: AOAM533oK60OnFF8XdgKxPYz1dhK6DpdCMxrWoDRaBMHLEulqADcgx9D
        qcc904/MrEAhH8eqs1ZUGzWETd9A2Ij1MLduodY10g==
X-Google-Smtp-Source: ABdhPJyNv2UQJUW+p/QiicrOtLOcVuSH5k4D/AmShcFnliYTLpFSKB0dhu8UeHvgBZsy1mEpKt2Y9Quzqc2NNptyssU=
X-Received: by 2002:a17:906:49c9:: with SMTP id w9mr404431ejv.520.1598868214514;
 Mon, 31 Aug 2020 03:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200829033947.2167817-1-bryan.odonoghue@linaro.org> <20200829033947.2167817-6-bryan.odonoghue@linaro.org>
In-Reply-To: <20200829033947.2167817-6-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 31 Aug 2020 12:08:24 +0200
Message-ID: <CAMZdPi_YB7aurY_XsbPeqytPNBUteRkh+VH79mHfESL=rf5LGw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] wcn36xx: Set PHY into correct mode for 80MHz
 channel width
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bryan,

On Sat, 29 Aug 2020 at 05:39, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> For the 80MHz channel we need to set the PHY mode to one of four PHY modes
> that span the 80MHz range.

What about 40Mhz bonding?


>
> This patch latches the hw_value PHY field previously defined for 5GHz
> channels directly to the parameter passed to the firmware.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/smd.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
> index 729708d96586..4b967f8ba949 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -1493,6 +1493,7 @@ int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn, struct ieee80211_vif *vif,
>         struct wcn36xx_hal_config_bss_params_v1 *bss;
>         struct wcn36xx_hal_config_bss_params bss_v0;
>         struct wcn36xx_hal_config_sta_params_v1 *sta;
> +       struct cfg80211_chan_def *chandef;
>         int ret;
>
>         msg_body = kzalloc(sizeof(*msg_body), GFP_KERNEL);
> @@ -1536,7 +1537,13 @@ int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn, struct ieee80211_vif *vif,
>         bss->dtim_period = bss_v0.dtim_period;
>         bss->tx_channel_width_set = bss_v0.tx_channel_width_set;
>         bss->oper_channel = bss_v0.oper_channel;
> -       bss->ext_channel = bss_v0.ext_channel;
> +
> +       if (wcn->hw->conf.chandef.width == NL80211_CHAN_WIDTH_80) {
> +               chandef = &wcn->hw->conf.chandef;
> +               bss->ext_channel = HW_VALUE_PHY(chandef->chan->hw_value);
> +       } else {
> +               bss->ext_channel = bss_v0.ext_channel;
> +       }
>
>         bss->reserved = bss_v0.reserved;
>
> --
> 2.27.0
>
