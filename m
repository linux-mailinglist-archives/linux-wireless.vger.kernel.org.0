Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1892576B7
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 11:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgHaJkQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 05:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgHaJkP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 05:40:15 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4A2C061573
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 02:40:14 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so6189458ejb.4
        for <linux-wireless@vger.kernel.org>; Mon, 31 Aug 2020 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ic/VSH23zeKfZRSxbocQ/bKGuRGO9ENZhzNFqQJBZIY=;
        b=eErKy5eNtztBlkqm0NNe747+Nv9JgN1xufD7gVE66XcIc7+D/jmq5Q7objo8E39OnK
         D6U3CgX3lEirMmJAZ8qcTV6Iir4UmX93agW3R3jejA9lOG6gSJsFqv03fFZvEhEFesgn
         Jr69G6UDLRbXAUbSqR60WGDm3k4li2qpzy/6XXPafETwQNhfBW6ATqTvZ1yTeB/P5qX7
         ph4FuKiZOeDrPlXjI3x5RmbLjzmq65GDx5hjUXPlXwlCS9YhTPQQpQnA6Ug/fBrjknIV
         Pa5WCwegwzWAlkhi71enk+7KwK0jA3JxEhMGIBL0Ghb0jXKfX3iGMB+veG3di8SAGbAM
         yx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ic/VSH23zeKfZRSxbocQ/bKGuRGO9ENZhzNFqQJBZIY=;
        b=GBtk59ZjGNe9CuaQo7NYF0OXCFUsajxQ+vx2Vf3XHDUfnRifKjAHFwau6vHCGxlI28
         uA+KbjEmqs8+PQw4WPXMCu+KXKByeCW3cX5u93w19eJDCOR3maSUu4vuN5dn1ah59oJE
         wW3a5A5KuPd/PRr+wqaJhO9KW/72b/lrC/55tI7f4MqWCpmPZMyxQPU/9lu+Teif/jfN
         YBU1a5yJv4SYO8FhQVkEQqDzzgltAW7a4yvUhGVtK8BQ7o19iXSXFb/jfkpYsV+n5VZo
         E/PBPmz+6qypMRFcKpW7yc7bICyyKNR53gK0ZKBBRN4Xw8nBVGxVgVOp+G/unr6y6GUt
         bCcA==
X-Gm-Message-State: AOAM532QhR+5uf0Ljjzgqu/SjrB2IbUeUFXnFTZVKU4M33Z2xpYmpCgM
        MDsQV3XgxItziaB4bnEPuCtyO3jWRn17ywmRm3Qqrg==
X-Google-Smtp-Source: ABdhPJwHNo7437DTYVbSBmX+lEt3eOc/UZ16S4ooebfUxxh2W8JI35UiE5s/tIa6aMYKddsA2VIQ2ew1gtUu+AhNwJw=
X-Received: by 2002:a17:906:91c8:: with SMTP id b8mr324385ejx.103.1598866813372;
 Mon, 31 Aug 2020 02:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
In-Reply-To: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 31 Aug 2020 11:45:04 +0200
Message-ID: <CAMZdPi___9yry0icuZVdnyiO7ZT0w=Xt8f8Pn7wkxRejxhXyYw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] wcn36xx: Tidy up BSS/STA config
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 29 Aug 2020 at 05:38, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> This series is three of a set of five to add support for wcn3680 at
> 802.11ac data-rates.
>
> Both the BSS and STA config paths have redundant/duplicate code and before
> adding more code to either it makes sense to reduce/reuse and functionally
> decompose as much as possible.
>
> While not strictly necessary to get the wcn3680/80211.ac functioning in
> this driver, it seems like a missed opportunity to leave the code as is.
>
> Lets reduce down before adding more.

It looks good to me.
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

Regards,
Loic


On Sat, 29 Aug 2020 at 05:38, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> This series is three of a set of five to add support for wcn3680 at
> 802.11ac data-rates.
>
> Both the BSS and STA config paths have redundant/duplicate code and before
> adding more code to either it makes sense to reduce/reuse and functionally
> decompose as much as possible.
>
> While not strictly necessary to get the wcn3680/80211.ac functioning in
> this driver, it seems like a missed opportunity to leave the code as is.
>
> Lets reduce down before adding more.
>
> V2:
> - Adds a memset to wcn36xx_smd_config_bss_v1()
>   Since we are doing one less kzalloc() we need to make sure we clear
>   out the bss config.
>
> V1:
> https://lore.kernel.org/linux-wireless/87eensldhi.fsf@codeaurora.org/T/#t
>
> Bryan O'Donoghue (7):
>   wcn36xx: Functionally decompose wcn36xx_smd_config_sta()
>   wcn36xx: Move wcn36xx_smd_set_sta_params() inside
>     wcn36xx_smd_config_bss()
>   wcn36xx: Move BSS parameter setup to wcn36xx_smd_set_bss_params()
>   wcn36xx: Add wcn36xx_smd_config_bss_v0
>   wcn36xx: Update wcn36xx_smd_config_bss_v1() to operate internally
>   wcn36xx: Convert to using wcn36xx_smd_config_bss_v0()
>   wcn36xx: Remove dead code in wcn36xx_smd_config_bss()
>
>  drivers/net/wireless/ath/wcn36xx/smd.c | 416 ++++++++++++++-----------
>  1 file changed, 227 insertions(+), 189 deletions(-)
>
> --
> 2.27.0
>
