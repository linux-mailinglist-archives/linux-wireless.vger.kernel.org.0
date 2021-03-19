Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808D8342271
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhCSQuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCSQtu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:49:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C33C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:49:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so8712816pjb.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Su0be2rH9hYJQ3cvOyy8JiqmJDGZuMOWJ6ZV42oiItk=;
        b=Rw02qvByspBD4VytfFilcHO99dnfOpAbUYBBKixgsWm3YNFGAWUPCfry+2yLpWU0Fm
         AS9nqKQt7aXaX4WKh66pUPVcHdH3cdgtmpy81ljhSv0cn5mvklJJhAeyK+A0arsA8uaF
         0Lvy5jxuJ9uYJ8PYlsc/APvS0Pke0zupG4TNklcYuZlLD8ZvokUYr1HpwvVD/uBvVtgG
         ZhMQGwxKIxkxeew0PN978Jzyo+Dup5zFE392cm2Gtb6MOkCWriizOt2x8pBhL+Tg89Lc
         nVjmPWvlUnp636gv9D1DaKPhzrZdhVfO6LkKu6nhWQfFtrdcmxDcxvgmyASsi0GSAzIr
         CsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Su0be2rH9hYJQ3cvOyy8JiqmJDGZuMOWJ6ZV42oiItk=;
        b=lZE0n2F1wC9u7ViDNtnSRDSyDsaO53erhQeDGSaFN3FmecqP/kndmfPyG0t9c7VGLR
         UR70e0DEBPKmCZ21qaBRn8O0plabHlj1kbdRh2MU2+hY4X5Ms6+pDny/G0qtZ2FKLMaq
         xrgPzRejE4/PrTnoVEt2krpWRE5Vp+Y7N5KfG+8ReHOeC+WdZwCGF+IKNqLo8teLSTcW
         REsCT/cSZiN/6mzgOrRB4dEYJHGiAnf4kQ5VjQrf77BeBbY6L+SzPRr86lLsfbMkMLHV
         6Q75glceWpTyMrJTQSWKg9o6QtNigC/CmldFCs6q3UueXqp8vL3lKJpSoKqVDy3T+St/
         CNXg==
X-Gm-Message-State: AOAM531xqCsg3E4vxGHU/G9t/tBIUW+sANIYJsSGp3R2K2TkOesuyYW4
        CdkwA5h9cE4T+el+7XBti8/Ire5UQ13EB7CSo9bmhw==
X-Google-Smtp-Source: ABdhPJwjUUj9zMpF5RaLIDSOTFUrKj8BO+7NpeM8NkaEmI/7H4kqCNIneg0cSy1Xzf8oXfI6fAjiIK2nj181ow9tk4I=
X-Received: by 2002:a17:902:7287:b029:e5:bd05:4a97 with SMTP id
 d7-20020a1709027287b02900e5bd054a97mr14884682pll.27.1616172590069; Fri, 19
 Mar 2021 09:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org> <20210319161520.3590510-3-bryan.odonoghue@linaro.org>
In-Reply-To: <20210319161520.3590510-3-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 19 Mar 2021 17:57:51 +0100
Message-ID: <CAMZdPi8ahq61qOxyjci4KyMANGxSt2oey2y1U=NNOKs1Mu+sPw@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] wcn36xx: Run suspend for the first ieee80211_vif
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 19 Mar 2021 at 17:13, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> A subsequent set of patches will extend out suspend/resume support in this
> driver, we cannot set the firmware up for multiple ipv4/ipv6 addresses and
> as such we can't iterate through a list of ieee80211_vif.

You mean connection can only be maintained (offloaded) in suspend for
only one vif? If so maybe what you want to retrieve is the first
client-associated vif and not the first vif.

>
> Constrain the interaction with the firmware to the first ieee80211_vif on
> the suspend/resume/wowlan path.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 43 +++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index b361e40697a6..c0c1ea18864f 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1088,15 +1088,39 @@ static int wcn36xx_sta_remove(struct ieee80211_hw *hw,
>
>  #ifdef CONFIG_PM
>
> +struct ieee80211_vif *wcn36xx_get_first_vif(struct wcn36xx *wcn)
> +{
> +       struct wcn36xx_vif *tmp;
> +       struct ieee80211_vif *vif = NULL;
> +
> +       list_for_each_entry(tmp, &wcn->vif_list, list) {
> +               vif = wcn36xx_priv_to_vif(tmp);
> +               if (vif)
> +                       break;
> +       }
> +       return vif;
> +}
> +
>  static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
>  {
>         struct wcn36xx *wcn = hw->priv;
> -       int ret;
> +       struct ieee80211_vif *vif = NULL;
> +       struct wcn36xx_vif *vif_priv = NULL;
> +       int ret = 0;
>
>         wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
>
>         flush_workqueue(wcn->hal_ind_wq);
> -       ret = wcn36xx_smd_set_power_params(wcn, true);
> +       mutex_lock(&wcn->conf_mutex);
> +       vif = wcn36xx_get_first_vif(wcn);
> +       if (vif) {
> +               vif_priv = wcn36xx_vif_to_priv(vif);
> +               if (!vif_priv->sta_assoc)
> +                       goto out;
> +               ret = wcn36xx_smd_set_power_params(wcn, true);
> +       }
> +out:
> +       mutex_unlock(&wcn->conf_mutex);
>
>         return ret;
>  }
> @@ -1104,11 +1128,24 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
>  static int wcn36xx_resume(struct ieee80211_hw *hw)
>  {
>         struct wcn36xx *wcn = hw->priv;
> +       struct ieee80211_vif *vif = NULL;
> +       struct wcn36xx_vif *vif_priv = NULL;
>
>         wcn36xx_dbg(WCN36XX_DBG_MAC, "mac resume\n");
>
>         flush_workqueue(wcn->hal_ind_wq);
> -       wcn36xx_smd_set_power_params(wcn, false);
> +       mutex_lock(&wcn->conf_mutex);
> +       vif = wcn36xx_get_first_vif(wcn);
> +       if (vif) {
> +               vif_priv = wcn36xx_vif_to_priv(vif);
> +               if (!vif_priv->sta_assoc)
> +                       goto out;
> +
> +               wcn36xx_smd_set_power_params(wcn, false);
> +       }
> +out:
> +       mutex_unlock(&wcn->conf_mutex);
> +
>         return 0;
>  }
>
> --
> 2.30.1
>
