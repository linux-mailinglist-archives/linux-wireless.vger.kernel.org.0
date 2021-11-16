Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE664535C8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 16:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhKPPbY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 10:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbhKPPbS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 10:31:18 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F23C061570
        for <linux-wireless@vger.kernel.org>; Tue, 16 Nov 2021 07:28:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id t26so13265374lfk.9
        for <linux-wireless@vger.kernel.org>; Tue, 16 Nov 2021 07:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p+3cLzp4PJiaYo8nUhPg2DP7RBH4ax1cLmNm+lmLT1E=;
        b=CmmdmNPGo7MHW2rU6mvnOZ76MTvgXcOOqcYYqQDJLOXkSiFqoBxIcUDOBGuNbQ/MYA
         yXkllizpsmnn0PskIj/NZHXs2bk5QVFNU84BWDc+Q2pqu0TOmzXKY/crZkMiHapNmX4B
         e8locpxitBrNMShd/GOmZf7sYmB9pJTC8xWZg+CTC7ahjo/nSJSTRrxoffDKk85d0ot1
         njwCDetBdcTH2HFF2+zgjiT1H/eq0k/IljrqDde0chrJpLYCrRI2TG14wVs500yK1kfv
         dJCeN2OadQZwEHfYPlqYL5Yfg5K1x30tRkWLjDMgYVLX+2B1yK5VxkGl67dtZF1n/KcF
         piUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p+3cLzp4PJiaYo8nUhPg2DP7RBH4ax1cLmNm+lmLT1E=;
        b=tUhltZBNRCrqrcbhpCoQOucQj4nLcVSBhWX4/u/BMlJJAed///D9VGRJ1+TGAonrAs
         QNLZc5NbhylLOZdffM0I1STqxOge9ooK/qN9DWx1loTRsDhFmmQ6dXm32rap0vimPCPJ
         e+fgYq7+wBHif5Ot0IUppzb3Lc9OajUoxn5VvwiYlbvrvkfe6TYcVLx20GxPtouJOwjs
         eQG9iuxS5x7hksjanj90fmPerjQv/dKmon8RH7MmUZqn552iuEdezZC035mZJcHZXruk
         RFJxoX4DnorG6EGzk6izJrlS1oP0pNJZf01gXNrKmseSkaVhcLCPSVUxQq4P0r9tBfzh
         1Q2A==
X-Gm-Message-State: AOAM5321tv+00fF7+TbPufg11arMYQDpgKwnoqEEJZfczZMQ+HX1R4vn
        6cbwHQPZ/Nhou8Ex9JHpRiMcA/T+vRVo0tqJm/I=
X-Google-Smtp-Source: ABdhPJwrH5DottvX41jWoBmlldBZVPquG/UUsyqmy2FglmeWJQ1Jil7Qq9ALNh5g/E3IYeiYZnVbDzQkBdCYHyDhMXU=
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr7144466lfb.189.1637076499867;
 Tue, 16 Nov 2021 07:28:19 -0800 (PST)
MIME-Version: 1.0
References: <3ff583e021e3343a3ced54a7b09b5e184d1880dc.1637062727.git.lorenzo@kernel.org>
 <CAFED-j=i9wuN4JuiF4z2q5qbrhrLL_Php7pi6mpniMUeHHFUPA@mail.gmail.com>
 <YZO81KczA9gqh4bO@lore-desk> <CAFED-jn1Nuyx-CMvQE3ue+thZATf+7VUSEhPA0m1ccpc=S=sEQ@mail.gmail.com>
 <YZPBP1SK7IqI2iyC@lore-desk>
In-Reply-To: <YZPBP1SK7IqI2iyC@lore-desk>
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Tue, 16 Nov 2021 16:28:08 +0100
Message-ID: <CAFED-j=AN7h1nAoaNkZtZBWZQ267WbcJz=YrXcROjA6zfchtMQ@mail.gmail.com>
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

wt., 16 lis 2021 o 15:33 Lorenzo Bianconi
<lorenzo.bianconi@redhat.com> napisa=C5=82(a):
>
> On Nov 16, Janusz Dziedzic wrote:
> > wt., 16 lis 2021 o 15:14 Lorenzo Bianconi
> > <lorenzo.bianconi@redhat.com> napisa=C5=82(a):
> > >
> > > > wt., 16 lis 2021 o 12:46 Lorenzo Bianconi <lorenzo@kernel.org> napi=
sa=C5=82(a):
> > > > >
> > > > > If necessary schedule offchan_cac_abort_wk work in cfg80211_radar=
_event
> > > > > routine adding offchan parameter to cfg80211_radar_event signatur=
e.
> > > > > Rename cfg80211_radar_event in __cfg80211_radar_event and introdu=
ce
> > > > > the two following inline helpers:
> > > > > - cfg80211_radar_event
> > > > > - cfg80211_offchan_radar_event
> > > > > Doing so the drv will not need to run cfg80211_offchan_cac_abort(=
) after
> > > > > radar detection on the offchannel chain.
> > > > >
> > > > > Tested-by: Owen Peng <owen.peng@mediatek.com>
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > ---
> > > > >  include/net/cfg80211.h | 24 +++++++++++++++++++++---
> > > > >  net/wireless/mlme.c    | 16 ++++++++++------
> > > > >  net/wireless/trace.h   | 11 +++++++----
> > > > >  3 files changed, 38 insertions(+), 13 deletions(-)
> > > > >
> > > >
> > > > BTW, if we don't have user for this yet, maybe we should change nam=
e
> > > > offchannel -> background.
> > > > In ETSI spec
> > > > https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_=
60/en_301893v020101p.pdf
> > > > we have off-channel CAC defined little bit different:
> > > >
> > > > "Off-Channel CAC is performed by a number of non-continuous checks
> > > > spread over a period in time. This period, which is required to
> > > > determine the presence of radar signals, is defined as the Off-Chan=
nel
> > > > CAC Time."
> > > >
> > > > And:
> > > > "Minimum Off-Channel CAC Time 6 minutes (see note 2) Maximum
> > > > Off-Channel CAC Time 4 hours (see note 2)"
> > > >
> > > > So, your implementation simple run "background CAC" - use one (or
> > > > more) chain for that.
> > > >
> > > > BR
> > > > Janusz
> > >
> > > Hi Janusz,
> > >
> > > I have just posted a patch [0] in order to allow continuous radar mon=
itoring
> > > through the off-channel chain. I guess it is what you are referring t=
o, right?
> > >
> > I mean all patches you send before:
> >
> > [PATCH v2 mac80211-next 0/6] add offchannel radar chain support
> >
> > I know this is only name, but ETSI spec define offchannel CAC different=
.
> > If there is no user for this yet, then we still could change it, don't
> > mix it and be aligned with etsi spec.
>
> ok, please take a look to the patch I linked since AFAIK applying that pa=
tch
> we are supposed to be aligned to the ETSI spec (and so no need to change
> the name).

So, we will cover ETSI spec also? I suspect in such case we only need:
 - device with remain_on_channel
 - device can detect radars
And don't need to have any extra HW support for that and could be
implemented fully in mac80211.

So, ETSI pure offchannel CAC could implemented in mac80211 while
"background CAC" need extra driver/hw support.
Because of that I think about different name/API for that.
Will you introduce some HW flag for that?
I see today we have NL80211_EXT_FEATURE_RADAR_OFFCHAN - but have two cases =
...

I see cfg80211_start_offchan_radar_detection() set timeout - today
this will be 60s or 600s(weather channels).
For sure this is wrong for ETSI offchannel CAC (6minutes - 4 hours).
But probably you will fix that?

Anyway thanks for working on that :)
Will that work with mt7915e?

BR
Janusz

>
> Regards,
> Lorenzo
> >
> > BR
> > Janusz
> >
> > > Regards,
> > > Lorenzo
> > >
> > > [0] "cfg80211: allow continuous radar monitoring on offchannel chain"
> > > https://lore.kernel.org/linux-wireless/d46217310a49b14ff0e9c002f0a6e0=
547d70fd2c.1637071350.git.lorenzo@kernel.org/T/#u
> > >
> > > >
> > > >
> > > >
> > > > > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> > > > > index 362da9f6bf39..a887086cb103 100644
> > > > > --- a/include/net/cfg80211.h
> > > > > +++ b/include/net/cfg80211.h
> > > > > @@ -7605,15 +7605,33 @@ void cfg80211_cqm_txe_notify(struct net_d=
evice *dev, const u8 *peer,
> > > > >  void cfg80211_cqm_beacon_loss_notify(struct net_device *dev, gfp=
_t gfp);
> > > > >
> > > > >  /**
> > > > > - * cfg80211_radar_event - radar detection event
> > > > > + * __cfg80211_radar_event - radar detection event
> > > > >   * @wiphy: the wiphy
> > > > >   * @chandef: chandef for the current channel
> > > > > + * @offchan: the radar has been detected on the offchannel chain
> > > > >   * @gfp: context flags
> > > > >   *
> > > > >   * This function is called when a radar is detected on the curre=
nt chanenl.
> > > > >   */
> > > > > -void cfg80211_radar_event(struct wiphy *wiphy,
> > > > > -                         struct cfg80211_chan_def *chandef, gfp_=
t gfp);
> > > > > +void __cfg80211_radar_event(struct wiphy *wiphy,
> > > > > +                           struct cfg80211_chan_def *chandef,
> > > > > +                           bool offchan, gfp_t gfp);
> > > > > +
> > > > > +static inline void
> > > > > +cfg80211_radar_event(struct wiphy *wiphy,
> > > > > +                    struct cfg80211_chan_def *chandef,
> > > > > +                    gfp_t gfp)
> > > > > +{
> > > > > +       __cfg80211_radar_event(wiphy, chandef, false, gfp);
> > > > > +}
> > > > > +
> > > > > +static inline void
> > > > > +cfg80211_offchan_radar_event(struct wiphy *wiphy,
> > > > > +                            struct cfg80211_chan_def *chandef,
> > > > > +                            gfp_t gfp)
> > > > > +{
> > > > > +       __cfg80211_radar_event(wiphy, chandef, true, gfp);
> > > > > +}
> > > > >
> > > > >  /**
> > > > >   * cfg80211_sta_opmode_change_notify - STA's ht/vht operation mo=
de change event
> > > > > diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> > > > > index ac2e5e732d94..450be1ec70b8 100644
> > > > > --- a/net/wireless/mlme.c
> > > > > +++ b/net/wireless/mlme.c
> > > > > @@ -905,13 +905,13 @@ void cfg80211_dfs_channels_update_work(stru=
ct work_struct *work)
> > > > >  }
> > > > >
> > > > >
> > > > > -void cfg80211_radar_event(struct wiphy *wiphy,
> > > > > -                         struct cfg80211_chan_def *chandef,
> > > > > -                         gfp_t gfp)
> > > > > +void __cfg80211_radar_event(struct wiphy *wiphy,
> > > > > +                           struct cfg80211_chan_def *chandef,
> > > > > +                           bool offchan, gfp_t gfp)
> > > > >  {
> > > > >         struct cfg80211_registered_device *rdev =3D wiphy_to_rdev=
(wiphy);
> > > > >
> > > > > -       trace_cfg80211_radar_event(wiphy, chandef);
> > > > > +       trace_cfg80211_radar_event(wiphy, chandef, offchan);
> > > > >
> > > > >         /* only set the chandef supplied channel to unavailable, =
in
> > > > >          * case the radar is detected on only one of multiple cha=
nnels
> > > > > @@ -919,6 +919,9 @@ void cfg80211_radar_event(struct wiphy *wiphy=
,
> > > > >          */
> > > > >         cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_UNAVAI=
LABLE);
> > > > >
> > > > > +       if (offchan)
> > > > > +               queue_work(cfg80211_wq, &rdev->offchan_cac_abort_=
wk);
> > > > > +
> > > > >         cfg80211_sched_dfs_chan_update(rdev);
> > > > >
> > > > >         nl80211_radar_notify(rdev, chandef, NL80211_RADAR_DETECTE=
D, NULL, gfp);
> > > > > @@ -926,7 +929,7 @@ void cfg80211_radar_event(struct wiphy *wiphy=
,
> > > > >         memcpy(&rdev->radar_chandef, chandef, sizeof(struct cfg80=
211_chan_def));
> > > > >         queue_work(cfg80211_wq, &rdev->propagate_radar_detect_wk)=
;
> > > > >  }
> > > > > -EXPORT_SYMBOL(cfg80211_radar_event);
> > > > > +EXPORT_SYMBOL(__cfg80211_radar_event);
> > > > >
> > > > >  void cfg80211_cac_event(struct net_device *netdev,
> > > > >                         const struct cfg80211_chan_def *chandef,
> > > > > @@ -998,7 +1001,8 @@ __cfg80211_offchan_cac_event(struct cfg80211=
_registered_device *rdev,
> > > > >                 rdev->offchan_radar_wdev =3D NULL;
> > > > >                 break;
> > > > >         case NL80211_RADAR_CAC_ABORTED:
> > > > > -               cancel_delayed_work(&rdev->offchan_cac_done_wk);
> > > > > +               if (!cancel_delayed_work(&rdev->offchan_cac_done_=
wk))
> > > > > +                       return;
> > > > >                 wdev =3D rdev->offchan_radar_wdev;
> > > > >                 rdev->offchan_radar_wdev =3D NULL;
> > > > >                 break;
> > > > > diff --git a/net/wireless/trace.h b/net/wireless/trace.h
> > > > > index 0b27eaa14a18..e854d52db1a6 100644
> > > > > --- a/net/wireless/trace.h
> > > > > +++ b/net/wireless/trace.h
> > > > > @@ -3053,18 +3053,21 @@ TRACE_EVENT(cfg80211_ch_switch_started_no=
tify,
> > > > >  );
> > > > >
> > > > >  TRACE_EVENT(cfg80211_radar_event,
> > > > > -       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *c=
handef),
> > > > > -       TP_ARGS(wiphy, chandef),
> > > > > +       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *c=
handef,
> > > > > +                bool offchan),
> > > > > +       TP_ARGS(wiphy, chandef, offchan),
> > > > >         TP_STRUCT__entry(
> > > > >                 WIPHY_ENTRY
> > > > >                 CHAN_DEF_ENTRY
> > > > > +               __field(bool, offchan)
> > > > >         ),
> > > > >         TP_fast_assign(
> > > > >                 WIPHY_ASSIGN;
> > > > >                 CHAN_DEF_ASSIGN(chandef);
> > > > > +               __entry->offchan =3D offchan;
> > > > >         ),
> > > > > -       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
> > > > > -                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
> > > > > +       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT ", offchan %d=
",
> > > > > +                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG, __entry->offchan=
)
> > > > >  );
> > > > >
> > > > >  TRACE_EVENT(cfg80211_cac_event,
> > > > > --
> > > > > 2.31.1
> > > > >
> > > >
> > > >
> > > > --
> > > > Janusz Dziedzic
> > > >
> >
> >
> >
> > --
> > Janusz Dziedzic
> >



--=20
Janusz Dziedzic
