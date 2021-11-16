Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8CE4536B7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 17:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbhKPQGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 11:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238778AbhKPQG1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 11:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637078608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9SFuvvYl4aliT4V1WuEiSi8HM83eBVVxmQCaer9POwI=;
        b=MjCxjMPXzbrekMsG4Slxx/5LmK4lZmCtnWEQvJL4ss3IsHsnQkYioFbe76F8cNR6OnzehL
        tfuIQnd4Eg/RS6U5LOA1+FE9FyIOC0bfdhLagkEYAu0vaW2As3fZmOhu7BAeFQYyk56VdQ
        lTkBjRaWlixvGPJQ9rw088TM5FrFvQs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-YDWKq3CkPIa5MS33Il1QBg-1; Tue, 16 Nov 2021 11:03:25 -0500
X-MC-Unique: YDWKq3CkPIa5MS33Il1QBg-1
Received: by mail-ed1-f71.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso17552547edj.20
        for <linux-wireless@vger.kernel.org>; Tue, 16 Nov 2021 08:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9SFuvvYl4aliT4V1WuEiSi8HM83eBVVxmQCaer9POwI=;
        b=OUfEw17D8lfGx6Lt2C6fC5XXpGnY9/1kiGg7i55Tt9ZzOzxH8Z/URPOFWKnRhttSno
         XUWIEPytRt1iWQYapbb3jQh0ANmwxBhQXcfQxHr+ByfLkzn4ARtUSLqa74nh5yJ4Y492
         eqetC3GtdOcaEfQFiZAxvLxk5SErrLjUQB1zojhnS9NBE2yJCMQvILmg8Cm4lWvkxWeE
         JIz+13MlC07W5sDa93eex4KWldkA85O0XbzgYt1WpKBTg/DEA1dVZBFi26ZywbH5vvhz
         /4FPPdN7kuNCRw+Qx0kfWc4Vn1hweYa2B/8o6HseX+lDU2Bfxdl241FGZxszsbdyILqb
         OBvQ==
X-Gm-Message-State: AOAM533vlPABjZ5VV+f6TC9/92QLqnSArs2HGuKXx4vH3m5wdWQKJM05
        WFDecvhgwVjyVuWH/Xe2aCXqnWKecWXsnakv9m2vw0TdXJgBqn5TBUvYOnsm5x3wfFzJN8xP3i5
        GFJXMb3mTLKfoqwIJQqHsf9ocFIk=
X-Received: by 2002:a50:d74e:: with SMTP id i14mr11215775edj.243.1637078604561;
        Tue, 16 Nov 2021 08:03:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvxSl/vMqQsdTqFvh5x79w3XGI/EZHSGtJ0hMZKHm5i+lWubKGvLOZzTDKATSn+7axZXgKhw==
X-Received: by 2002:a50:d74e:: with SMTP id i14mr11215710edj.243.1637078604129;
        Tue, 16 Nov 2021 08:03:24 -0800 (PST)
Received: from localhost (net-93-151-197-210.cust.dsl.teletu.it. [93.151.197.210])
        by smtp.gmail.com with ESMTPSA id i10sm8911519ejw.48.2021.11.16.08.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 08:03:23 -0800 (PST)
Date:   Tue, 16 Nov 2021 17:03:21 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com
Subject: Re: [PATCH mac80211-next] cfg80211: schedule offchan_cac_abort_wk in
 cfg80211_radar_event
Message-ID: <YZPWSdIAlW1D9SVR@lore-desk>
References: <3ff583e021e3343a3ced54a7b09b5e184d1880dc.1637062727.git.lorenzo@kernel.org>
 <CAFED-j=i9wuN4JuiF4z2q5qbrhrLL_Php7pi6mpniMUeHHFUPA@mail.gmail.com>
 <YZO81KczA9gqh4bO@lore-desk>
 <CAFED-jn1Nuyx-CMvQE3ue+thZATf+7VUSEhPA0m1ccpc=S=sEQ@mail.gmail.com>
 <YZPBP1SK7IqI2iyC@lore-desk>
 <CAFED-j=AN7h1nAoaNkZtZBWZQ267WbcJz=YrXcROjA6zfchtMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwXsYVNpO/yfxNn0"
Content-Disposition: inline
In-Reply-To: <CAFED-j=AN7h1nAoaNkZtZBWZQ267WbcJz=YrXcROjA6zfchtMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--rwXsYVNpO/yfxNn0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> wt., 16 lis 2021 o 15:33 Lorenzo Bianconi
> <lorenzo.bianconi@redhat.com> napisa=C5=82(a):
> >
> > On Nov 16, Janusz Dziedzic wrote:
> > > wt., 16 lis 2021 o 15:14 Lorenzo Bianconi
> > > <lorenzo.bianconi@redhat.com> napisa=C5=82(a):
> > > >
> > > > > wt., 16 lis 2021 o 12:46 Lorenzo Bianconi <lorenzo@kernel.org> na=
pisa=C5=82(a):
> > > > > >
> > > > > > If necessary schedule offchan_cac_abort_wk work in cfg80211_rad=
ar_event
> > > > > > routine adding offchan parameter to cfg80211_radar_event signat=
ure.
> > > > > > Rename cfg80211_radar_event in __cfg80211_radar_event and intro=
duce
> > > > > > the two following inline helpers:
> > > > > > - cfg80211_radar_event
> > > > > > - cfg80211_offchan_radar_event
> > > > > > Doing so the drv will not need to run cfg80211_offchan_cac_abor=
t() after
> > > > > > radar detection on the offchannel chain.
> > > > > >
> > > > > > Tested-by: Owen Peng <owen.peng@mediatek.com>
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > ---
> > > > > >  include/net/cfg80211.h | 24 +++++++++++++++++++++---
> > > > > >  net/wireless/mlme.c    | 16 ++++++++++------
> > > > > >  net/wireless/trace.h   | 11 +++++++----
> > > > > >  3 files changed, 38 insertions(+), 13 deletions(-)
> > > > > >
> > > > >
> > > > > BTW, if we don't have user for this yet, maybe we should change n=
ame
> > > > > offchannel -> background.
> > > > > In ETSI spec
> > > > > https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.0=
1_60/en_301893v020101p.pdf
> > > > > we have off-channel CAC defined little bit different:
> > > > >
> > > > > "Off-Channel CAC is performed by a number of non-continuous checks
> > > > > spread over a period in time. This period, which is required to
> > > > > determine the presence of radar signals, is defined as the Off-Ch=
annel
> > > > > CAC Time."
> > > > >
> > > > > And:
> > > > > "Minimum Off-Channel CAC Time 6 minutes (see note 2) Maximum
> > > > > Off-Channel CAC Time 4 hours (see note 2)"
> > > > >
> > > > > So, your implementation simple run "background CAC" - use one (or
> > > > > more) chain for that.
> > > > >
> > > > > BR
> > > > > Janusz
> > > >
> > > > Hi Janusz,
> > > >
> > > > I have just posted a patch [0] in order to allow continuous radar m=
onitoring
> > > > through the off-channel chain. I guess it is what you are referring=
 to, right?
> > > >
> > > I mean all patches you send before:
> > >
> > > [PATCH v2 mac80211-next 0/6] add offchannel radar chain support
> > >
> > > I know this is only name, but ETSI spec define offchannel CAC differe=
nt.
> > > If there is no user for this yet, then we still could change it, don't
> > > mix it and be aligned with etsi spec.
> >
> > ok, please take a look to the patch I linked since AFAIK applying that =
patch
> > we are supposed to be aligned to the ETSI spec (and so no need to change
> > the name).
>=20
> So, we will cover ETSI spec also? I suspect in such case we only need:
>  - device with remain_on_channel
>  - device can detect radars

not sure how much it is feasible w/o a dedicated radar chain but I am not
a hw expert :)

> And don't need to have any extra HW support for that and could be
> implemented fully in mac80211.
>=20
> So, ETSI pure offchannel CAC could implemented in mac80211 while
> "background CAC" need extra driver/hw support.
> Because of that I think about different name/API for that.
> Will you introduce some HW flag for that?
> I see today we have NL80211_EXT_FEATURE_RADAR_OFFCHAN - but have two case=
s ...
>=20
> I see cfg80211_start_offchan_radar_detection() set timeout - today
> this will be 60s or 600s(weather channels).
> For sure this is wrong for ETSI offchannel CAC (6minutes - 4 hours).
> But probably you will fix that?
>=20
> Anyway thanks for working on that :)
> Will that work with mt7915e?

I can see what you mean now. Yes, mt7915 has a dedicated hw chain used only=
 for
radar detection (as it is described in the API, it can't be used for tx or =
rx
packets). AFAIK, since we are continuously monitoring the second channel, w=
e do
not need to wait for 6min, just the regular CAC and then we can use the
channel if needed (e.g. if we detect a radar pattern on the main channel).
If we detect a radar pattern on the secondary channel we will mark it as
"unavailable" and move the off-channel chain to monitor another channel.
In other words, this is something like a hw-offchannel with respect to what=
 is
described in ETSI spec.
Maybe we can call sw-offchan the pure sw implementation whenever it will be
implemented in mac80211/cfg80211 but I am fine to rename it.

@Johannes: what do you prefer?

Regards,
Lorenzo

If you want to take a look, mt7915 patches are here:
https://github.com/LorenzoBianconi/wireless-drivers-next/tree/mt7915-zw-dfs
hostapd code is here:
https://github.com/LorenzoBianconi/hostapd/tree/zw-dfs-for-mtk

>=20
> BR
> Janusz
>=20
> >
> > Regards,
> > Lorenzo
> > >
> > > BR
> > > Janusz
> > >
> > > > Regards,
> > > > Lorenzo
> > > >
> > > > [0] "cfg80211: allow continuous radar monitoring on offchannel chai=
n"
> > > > https://lore.kernel.org/linux-wireless/d46217310a49b14ff0e9c002f0a6=
e0547d70fd2c.1637071350.git.lorenzo@kernel.org/T/#u
> > > >
> > > > >
> > > > >
> > > > >
> > > > > > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> > > > > > index 362da9f6bf39..a887086cb103 100644
> > > > > > --- a/include/net/cfg80211.h
> > > > > > +++ b/include/net/cfg80211.h
> > > > > > @@ -7605,15 +7605,33 @@ void cfg80211_cqm_txe_notify(struct net=
_device *dev, const u8 *peer,
> > > > > >  void cfg80211_cqm_beacon_loss_notify(struct net_device *dev, g=
fp_t gfp);
> > > > > >
> > > > > >  /**
> > > > > > - * cfg80211_radar_event - radar detection event
> > > > > > + * __cfg80211_radar_event - radar detection event
> > > > > >   * @wiphy: the wiphy
> > > > > >   * @chandef: chandef for the current channel
> > > > > > + * @offchan: the radar has been detected on the offchannel cha=
in
> > > > > >   * @gfp: context flags
> > > > > >   *
> > > > > >   * This function is called when a radar is detected on the cur=
rent chanenl.
> > > > > >   */
> > > > > > -void cfg80211_radar_event(struct wiphy *wiphy,
> > > > > > -                         struct cfg80211_chan_def *chandef, gf=
p_t gfp);
> > > > > > +void __cfg80211_radar_event(struct wiphy *wiphy,
> > > > > > +                           struct cfg80211_chan_def *chandef,
> > > > > > +                           bool offchan, gfp_t gfp);
> > > > > > +
> > > > > > +static inline void
> > > > > > +cfg80211_radar_event(struct wiphy *wiphy,
> > > > > > +                    struct cfg80211_chan_def *chandef,
> > > > > > +                    gfp_t gfp)
> > > > > > +{
> > > > > > +       __cfg80211_radar_event(wiphy, chandef, false, gfp);
> > > > > > +}
> > > > > > +
> > > > > > +static inline void
> > > > > > +cfg80211_offchan_radar_event(struct wiphy *wiphy,
> > > > > > +                            struct cfg80211_chan_def *chandef,
> > > > > > +                            gfp_t gfp)
> > > > > > +{
> > > > > > +       __cfg80211_radar_event(wiphy, chandef, true, gfp);
> > > > > > +}
> > > > > >
> > > > > >  /**
> > > > > >   * cfg80211_sta_opmode_change_notify - STA's ht/vht operation =
mode change event
> > > > > > diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> > > > > > index ac2e5e732d94..450be1ec70b8 100644
> > > > > > --- a/net/wireless/mlme.c
> > > > > > +++ b/net/wireless/mlme.c
> > > > > > @@ -905,13 +905,13 @@ void cfg80211_dfs_channels_update_work(st=
ruct work_struct *work)
> > > > > >  }
> > > > > >
> > > > > >
> > > > > > -void cfg80211_radar_event(struct wiphy *wiphy,
> > > > > > -                         struct cfg80211_chan_def *chandef,
> > > > > > -                         gfp_t gfp)
> > > > > > +void __cfg80211_radar_event(struct wiphy *wiphy,
> > > > > > +                           struct cfg80211_chan_def *chandef,
> > > > > > +                           bool offchan, gfp_t gfp)
> > > > > >  {
> > > > > >         struct cfg80211_registered_device *rdev =3D wiphy_to_rd=
ev(wiphy);
> > > > > >
> > > > > > -       trace_cfg80211_radar_event(wiphy, chandef);
> > > > > > +       trace_cfg80211_radar_event(wiphy, chandef, offchan);
> > > > > >
> > > > > >         /* only set the chandef supplied channel to unavailable=
, in
> > > > > >          * case the radar is detected on only one of multiple c=
hannels
> > > > > > @@ -919,6 +919,9 @@ void cfg80211_radar_event(struct wiphy *wip=
hy,
> > > > > >          */
> > > > > >         cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_UNAV=
AILABLE);
> > > > > >
> > > > > > +       if (offchan)
> > > > > > +               queue_work(cfg80211_wq, &rdev->offchan_cac_abor=
t_wk);
> > > > > > +
> > > > > >         cfg80211_sched_dfs_chan_update(rdev);
> > > > > >
> > > > > >         nl80211_radar_notify(rdev, chandef, NL80211_RADAR_DETEC=
TED, NULL, gfp);
> > > > > > @@ -926,7 +929,7 @@ void cfg80211_radar_event(struct wiphy *wip=
hy,
> > > > > >         memcpy(&rdev->radar_chandef, chandef, sizeof(struct cfg=
80211_chan_def));
> > > > > >         queue_work(cfg80211_wq, &rdev->propagate_radar_detect_w=
k);
> > > > > >  }
> > > > > > -EXPORT_SYMBOL(cfg80211_radar_event);
> > > > > > +EXPORT_SYMBOL(__cfg80211_radar_event);
> > > > > >
> > > > > >  void cfg80211_cac_event(struct net_device *netdev,
> > > > > >                         const struct cfg80211_chan_def *chandef,
> > > > > > @@ -998,7 +1001,8 @@ __cfg80211_offchan_cac_event(struct cfg802=
11_registered_device *rdev,
> > > > > >                 rdev->offchan_radar_wdev =3D NULL;
> > > > > >                 break;
> > > > > >         case NL80211_RADAR_CAC_ABORTED:
> > > > > > -               cancel_delayed_work(&rdev->offchan_cac_done_wk);
> > > > > > +               if (!cancel_delayed_work(&rdev->offchan_cac_don=
e_wk))
> > > > > > +                       return;
> > > > > >                 wdev =3D rdev->offchan_radar_wdev;
> > > > > >                 rdev->offchan_radar_wdev =3D NULL;
> > > > > >                 break;
> > > > > > diff --git a/net/wireless/trace.h b/net/wireless/trace.h
> > > > > > index 0b27eaa14a18..e854d52db1a6 100644
> > > > > > --- a/net/wireless/trace.h
> > > > > > +++ b/net/wireless/trace.h
> > > > > > @@ -3053,18 +3053,21 @@ TRACE_EVENT(cfg80211_ch_switch_started_=
notify,
> > > > > >  );
> > > > > >
> > > > > >  TRACE_EVENT(cfg80211_radar_event,
> > > > > > -       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def =
*chandef),
> > > > > > -       TP_ARGS(wiphy, chandef),
> > > > > > +       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def =
*chandef,
> > > > > > +                bool offchan),
> > > > > > +       TP_ARGS(wiphy, chandef, offchan),
> > > > > >         TP_STRUCT__entry(
> > > > > >                 WIPHY_ENTRY
> > > > > >                 CHAN_DEF_ENTRY
> > > > > > +               __field(bool, offchan)
> > > > > >         ),
> > > > > >         TP_fast_assign(
> > > > > >                 WIPHY_ASSIGN;
> > > > > >                 CHAN_DEF_ASSIGN(chandef);
> > > > > > +               __entry->offchan =3D offchan;
> > > > > >         ),
> > > > > > -       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
> > > > > > -                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
> > > > > > +       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT ", offchan =
%d",
> > > > > > +                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG, __entry->offch=
an)
> > > > > >  );
> > > > > >
> > > > > >  TRACE_EVENT(cfg80211_cac_event,
> > > > > > --
> > > > > > 2.31.1
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Janusz Dziedzic
> > > > >
> > >
> > >
> > >
> > > --
> > > Janusz Dziedzic
> > >
>=20
>=20
>=20
> --=20
> Janusz Dziedzic
>=20

--rwXsYVNpO/yfxNn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZPWSQAKCRA6cBh0uS2t
rAt2AQDeJEOFfGabFGYmWccZ5dmFoh4h9yQhyTCjQfrE5NYe+wEA5aRh0N6J8JD0
eIc8dwD9GOvXWxfpnLw4/936snhhjQI=
=7xQe
-----END PGP SIGNATURE-----

--rwXsYVNpO/yfxNn0--

