Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E409F2C99B2
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Dec 2020 09:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgLAIjl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Dec 2020 03:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgLAIjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Dec 2020 03:39:41 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0111AC0613CF
        for <linux-wireless@vger.kernel.org>; Tue,  1 Dec 2020 00:39:01 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id j23so787660iog.6
        for <linux-wireless@vger.kernel.org>; Tue, 01 Dec 2020 00:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDPACJPKS/+NU06F4YsCBzNp0ndTV7vMwkqVpTeSy2s=;
        b=c/0FB32mnW7D7HGJCEUfE1NqdWp3bWkLmN/fYW3cZ91lHtS/AF8bI+7ENVYiDF0wgE
         MGy7jNSVUnhHJYxZu6otHz8p4aaU2UyqOPrKcMCRoR/mr/PNTYdicVhzeBhg1G8Yc02C
         QkizXyGSTyz9XAdACO786kvBMHm/DGPU7SPHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDPACJPKS/+NU06F4YsCBzNp0ndTV7vMwkqVpTeSy2s=;
        b=NpnRHWWkIirCVNN9Shvv/6ClkgE1gXkR5xfH89DWxRCVv2s1E7W5qmdRO6QYyzb8IV
         9xvGjdLYhAmwVgQ1rN1dgzsyq5kZY3tYniEVCW2mdifDpxX6OH0ORzjc8tibOuk3nHje
         BLmYzFmYvf+cA2y8MjtkTPi21ASdE6q0OIaXbIiYNVglLdJDlsDodVC8yQBfRDcmTl//
         YA54pE7DlFHneqiigmgALP27mDVPg1SbXjiyrJ3uOG14ynqO8k89P4/XvalFU/VBqAp/
         4To/LBka/ZQbAEHzqdLUftHdf67RLc9IKhJ8IVEtlRT9XfDS8mEmcLaLK3EYt1eg8gv+
         aOuw==
X-Gm-Message-State: AOAM530Ca5BmqogiRUpAnaNFZqy2mjNafCpIoHtDPoty5X/ZR+VpETK5
        Ath1iGjsuMNU9NS08b1CVogSVzdfl0oTPWq4aTeuKQ==
X-Google-Smtp-Source: ABdhPJyntbgrgN0NR2irkfbO1aeC5spP7En/Kc83MIFkj0fF7DMoNRx00PnMgiKvuL7DMoVMi8F4QDf2+6yR4gUDipM=
X-Received: by 2002:a02:ceb0:: with SMTP id z16mr1738107jaq.40.1606811940432;
 Tue, 01 Dec 2020 00:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20201120085312.4355-1-cjhuang@codeaurora.org> <20201120085312.4355-3-cjhuang@codeaurora.org>
In-Reply-To: <20201120085312.4355-3-cjhuang@codeaurora.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Tue, 1 Dec 2020 00:38:49 -0800
Message-ID: <CACTWRwtMJEoDY3hZKYL-w4h0t85vMPpHktHJH8xt51i6EUu52Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mac80211: add ieee80211_set_sar_specs
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Changes LGTM,
Reviewed-by: Abhishek Kumar <kuabhs@chromium.org>

Thanks
Abhishek

On Fri, Nov 20, 2020 at 12:54 AM Carl Huang <cjhuang@codeaurora.org> wrote:
>
> This change registers ieee80211_set_sar_specs to
> mac80211_config_ops, so cfg80211 can call it.
>
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> ---
> v2:
> - rebased on ToT
>
>  include/net/mac80211.h |  2 ++
>  net/mac80211/cfg.c     | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 05c7524..3576e34 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -4197,6 +4197,8 @@ struct ieee80211_ops {
>                                    struct ieee80211_vif *vif);
>         void (*sta_set_4addr)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>                               struct ieee80211_sta *sta, bool enabled);
> +       int (*set_sar_specs)(struct ieee80211_hw *hw,
> +                            const struct cfg80211_sar_specs *sar);
>  };
>
>  /**
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 7276e66a..f7ff35b 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -4083,6 +4083,17 @@ static int ieee80211_reset_tid_config(struct wiphy *wiphy,
>         return ret;
>  }
>
> +static int ieee80211_set_sar_specs(struct wiphy *wiphy,
> +                                  struct cfg80211_sar_specs *sar)
> +{
> +       struct ieee80211_local *local = wiphy_priv(wiphy);
> +
> +       if (!local->ops->set_sar_specs)
> +               return -EOPNOTSUPP;
> +
> +       return local->ops->set_sar_specs(&local->hw, sar);
> +}
> +
>  const struct cfg80211_ops mac80211_config_ops = {
>         .add_virtual_intf = ieee80211_add_iface,
>         .del_virtual_intf = ieee80211_del_iface,
> @@ -4186,4 +4197,5 @@ const struct cfg80211_ops mac80211_config_ops = {
>         .probe_mesh_link = ieee80211_probe_mesh_link,
>         .set_tid_config = ieee80211_set_tid_config,
>         .reset_tid_config = ieee80211_reset_tid_config,
> +       .set_sar_specs = ieee80211_set_sar_specs,
>  };
> --
> 2.7.4
>
