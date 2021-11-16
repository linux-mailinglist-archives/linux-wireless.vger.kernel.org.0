Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A93F453367
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 14:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhKPOBU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 09:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbhKPOBT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 09:01:19 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF360C061746
        for <linux-wireless@vger.kernel.org>; Tue, 16 Nov 2021 05:58:21 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id l22so53453003lfg.7
        for <linux-wireless@vger.kernel.org>; Tue, 16 Nov 2021 05:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zKZ9mRUbYLNaVGXGf+VydbMCwsTe3+1i5Wwmru3IySw=;
        b=IYaTFT3PgNW29IololzuYXaYNhhjQ+WWtH20r/LJ8G6Kqzksi67XJ/KNukAZ8821SI
         649nmUSrr9JUqQEjt05beDyWBvK61/CiasT0PyMN5bGvvnrMqnPChprMtLw++dL5jbxP
         ImX8ismY1bIyWl8tT5Nh2QBAXEpWyqiHLfi+x08x87tJxZrhSHZQVghibwmbR9ygFl9R
         M5oi834mNg5boSa0ms8neFd0iVDucGUBc24qKE7UcUrQTgRQrI+86SQT71ui+CSpOqQy
         fre5+IWzTq9VRdfthEHa8B1Q4FDqVr4eLarDQ2pjEezSNQqAX03QqRLeGC6U8yliAiFK
         UiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zKZ9mRUbYLNaVGXGf+VydbMCwsTe3+1i5Wwmru3IySw=;
        b=NQOgQMfhEopO1EGMgcownZyV78aQGUD5HwoCrgk+21+K2GaHQhFizhykqfqV0sptHr
         xirYmjoA8trX9qs2rz+VzZN0sbdrcrvVcFByOlO15XycNqv+Cb3zog0DXj5Fcjj/YMP3
         cWt/+sFuz8kllA5kfrStrMep42j/AKaxW+0MRwJdy/SQdHPG84zDA4EAfv04B4lBIxwD
         38kvZW4D+x1YpkRznyeancgrNhG8mGXaQtH9VqtTE+gJT+bh2CpMzNoV9xZ8L3fb0yZV
         C2AgoRokQnxQWDspC7SOqicR6TIxp0F4ug5Rl61XUvx1uosLoScg4s/RkUWJlv4jvYmn
         V+wA==
X-Gm-Message-State: AOAM532NG3IxP8Ow344hlNiKWDb0aH34WYQ3ihXqEphl57hBgVJydpHE
        oxwHvcSNmlz0/SGZinjn+GD+PdBJXEwAdIuSbe5SIk9//2xhtg==
X-Google-Smtp-Source: ABdhPJxDTW0SQIQM2+mjaqKfvtyfzB2+p+1KOowkn+uDIdngfybhehAUh9O96bim7g2IT+T/FxoicgafVdMCZkq6nN4=
X-Received: by 2002:a05:6512:239c:: with SMTP id c28mr6920396lfv.502.1637071100325;
 Tue, 16 Nov 2021 05:58:20 -0800 (PST)
MIME-Version: 1.0
References: <3ff583e021e3343a3ced54a7b09b5e184d1880dc.1637062727.git.lorenzo@kernel.org>
In-Reply-To: <3ff583e021e3343a3ced54a7b09b5e184d1880dc.1637062727.git.lorenzo@kernel.org>
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Tue, 16 Nov 2021 14:58:09 +0100
Message-ID: <CAFED-j=i9wuN4JuiF4z2q5qbrhrLL_Php7pi6mpniMUeHHFUPA@mail.gmail.com>
Subject: Re: [PATCH mac80211-next] cfg80211: schedule offchan_cac_abort_wk in cfg80211_radar_event
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com, owen.peng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wt., 16 lis 2021 o 12:46 Lorenzo Bianconi <lorenzo@kernel.org> napisa=C5=82=
(a):
>
> If necessary schedule offchan_cac_abort_wk work in cfg80211_radar_event
> routine adding offchan parameter to cfg80211_radar_event signature.
> Rename cfg80211_radar_event in __cfg80211_radar_event and introduce
> the two following inline helpers:
> - cfg80211_radar_event
> - cfg80211_offchan_radar_event
> Doing so the drv will not need to run cfg80211_offchan_cac_abort() after
> radar detection on the offchannel chain.
>
> Tested-by: Owen Peng <owen.peng@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/cfg80211.h | 24 +++++++++++++++++++++---
>  net/wireless/mlme.c    | 16 ++++++++++------
>  net/wireless/trace.h   | 11 +++++++----
>  3 files changed, 38 insertions(+), 13 deletions(-)
>

BTW, if we don't have user for this yet, maybe we should change name
offchannel -> background.
In ETSI spec
https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_30=
1893v020101p.pdf
we have off-channel CAC defined little bit different:

"Off-Channel CAC is performed by a number of non-continuous checks
spread over a period in time. This period, which is required to
determine the presence of radar signals, is defined as the Off-Channel
CAC Time."

And:
"Minimum Off-Channel CAC Time 6 minutes (see note 2) Maximum
Off-Channel CAC Time 4 hours (see note 2)"

So, your implementation simple run "background CAC" - use one (or
more) chain for that.

BR
Janusz



> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 362da9f6bf39..a887086cb103 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -7605,15 +7605,33 @@ void cfg80211_cqm_txe_notify(struct net_device *d=
ev, const u8 *peer,
>  void cfg80211_cqm_beacon_loss_notify(struct net_device *dev, gfp_t gfp);
>
>  /**
> - * cfg80211_radar_event - radar detection event
> + * __cfg80211_radar_event - radar detection event
>   * @wiphy: the wiphy
>   * @chandef: chandef for the current channel
> + * @offchan: the radar has been detected on the offchannel chain
>   * @gfp: context flags
>   *
>   * This function is called when a radar is detected on the current chane=
nl.
>   */
> -void cfg80211_radar_event(struct wiphy *wiphy,
> -                         struct cfg80211_chan_def *chandef, gfp_t gfp);
> +void __cfg80211_radar_event(struct wiphy *wiphy,
> +                           struct cfg80211_chan_def *chandef,
> +                           bool offchan, gfp_t gfp);
> +
> +static inline void
> +cfg80211_radar_event(struct wiphy *wiphy,
> +                    struct cfg80211_chan_def *chandef,
> +                    gfp_t gfp)
> +{
> +       __cfg80211_radar_event(wiphy, chandef, false, gfp);
> +}
> +
> +static inline void
> +cfg80211_offchan_radar_event(struct wiphy *wiphy,
> +                            struct cfg80211_chan_def *chandef,
> +                            gfp_t gfp)
> +{
> +       __cfg80211_radar_event(wiphy, chandef, true, gfp);
> +}
>
>  /**
>   * cfg80211_sta_opmode_change_notify - STA's ht/vht operation mode chang=
e event
> diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> index ac2e5e732d94..450be1ec70b8 100644
> --- a/net/wireless/mlme.c
> +++ b/net/wireless/mlme.c
> @@ -905,13 +905,13 @@ void cfg80211_dfs_channels_update_work(struct work_=
struct *work)
>  }
>
>
> -void cfg80211_radar_event(struct wiphy *wiphy,
> -                         struct cfg80211_chan_def *chandef,
> -                         gfp_t gfp)
> +void __cfg80211_radar_event(struct wiphy *wiphy,
> +                           struct cfg80211_chan_def *chandef,
> +                           bool offchan, gfp_t gfp)
>  {
>         struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy);
>
> -       trace_cfg80211_radar_event(wiphy, chandef);
> +       trace_cfg80211_radar_event(wiphy, chandef, offchan);
>
>         /* only set the chandef supplied channel to unavailable, in
>          * case the radar is detected on only one of multiple channels
> @@ -919,6 +919,9 @@ void cfg80211_radar_event(struct wiphy *wiphy,
>          */
>         cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_UNAVAILABLE);
>
> +       if (offchan)
> +               queue_work(cfg80211_wq, &rdev->offchan_cac_abort_wk);
> +
>         cfg80211_sched_dfs_chan_update(rdev);
>
>         nl80211_radar_notify(rdev, chandef, NL80211_RADAR_DETECTED, NULL,=
 gfp);
> @@ -926,7 +929,7 @@ void cfg80211_radar_event(struct wiphy *wiphy,
>         memcpy(&rdev->radar_chandef, chandef, sizeof(struct cfg80211_chan=
_def));
>         queue_work(cfg80211_wq, &rdev->propagate_radar_detect_wk);
>  }
> -EXPORT_SYMBOL(cfg80211_radar_event);
> +EXPORT_SYMBOL(__cfg80211_radar_event);
>
>  void cfg80211_cac_event(struct net_device *netdev,
>                         const struct cfg80211_chan_def *chandef,
> @@ -998,7 +1001,8 @@ __cfg80211_offchan_cac_event(struct cfg80211_registe=
red_device *rdev,
>                 rdev->offchan_radar_wdev =3D NULL;
>                 break;
>         case NL80211_RADAR_CAC_ABORTED:
> -               cancel_delayed_work(&rdev->offchan_cac_done_wk);
> +               if (!cancel_delayed_work(&rdev->offchan_cac_done_wk))
> +                       return;
>                 wdev =3D rdev->offchan_radar_wdev;
>                 rdev->offchan_radar_wdev =3D NULL;
>                 break;
> diff --git a/net/wireless/trace.h b/net/wireless/trace.h
> index 0b27eaa14a18..e854d52db1a6 100644
> --- a/net/wireless/trace.h
> +++ b/net/wireless/trace.h
> @@ -3053,18 +3053,21 @@ TRACE_EVENT(cfg80211_ch_switch_started_notify,
>  );
>
>  TRACE_EVENT(cfg80211_radar_event,
> -       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef),
> -       TP_ARGS(wiphy, chandef),
> +       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef,
> +                bool offchan),
> +       TP_ARGS(wiphy, chandef, offchan),
>         TP_STRUCT__entry(
>                 WIPHY_ENTRY
>                 CHAN_DEF_ENTRY
> +               __field(bool, offchan)
>         ),
>         TP_fast_assign(
>                 WIPHY_ASSIGN;
>                 CHAN_DEF_ASSIGN(chandef);
> +               __entry->offchan =3D offchan;
>         ),
> -       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
> -                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
> +       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT ", offchan %d",
> +                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG, __entry->offchan)
>  );
>
>  TRACE_EVENT(cfg80211_cac_event,
> --
> 2.31.1
>


--=20
Janusz Dziedzic
