Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C8F2A14D7
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 10:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgJaJd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Oct 2020 05:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJaJd4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Oct 2020 05:33:56 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D3AC0613D5
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 02:33:56 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o21so4858565ejb.3
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCM2e3iv/W0Mv/aI2ozgygl+TGhRSA93U6OS9gBPIUE=;
        b=Pb5CwuuH/MVEKL+8pAt+/hzPBkCLISzg9k2lXwqZczOqTxdMLg6wSm5ELjTTwzREeh
         TyO3PPpOXg/a+Lap/TOo+iQpso8K+7PBaJpF5d4BRMv+wjKJr8cyHj0UrY+hvpIMXGRq
         hOJ372BDe/YttqbSGKu9CRv/ocRolgRw6Ykd59Yzv3ipE0RxVzydEOpbLYVfgz8NDEId
         aRqWfJHgPl4BDko1QKBegfFnySW/7+3N3vn98ZH63iyne0OVOTz955uYMGHBaG31hKOi
         X9K2EokehrPPq6zVSisMmWZO22zOp6rpUiGkfBwq5ruNfse58FMsjDEpXtnS+bK8RXca
         F6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCM2e3iv/W0Mv/aI2ozgygl+TGhRSA93U6OS9gBPIUE=;
        b=DWIJRD8ZfOPzUOQKPPpvdiS5/41IO0cFPqZCb0OncduZhXonLLve8TsMvOlPgnbGyY
         rT4sDh9CO/hBxO3TzHbppREzyuO9S7N0gmmTwanpdZtZbXk4FcQ7YIHmYkMmJMI3VsLK
         YXYzaaIS0wfYTOgRkGmRpr/5VEv4GYukz/M7jO9KOUG12KLmMiIlE+GfIQAOX2bgTMhw
         3TqdUsUa3/P5dRlsKjOxZ73usjnp+kp2Wu6gACuRFbgXj0teAoOztaM4Wh5zXAQ9Ep2o
         r3lA+40Yt/Qrqp2BQri1m3b4/IaxTZCFsTt/tVLmSR5oIonfdc+5oagrq7SShnq87x1e
         sYng==
X-Gm-Message-State: AOAM531zII2/Jsuys9A3ysAoY01vUCVm4iWjP9SLi0mpo7ZnWt6R7iOl
        TB8LLbs2rOAVP775ubJPMb2WoXjKYyzYr/Jv5W4ZIA==
X-Google-Smtp-Source: ABdhPJw0WjrtVfIABYww/bxCZjU7lDIRAB++inHECvmAf90hQuzwyNEFc2cMPckHyfX8Ez+esca7O0RQhqhtZLafeec=
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr6356717ejf.466.1604136835020;
 Sat, 31 Oct 2020 02:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201031022311.1677337-1-bryan.odonoghue@linaro.org> <20201031022311.1677337-4-bryan.odonoghue@linaro.org>
In-Reply-To: <20201031022311.1677337-4-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Sat, 31 Oct 2020 10:39:50 +0100
Message-ID: <CAMZdPi86jzZ_A6OuBH=0NvdA=YXMjgXb+UaX5gajHffh20MgmQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] wcn36xx: Enable firmware offloaded keepalive
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
> This patch calls wcn36xx_smd_keep_alive_req() on the STA patch immediately
> after associating with an AP.
>
> This will cause the firmware to send a NULL packet out to the AP every 30
> seconds, thus offloading keep-alive processing from the SoC to the
> firmware.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index e924cc4acde0..b514a7b952df 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -910,6 +910,8 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
>                          * place where AID is available.
>                          */
>                         wcn36xx_smd_config_sta(wcn, vif, sta);
> +                       wcn36xx_smd_keep_alive_req(wcn, vif,
> +                                       WCN36XX_HAL_KEEP_ALIVE_NULL_PKT);

There is the wcn36xx_enable_keep_alive_null_packet function (from
pmc.c) that you can use.

>                 } else {
>                         wcn36xx_dbg(WCN36XX_DBG_MAC,
>                                     "disassociated bss %pM vif %pM AID=%d\n",
> --
> 2.28.0
>
