Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9D227C9E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGUKL4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jul 2020 06:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGUKLz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jul 2020 06:11:55 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D728C061794
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jul 2020 03:11:55 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bm28so14907252edb.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jul 2020 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQBGo1+lqJs52k5JCxF8AFbvxMky+1oLVR+4MIKjmMc=;
        b=bx7bGvpkU20Ugal4eUpOvPHbulnkbQxfla7JcZ6X3lVWrj7/6xSdRxfdDzTJgpTMWl
         uoi9nSppeFVW0JjqscQtL8ITIGBbJ1/wgqqxy2fMqka0zZusdB4K5PAHdzGC0WWPCZ+V
         9agviu/ube+FyZicCpdnuISv+BuAZeQ0JxFteOXs5Fcp6eboZObB+GzAxmvdVf/RymmG
         43F72bHMFKnBxVqYGtn3WJ8+tM8XjNS3PgLzic3FKSrT+J6a9SlqzE3+LMCJqFwmh/PU
         1dmlPYfCr+vnkVSKq5C6XoapoclZaClEev7Ca3sk2oKKXyVR8wn3mFbpWNeDjMaewZkc
         7yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQBGo1+lqJs52k5JCxF8AFbvxMky+1oLVR+4MIKjmMc=;
        b=r2H5QgVGgWYF8jddgD7NBgu5SDcHG78O35EqbcpxfdOwhDxyWapJPxyvLzyd3XgMGR
         hTdlDRDnxPMCVsv+ifYftAqdQ3XJx/w/ilQQG9d856+TmhK3ZgPw8gBdZ9ExeV4wbpeI
         P6mvapIuRZVmh8kq/zZ4CnjcK+fndF8/3Y0/uv5gSC+Giik2Zj3Z2egkSdtAzDZ6m1iL
         1qeRy9Mlae+NBgf//4RbvrbsdsFnQ2ONJnbYmIcIYh45w5RI1BVy+8cZMtgwpi7Dirht
         jXep4ZGnuzUD/A7+Ltan36yRE9hBRA8oem8y7p5bFzu5dNwze3j8TOIZ3EuJI8b0yAJO
         3DDg==
X-Gm-Message-State: AOAM530cFCYt5xRoaiwC+J6q4Axnv6PVnqRttjMdGCeNc1lmHgrierd2
        Nkby72kRg30gUMvY3AbZpIuKdKESNKm1em3RxeYKcrTJ
X-Google-Smtp-Source: ABdhPJzPEbA0h0cYjwhWQ7uvuuiNmvx2831HK33xVQEp2DRom1S1JLASHWOCzzFFB65yOFVx7GH3L/oFH6ReYDFaK+I=
X-Received: by 2002:a05:6402:1bdd:: with SMTP id ch29mr25237460edb.134.1595326314057;
 Tue, 21 Jul 2020 03:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <1593524821-32115-1-git-send-email-loic.poulain@linaro.org>
 <1593524821-32115-2-git-send-email-loic.poulain@linaro.org> <875zaiayu7.fsf@tynnyri.adurom.net>
In-Reply-To: <875zaiayu7.fsf@tynnyri.adurom.net>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 21 Jul 2020 12:16:48 +0200
Message-ID: <CAMZdPi9ZYpO_STLcWqabqXA8+XaJRmod2tS=D_UvuA4=CX6rTA@mail.gmail.com>
Subject: Re: [PATCH 2/4] wcn36xx: Add TX ack support
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 20 Jul 2020 at 19:19, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Loic Poulain <loic.poulain@linaro.org> writes:
>
> > The controller is capable of reporting TX indication which can be used
> > to report TX ack. It was only partially implemented.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>
> [...]
>
> > +static void wcn36xx_dxe_tx_timer(struct timer_list *t)
> > +{
> > +     struct wcn36xx *wcn = from_timer(wcn, t, tx_ack_timer);
> > +     struct ieee80211_tx_info *info;
> > +     unsigned long flags;
> > +     struct sk_buff *skb;
> > +
> > +     /* TX Timeout */
> > +     wcn36xx_dbg(WCN36XX_DBG_DXE, "TX timeout\n");
> > +
> > +     spin_lock_irqsave(&wcn->dxe_lock, flags);
> > +     skb = wcn->tx_ack_skb;
> > +     wcn->tx_ack_skb = NULL;
> > +     spin_unlock_irqrestore(&wcn->dxe_lock, flags);
> > +
> > +     if (!skb)
> > +             return;
> > +
> > +     info = IEEE80211_SKB_CB(skb);
> > +     info->flags &= ~IEEE80211_TX_STAT_ACK;
> > +     info->flags &= ~IEEE80211_TX_STAT_NOACK_TRANSMITTED;
> > +
> > +     ieee80211_tx_status_irqsafe(wcn->hw, skb);
> > +     ieee80211_wake_queues(wcn->hw);
> > +}
>
> What's this timer thing? The commit log mentions nothing about that. To
> me this looks like a some kind of TX timeout detection and has nothing
> to do ACK handling, but of course I might have misunderstood.
>
> Should it be in a separate patch to follow one logical change per patch
> rule?

This is part of ack management, I could have named it dex_ack_timer though...
When we send a packet requesting explicit ack notification via mac80211
status callback, we ask the firmware to return an ack event and stop tx queue
temporarily until the ack event is received. But if for any reasons the 802.11
packet is not acked, firmware never sends this event, causing stale of the
TX path.

So the timer is here to handle the no-ack case, in order to
1. run the mac80211 status callback (packet not acked)
2. unblock TX queue

> > --- a/drivers/net/wireless/ath/wcn36xx/smd.c
> > +++ b/drivers/net/wireless/ath/wcn36xx/smd.c
> > @@ -45,8 +45,8 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
> >       WCN36XX_CFG_VAL(MAX_MEDIUM_TIME, 6000),
> >       WCN36XX_CFG_VAL(MAX_MPDUS_IN_AMPDU, 64),
> >       WCN36XX_CFG_VAL(RTS_THRESHOLD, 2347),
> > -     WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 6),
> > -     WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 6),
> > +     WCN36XX_CFG_VAL(SHORT_RETRY_LIMIT, 15),
> > +     WCN36XX_CFG_VAL(LONG_RETRY_LIMIT, 15),
>
> Also there's no mention of these changes in the commit log. Should these
> in a third patch as they are more like a separate change?

Correct, this change increases the number of TX retries, to improve robustness,
and have more chances to have a packet acked. 15 is the default value defined
by the downstream driver. I observed much less ack timeout in a noisy
environment with that change.

So I can rework the commit for with ack timer info, and move the
config change in a separate change.

Regards,
Loic
