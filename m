Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB792A14CC
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 10:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgJaJ2F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Oct 2020 05:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgJaJ2E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Oct 2020 05:28:04 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3107EC0613D5
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 02:28:03 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l16so9167572eds.3
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvuOPTTNBuzvE6VSgAHKvB9UeM82FwMD7hIlgUB7AEg=;
        b=XtbtCa+rqz++YljW0lMDjiLiqVjQLC625v1n69pWBOtOqb53H0CdVD+DnsTS4QJCsY
         6iKiXQ+JiDyJV5UxkTTCpuJhahrkp8EOTAb/c85Y+kEkhUEvISB5UrhuKVcHiCWQlfmf
         PArpPyZf/nPkjhvMflTFq6BAa4kgKU+5LTnlyCosLPWhJ4kOd2q6EjUubefXC8lHu+Iz
         6uWUkYnjE+eSmaYCyiTlzpaGwQkyOTgFiK2JSLumFmBtjsYyRHnLc32h+CMhNFuYdzI4
         NWXDHmWV1Owr/QTvo3+1yBbK+ZJ1c9RdUYPly/2PjLISmM/HvM1ho2LKEi+jiDgkOqHo
         Q9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvuOPTTNBuzvE6VSgAHKvB9UeM82FwMD7hIlgUB7AEg=;
        b=o1swiUzybvv9Orc13rJEmYtUi9DwLS7hrTXnEUqxiWePAsT+t7XqESEn3AnM5pQfEB
         0LnTRHSC0z7jKW8+OwSIj7IHGAtZpi3z4ZGvtEgsVnd8iaNVtNxcs8TmT4C2GuejE/xU
         GqB46FKsFU6/L9CFJQE0YkCsYOv9Zi1vm7ilI+K48C6xwdc1l9r2boGpM3hYdI0oaCPl
         Hwv3XNlMlF02CwJL2EXiXBMLgTr2I2MJxeMXQvGURj4obWnvC1yMjSyKL+Dfi6GkaeXy
         VieZ6FZzjugGuZiAHHx6fdZ79BmCb8z++Wf7WDMujjykzZXDOSNmB+8gsiwYMUzxID3R
         1XQA==
X-Gm-Message-State: AOAM530ii/asw0cgf6GUcfcyJ6j+zjpK8FIY2hwWgXwfQ7ALcZ2b146P
        itTGWoSv7ppxB0lNBfA8n6rgDS5sQbcAfamQJJGiPw==
X-Google-Smtp-Source: ABdhPJxo838JK4mBGsW/D3rFk99+F0RuSivVMdR29ub0FVARS89XZmw5716i1+nCDV9pV+Lvb9xPyPI9I2kaBy6+pTE=
X-Received: by 2002:a05:6402:287:: with SMTP id l7mr6620065edv.212.1604136481893;
 Sat, 31 Oct 2020 02:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201031022311.1677337-1-bryan.odonoghue@linaro.org> <20201031022311.1677337-2-bryan.odonoghue@linaro.org>
In-Reply-To: <20201031022311.1677337-2-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Sat, 31 Oct 2020 10:33:57 +0100
Message-ID: <CAMZdPi9cOzGb8ursDU5Y6XbY7gP9-_f+LhAv7bRVLZZQgy6JJg@mail.gmail.com>
Subject: Re: [PATCH 1/3] wcn36xx: Set LINK_FAIL_TX_CNT non zero on wcn3620/wcn3660
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HI Bryan,

On Sat, 31 Oct 2020 at 03:22, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> The firmware parameter LINK_FAIL_TX_CNT maps to the prima configuration
> file parameter gLinkFailTxCnt and is described as:
>
> quote: " If within gLinkFailTimeout period(values is mentioned in msec) if
>          FW doesn't receive acks for gLinkFailTxCnt number of packets, then
>          link will be disconnected."
>
> The downstream description sets a minimum value of 1000 a maximum value of
> 60000 and a default value of 6000, however it appears that unless we
> actually set this value deliberately firmware defaults it to 0.
>
> Setting this value to non-zero results in the firmware doing link
> monitoring.
>
> In conjunction with ieee80211_hw_set(wcn->hw, CONNECTION_MONITOR); this
> change effects offload of link monitoring to the firmware.
>
> Tested with:
> 'CNSS-PR-2-0-1-2-c1-74-130449-3' wcn3620
> 'CNSS-PR-2-0-1-2-c1-00083'       wcn3680
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/smd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
> index 766400f7b61c..262978371c1f 100644
> --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> @@ -78,6 +78,7 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
>         WCN36XX_CFG_VAL(MAX_ASSOC_LIMIT, 10),
>         WCN36XX_CFG_VAL(ENABLE_MCC_ADAPTIVE_SCHEDULER, 0),
>         WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 133), /* MCS 5 */
> +       WCN36XX_CFG_VAL(LINK_FAIL_TX_CNT, 200),

Could you set the value to the minimum value described in the
downstream driver (i.e 1000)? Not sure a lower value is supported on
all wcn36xx firmware versions. So better to align with the
recommendations.

>  };
>
>  static struct wcn36xx_cfg_val wcn3680_cfg_vals[] = {
> --
> 2.28.0
>
