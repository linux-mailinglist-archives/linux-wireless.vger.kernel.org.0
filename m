Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654CB453417
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 15:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhKPO1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 09:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhKPO1F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 09:27:05 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5C0C061570
        for <linux-wireless@vger.kernel.org>; Tue, 16 Nov 2021 06:24:08 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f18so53738175lfv.6
        for <linux-wireless@vger.kernel.org>; Tue, 16 Nov 2021 06:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kUBb4bJDf8zAaOWpJjfchYvrefQu/OVqwJFsRVkaBc0=;
        b=Oq+gVwYzcUbgKwVTQ+0tYYZTwIRSa6mExZg3TI+n6/dWPzYz1bRCxwj3L1PnAyF0aC
         Y2ep3mtGzUaysbrjqaNYqB4LRlmVl4Ae10aYfW82czwzUlLC/6qG6VgdKeyf+6RTmTqW
         wCrqyGmTzAJOpPTHITZEiWCNCpoBW21OCXkY56ef9J2UkOj0hK1/fuGb3S2+s+hKni31
         dYo0dSaNdCwdBP87nkv/+QXtN12Y8X+btnzzVUX6eGaAdyhhNZjig7EliOe2HjMGhU62
         b7thuBsEEIO3hx6b9YedUMPzwvVFb2rwvXdVOHRuFp+t513fSiwh6n8vVJUWBxpSBysh
         pIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kUBb4bJDf8zAaOWpJjfchYvrefQu/OVqwJFsRVkaBc0=;
        b=ZMwVkFCjgVaWImbDCqO16mlgkUJaTJZjj0FR821Qi7CLE7Vb7LmjknIzFy5iIMnT4y
         pWZoPmzhrMiZQRyWfOarOMiseUkMAThclGqmQ9BFBL6eaLuLb0+8jUDI39qvVX2vccv2
         QVI4cA4I9vGIdnTZm0FKJYgmIOjsEd1jZRQVY6r9jsTCCqESScbO+oXl5HyHrdGtp4U3
         r/BVzcR7gmws3R8xS3yK4vVFDCWJp6kTkElEvLVPGVk6SxwbXBzHAwo5b7n+Ujpv2z6r
         JrknWta2yCeL4MFcAcGVmm1eo2rwB88MlCxxlvDrsE+c+8ips+nGDzJW6dcbTfw3N5I3
         2X6Q==
X-Gm-Message-State: AOAM530EMHfp7fOIUNCsI/+l3naxTkI+U1rX7MM6Lw8GsEdpIb3oyFoN
        nm47i0Db4BFo1jr5J8I5pWl9VPInMyQ/1ApP6SgFgRD0F7NszA==
X-Google-Smtp-Source: ABdhPJxJJjehBceyDqgFvLgY2ti9qwuK6Ie2sH+wR6/j2O9ql+cyr3rJR0fKBTBdFDOUXqRWZM32iiN39bSHptTQuCs=
X-Received: by 2002:a05:6512:3f2:: with SMTP id n18mr7013628lfq.646.1637072647096;
 Tue, 16 Nov 2021 06:24:07 -0800 (PST)
MIME-Version: 1.0
References: <3ff583e021e3343a3ced54a7b09b5e184d1880dc.1637062727.git.lorenzo@kernel.org>
 <CAFED-j=i9wuN4JuiF4z2q5qbrhrLL_Php7pi6mpniMUeHHFUPA@mail.gmail.com> <YZO81KczA9gqh4bO@lore-desk>
In-Reply-To: <YZO81KczA9gqh4bO@lore-desk>
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Tue, 16 Nov 2021 15:23:56 +0100
Message-ID: <CAFED-jn1Nuyx-CMvQE3ue+thZATf+7VUSEhPA0m1ccpc=S=sEQ@mail.gmail.com>
Subject: Re: [PATCH mac80211-next] cfg80211: schedule offchan_cac_abort_wk in cfg80211_radar_event
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wt., 16 lis 2021 o 15:14 Lorenzo Bianconi
<lorenzo.bianconi@redhat.com> napisa=C5=82(a):
>
> > wt., 16 lis 2021 o 12:46 Lorenzo Bianconi <lorenzo@kernel.org> napisa=
=C5=82(a):
> > >
> > > If necessary schedule offchan_cac_abort_wk work in cfg80211_radar_eve=
nt
> > > routine adding offchan parameter to cfg80211_radar_event signature.
> > > Rename cfg80211_radar_event in __cfg80211_radar_event and introduce
> > > the two following inline helpers:
> > > - cfg80211_radar_event
> > > - cfg80211_offchan_radar_event
> > > Doing so the drv will not need to run cfg80211_offchan_cac_abort() af=
ter
> > > radar detection on the offchannel chain.
> > >
> > > Tested-by: Owen Peng <owen.peng@mediatek.com>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  include/net/cfg80211.h | 24 +++++++++++++++++++++---
> > >  net/wireless/mlme.c    | 16 ++++++++++------
> > >  net/wireless/trace.h   | 11 +++++++----
> > >  3 files changed, 38 insertions(+), 13 deletions(-)
> > >
> >
> > BTW, if we don't have user for this yet, maybe we should change name
> > offchannel -> background.
> > In ETSI spec
> > https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/e=
n_301893v020101p.pdf
> > we have off-channel CAC defined little bit different:
> >
> > "Off-Channel CAC is performed by a number of non-continuous checks
> > spread over a period in time. This period, which is required to
> > determine the presence of radar signals, is defined as the Off-Channel
> > CAC Time."
> >
> > And:
> > "Minimum Off-Channel CAC Time 6 minutes (see note 2) Maximum
> > Off-Channel CAC Time 4 hours (see note 2)"
> >
> > So, your implementation simple run "background CAC" - use one (or
> > more) chain for that.
> >
> > BR
> > Janusz
>
> Hi Janusz,
>
> I have just posted a patch [0] in order to allow continuous radar monitor=
ing
> through the off-channel chain. I guess it is what you are referring to, r=
ight?
>
I mean all patches you send before:

[PATCH v2 mac80211-next 0/6] add offchannel radar chain support

I know this is only name, but ETSI spec define offchannel CAC different.
If there is no user for this yet, then we still could change it, don't
mix it and be aligned with etsi spec.

BR
Janusz

> Regards,
> Lorenzo
>
> [0] "cfg80211: allow continuous radar monitoring on offchannel chain"
> https://lore.kernel.org/linux-wireless/d46217310a49b14ff0e9c002f0a6e0547d=
70fd2c.1637071350.git.lorenzo@kernel.org/T/#u
>
> >
> >
> >
> > > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> > > index 362da9f6bf39..a887086cb103 100644
> > > --- a/include/net/cfg80211.h
> > > +++ b/include/net/cfg80211.h
> > > @@ -7605,15 +7605,33 @@ void cfg80211_cqm_txe_notify(struct net_devic=
e *dev, const u8 *peer,
> > >  void cfg80211_cqm_beacon_loss_notify(struct net_device *dev, gfp_t g=
fp);
> > >
> > >  /**
> > > - * cfg80211_radar_event - radar detection event
> > > + * __cfg80211_radar_event - radar detection event
> > >   * @wiphy: the wiphy
> > >   * @chandef: chandef for the current channel
> > > + * @offchan: the radar has been detected on the offchannel chain
> > >   * @gfp: context flags
> > >   *
> > >   * This function is called when a radar is detected on the current c=
hanenl.
> > >   */
> > > -void cfg80211_radar_event(struct wiphy *wiphy,
> > > -                         struct cfg80211_chan_def *chandef, gfp_t gf=
p);
> > > +void __cfg80211_radar_event(struct wiphy *wiphy,
> > > +                           struct cfg80211_chan_def *chandef,
> > > +                           bool offchan, gfp_t gfp);
> > > +
> > > +static inline void
> > > +cfg80211_radar_event(struct wiphy *wiphy,
> > > +                    struct cfg80211_chan_def *chandef,
> > > +                    gfp_t gfp)
> > > +{
> > > +       __cfg80211_radar_event(wiphy, chandef, false, gfp);
> > > +}
> > > +
> > > +static inline void
> > > +cfg80211_offchan_radar_event(struct wiphy *wiphy,
> > > +                            struct cfg80211_chan_def *chandef,
> > > +                            gfp_t gfp)
> > > +{
> > > +       __cfg80211_radar_event(wiphy, chandef, true, gfp);
> > > +}
> > >
> > >  /**
> > >   * cfg80211_sta_opmode_change_notify - STA's ht/vht operation mode c=
hange event
> > > diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> > > index ac2e5e732d94..450be1ec70b8 100644
> > > --- a/net/wireless/mlme.c
> > > +++ b/net/wireless/mlme.c
> > > @@ -905,13 +905,13 @@ void cfg80211_dfs_channels_update_work(struct w=
ork_struct *work)
> > >  }
> > >
> > >
> > > -void cfg80211_radar_event(struct wiphy *wiphy,
> > > -                         struct cfg80211_chan_def *chandef,
> > > -                         gfp_t gfp)
> > > +void __cfg80211_radar_event(struct wiphy *wiphy,
> > > +                           struct cfg80211_chan_def *chandef,
> > > +                           bool offchan, gfp_t gfp)
> > >  {
> > >         struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wip=
hy);
> > >
> > > -       trace_cfg80211_radar_event(wiphy, chandef);
> > > +       trace_cfg80211_radar_event(wiphy, chandef, offchan);
> > >
> > >         /* only set the chandef supplied channel to unavailable, in
> > >          * case the radar is detected on only one of multiple channel=
s
> > > @@ -919,6 +919,9 @@ void cfg80211_radar_event(struct wiphy *wiphy,
> > >          */
> > >         cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_UNAVAILABL=
E);
> > >
> > > +       if (offchan)
> > > +               queue_work(cfg80211_wq, &rdev->offchan_cac_abort_wk);
> > > +
> > >         cfg80211_sched_dfs_chan_update(rdev);
> > >
> > >         nl80211_radar_notify(rdev, chandef, NL80211_RADAR_DETECTED, N=
ULL, gfp);
> > > @@ -926,7 +929,7 @@ void cfg80211_radar_event(struct wiphy *wiphy,
> > >         memcpy(&rdev->radar_chandef, chandef, sizeof(struct cfg80211_=
chan_def));
> > >         queue_work(cfg80211_wq, &rdev->propagate_radar_detect_wk);
> > >  }
> > > -EXPORT_SYMBOL(cfg80211_radar_event);
> > > +EXPORT_SYMBOL(__cfg80211_radar_event);
> > >
> > >  void cfg80211_cac_event(struct net_device *netdev,
> > >                         const struct cfg80211_chan_def *chandef,
> > > @@ -998,7 +1001,8 @@ __cfg80211_offchan_cac_event(struct cfg80211_reg=
istered_device *rdev,
> > >                 rdev->offchan_radar_wdev =3D NULL;
> > >                 break;
> > >         case NL80211_RADAR_CAC_ABORTED:
> > > -               cancel_delayed_work(&rdev->offchan_cac_done_wk);
> > > +               if (!cancel_delayed_work(&rdev->offchan_cac_done_wk))
> > > +                       return;
> > >                 wdev =3D rdev->offchan_radar_wdev;
> > >                 rdev->offchan_radar_wdev =3D NULL;
> > >                 break;
> > > diff --git a/net/wireless/trace.h b/net/wireless/trace.h
> > > index 0b27eaa14a18..e854d52db1a6 100644
> > > --- a/net/wireless/trace.h
> > > +++ b/net/wireless/trace.h
> > > @@ -3053,18 +3053,21 @@ TRACE_EVENT(cfg80211_ch_switch_started_notify=
,
> > >  );
> > >
> > >  TRACE_EVENT(cfg80211_radar_event,
> > > -       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chand=
ef),
> > > -       TP_ARGS(wiphy, chandef),
> > > +       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chand=
ef,
> > > +                bool offchan),
> > > +       TP_ARGS(wiphy, chandef, offchan),
> > >         TP_STRUCT__entry(
> > >                 WIPHY_ENTRY
> > >                 CHAN_DEF_ENTRY
> > > +               __field(bool, offchan)
> > >         ),
> > >         TP_fast_assign(
> > >                 WIPHY_ASSIGN;
> > >                 CHAN_DEF_ASSIGN(chandef);
> > > +               __entry->offchan =3D offchan;
> > >         ),
> > > -       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
> > > -                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
> > > +       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT ", offchan %d",
> > > +                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG, __entry->offchan)
> > >  );
> > >
> > >  TRACE_EVENT(cfg80211_cac_event,
> > > --
> > > 2.31.1
> > >
> >
> >
> > --
> > Janusz Dziedzic
> >



--=20
Janusz Dziedzic
