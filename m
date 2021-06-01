Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F739396DA8
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 09:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhFAHBm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 03:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFAHBl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 03:01:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA69C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 00:00:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k5so7821874pjj.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tTsQuQCsLwRpJgFfs++8bxo0SlKt39W/n7IJcrblXA=;
        b=JpnA24OpoKoXGgpBj1h4n/1yfjU+rM5ob/xduk5M4rCAHCAz3Bkqay5UV/lx02KuIk
         Ed8gkP9L2H/G9fuEwCq0DmgERIFkgEHbBN82OhVHiXyJx7WOKGihSbUBWm7MuX8vNWAm
         VpgVROusZQz9wueweMpsQqpTf7Bq7kFHLZW0/ndv7GNLnM573oup+sMM5SKI+uQMpoAK
         zk1k2Rc+ZzefzJNbtUycKqsqa5QTQ80NWh1TsqsOeYyaEBrjMR8JV6jQoJXgXq2L0jwC
         8zuMGXrk7Jm9O+pk+i/HgqAQ+4WDr5xMAIn1XiA5oIPZ2Ik4ZlK49BEVQx+GeX5mNNwt
         nKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tTsQuQCsLwRpJgFfs++8bxo0SlKt39W/n7IJcrblXA=;
        b=VO3gk1NPQfHhawAXXcsRrMwDcnchnyWLgehFkEP0ACCVrLWOZvObYoA6PYi9UnweNn
         2b+fNKY4kSXY7a68DGpKgoeYjmTS/Ot0OFMlDFcce2O43vkdC0pF48tF7Cp1zO+5HYTC
         ElrgRxTPEBmayagHsiPRs2IPdTu5lx+dD5jqLLg1YzU7sKO6zHmgWGmGFuUx8d55/b2/
         A0IsDLxA0YXsa+qlCp8HJWzwHidRAAhqxq4PhAHcP1U5t8PQhyfvFyIQ1HULDMH0Dr/n
         NwklTRmP76d3bH5dl9XIWQLEl9LAj6n1ASyPldqiOrFKjZl57Ulq4OVJ38LZuRb6JLdO
         sXpw==
X-Gm-Message-State: AOAM532gjyCHy40SNs9XMnPQdf2r6yURR6GIcvb/LP9Rid0iKcwsphsf
        J43qMSHZWvg+84+G2o4+6UVjahEGD1mPerN3sXehuw==
X-Google-Smtp-Source: ABdhPJy2haoxcO6Y5VuEj0cp72xgUUzox0GCtbYSJzUw9oQt9xXjgNaUkNpVZJB8o2TivipvwVUBYv/Cgybl+WvhHAc=
X-Received: by 2002:a17:90b:1b04:: with SMTP id nu4mr23943311pjb.18.1622530799858;
 Mon, 31 May 2021 23:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org> <20210601024920.1424144-3-bryan.odonoghue@linaro.org>
In-Reply-To: <20210601024920.1424144-3-bryan.odonoghue@linaro.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 1 Jun 2021 09:09:19 +0200
Message-ID: <CAMZdPi9VOPdz_4nhjDC1o49eobRPZRkniKtWc4ZLOiGEH3nP6w@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] wcn36xx: Run suspend for the first ieee80211_vif
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bryan,

On Tue, 1 Jun 2021 at 04:47, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> A subsequent set of patches will extend out suspend/resume support in this
> driver, we cannot set the firmware up for multiple ipv4/ipv6 addresses and
> as such we can't iterate through a list of ieee80211_vif.
>
> Constrain the interaction with the firmware to the first ieee80211_vif on
> the suspend/resume/wowlan path.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Benjamin Li <benl@squareup.com>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 30 ++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index b361e40697a6..6802dce2a02b 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1088,15 +1088,34 @@ static int wcn36xx_sta_remove(struct ieee80211_hw *hw,
>
>  #ifdef CONFIG_PM
>
> +static struct ieee80211_vif *wcn36xx_get_first_assoc_vif(struct wcn36xx *wcn)
> +{
> +       struct wcn36xx_vif *vif_priv = NULL;
> +       struct ieee80211_vif *vif = NULL;
> +
> +       list_for_each_entry(vif_priv, &wcn->vif_list, list) {
> +               if (vif_priv->sta_assoc) {
> +                       vif = wcn36xx_priv_to_vif(vif_priv);
> +                       break;
> +               }
> +       }
> +       return vif;
> +}
> +
>  static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
>  {
>         struct wcn36xx *wcn = hw->priv;
> -       int ret;
> +       struct ieee80211_vif *vif = NULL;
> +       int ret = 0;
>
>         wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
>
>         flush_workqueue(wcn->hal_ind_wq);
> -       ret = wcn36xx_smd_set_power_params(wcn, true);
> +       mutex_lock(&wcn->conf_mutex);
> +       vif = wcn36xx_get_first_assoc_vif(wcn);
> +       if (vif)
> +               ret = wcn36xx_smd_set_power_params(wcn, true);
> +       mutex_unlock(&wcn->conf_mutex);
>
>         return ret;
>  }
> @@ -1104,11 +1123,16 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
>  static int wcn36xx_resume(struct ieee80211_hw *hw)
>  {
>         struct wcn36xx *wcn = hw->priv;
> +       struct ieee80211_vif *vif = NULL;
>
>         wcn36xx_dbg(WCN36XX_DBG_MAC, "mac resume\n");
>
>         flush_workqueue(wcn->hal_ind_wq);
> -       wcn36xx_smd_set_power_params(wcn, false);
> +       mutex_lock(&wcn->conf_mutex);
> +       vif = wcn36xx_get_first_assoc_vif(wcn);
> +       if (vif)
> +               wcn36xx_smd_set_power_params(wcn, false);
> +

Where is the balanced mutex_unlock?

>         return 0;
>  }

Regards,
Loic
