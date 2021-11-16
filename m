Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2F0453443
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 15:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbhKPOg4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 09:36:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237433AbhKPOgl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 09:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637073223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1qjU1RB7ItdQwJgMhIxrjYOUnY5oRUufG094xoT+pgc=;
        b=WL6Zl5AqGFIqDc95rMzLWgdspGMgz/kErDMsnm5zqUSiWcn9HpzVbsvO03ByRkesd0ci8y
        9m3SsbEUVRPzKu2OxHd0T0Tr3iDObE88PA30Iqa2nlsbU5rFT/40v/DJWqE+ADcJibjb6b
        2JFvVmzdkIg4ku1f8q7P3oIsXZS3ePs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-20bLcR6EPfqFjGujhWbrGQ-1; Tue, 16 Nov 2021 09:33:39 -0500
X-MC-Unique: 20bLcR6EPfqFjGujhWbrGQ-1
Received: by mail-ed1-f71.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so4101502edq.8
        for <linux-wireless@vger.kernel.org>; Tue, 16 Nov 2021 06:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1qjU1RB7ItdQwJgMhIxrjYOUnY5oRUufG094xoT+pgc=;
        b=syoC+zez2gLFvk9juo/TzbdcP+grjNTvgLrfxbqAoljJdAFjp1nWNV0mdvFk8GDcKg
         jzc4JwLb7fL9ubjUkt+G1FjRMghdq54Mx0MqrnH0A7fNfzwAdenblC3ZMKU/JyXhygKY
         z0MvkTdP0W40OgrwRZMqfihYqYusSB0q2fKgNkZRI5RKUl1SwgaEGjyZv+bj12tD8G/9
         SJCu3gxIF7zVwyn7slnOlmhvzSczpKQ/8vTprkzyrLM1Ich0Gpciqri+/hjkcdE/j+lj
         pmq6GA5mxydEFiZvmVFp4xJMoxBRSlamVUlMUMARRU56bbzG2MPEMYCYB5nFdXrIm9xY
         yS6Q==
X-Gm-Message-State: AOAM533hipcSLw89dyT06wU6x6bPbjHAL3gBhutAwJM/AR7Vh5+qb00w
        tkVglwrHqGTPVdRXb1HaKmDLQ6qGhrhWPJhKBpF7prAK90NsJlm5r52C9VaY+2QGe+JgJwl3GWF
        cEUQUxYwh9mei0/nQ6EX9PG0VD0A=
X-Received: by 2002:a17:906:388c:: with SMTP id q12mr10527091ejd.281.1637073218438;
        Tue, 16 Nov 2021 06:33:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxD/c3VlEbUWRTr4adYHB18VP+4jicl7syhi8AI5VCKA1+qjgV4TcYkZVrtTcb+/J9fW3qSoA==
X-Received: by 2002:a17:906:388c:: with SMTP id q12mr10527037ejd.281.1637073218152;
        Tue, 16 Nov 2021 06:33:38 -0800 (PST)
Received: from localhost (net-93-151-197-210.cust.vodafonedsl.it. [93.151.197.210])
        by smtp.gmail.com with ESMTPSA id em21sm8202331ejc.103.2021.11.16.06.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 06:33:37 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:33:35 +0100
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
Message-ID: <YZPBP1SK7IqI2iyC@lore-desk>
References: <3ff583e021e3343a3ced54a7b09b5e184d1880dc.1637062727.git.lorenzo@kernel.org>
 <CAFED-j=i9wuN4JuiF4z2q5qbrhrLL_Php7pi6mpniMUeHHFUPA@mail.gmail.com>
 <YZO81KczA9gqh4bO@lore-desk>
 <CAFED-jn1Nuyx-CMvQE3ue+thZATf+7VUSEhPA0m1ccpc=S=sEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z0mlzYjdWslreG7R"
Content-Disposition: inline
In-Reply-To: <CAFED-jn1Nuyx-CMvQE3ue+thZATf+7VUSEhPA0m1ccpc=S=sEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Z0mlzYjdWslreG7R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 16, Janusz Dziedzic wrote:
> wt., 16 lis 2021 o 15:14 Lorenzo Bianconi
> <lorenzo.bianconi@redhat.com> napisa=C5=82(a):
> >
> > > wt., 16 lis 2021 o 12:46 Lorenzo Bianconi <lorenzo@kernel.org> napisa=
=C5=82(a):
> > > >
> > > > If necessary schedule offchan_cac_abort_wk work in cfg80211_radar_e=
vent
> > > > routine adding offchan parameter to cfg80211_radar_event signature.
> > > > Rename cfg80211_radar_event in __cfg80211_radar_event and introduce
> > > > the two following inline helpers:
> > > > - cfg80211_radar_event
> > > > - cfg80211_offchan_radar_event
> > > > Doing so the drv will not need to run cfg80211_offchan_cac_abort() =
after
> > > > radar detection on the offchannel chain.
> > > >
> > > > Tested-by: Owen Peng <owen.peng@mediatek.com>
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  include/net/cfg80211.h | 24 +++++++++++++++++++++---
> > > >  net/wireless/mlme.c    | 16 ++++++++++------
> > > >  net/wireless/trace.h   | 11 +++++++----
> > > >  3 files changed, 38 insertions(+), 13 deletions(-)
> > > >
> > >
> > > BTW, if we don't have user for this yet, maybe we should change name
> > > offchannel -> background.
> > > In ETSI spec
> > > https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60=
/en_301893v020101p.pdf
> > > we have off-channel CAC defined little bit different:
> > >
> > > "Off-Channel CAC is performed by a number of non-continuous checks
> > > spread over a period in time. This period, which is required to
> > > determine the presence of radar signals, is defined as the Off-Channel
> > > CAC Time."
> > >
> > > And:
> > > "Minimum Off-Channel CAC Time 6 minutes (see note 2) Maximum
> > > Off-Channel CAC Time 4 hours (see note 2)"
> > >
> > > So, your implementation simple run "background CAC" - use one (or
> > > more) chain for that.
> > >
> > > BR
> > > Janusz
> >
> > Hi Janusz,
> >
> > I have just posted a patch [0] in order to allow continuous radar monit=
oring
> > through the off-channel chain. I guess it is what you are referring to,=
 right?
> >
> I mean all patches you send before:
>=20
> [PATCH v2 mac80211-next 0/6] add offchannel radar chain support
>=20
> I know this is only name, but ETSI spec define offchannel CAC different.
> If there is no user for this yet, then we still could change it, don't
> mix it and be aligned with etsi spec.

ok, please take a look to the patch I linked since AFAIK applying that patch
we are supposed to be aligned to the ETSI spec (and so no need to change
the name).

Regards,
Lorenzo
>=20
> BR
> Janusz
>=20
> > Regards,
> > Lorenzo
> >
> > [0] "cfg80211: allow continuous radar monitoring on offchannel chain"
> > https://lore.kernel.org/linux-wireless/d46217310a49b14ff0e9c002f0a6e054=
7d70fd2c.1637071350.git.lorenzo@kernel.org/T/#u
> >
> > >
> > >
> > >
> > > > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> > > > index 362da9f6bf39..a887086cb103 100644
> > > > --- a/include/net/cfg80211.h
> > > > +++ b/include/net/cfg80211.h
> > > > @@ -7605,15 +7605,33 @@ void cfg80211_cqm_txe_notify(struct net_dev=
ice *dev, const u8 *peer,
> > > >  void cfg80211_cqm_beacon_loss_notify(struct net_device *dev, gfp_t=
 gfp);
> > > >
> > > >  /**
> > > > - * cfg80211_radar_event - radar detection event
> > > > + * __cfg80211_radar_event - radar detection event
> > > >   * @wiphy: the wiphy
> > > >   * @chandef: chandef for the current channel
> > > > + * @offchan: the radar has been detected on the offchannel chain
> > > >   * @gfp: context flags
> > > >   *
> > > >   * This function is called when a radar is detected on the current=
 chanenl.
> > > >   */
> > > > -void cfg80211_radar_event(struct wiphy *wiphy,
> > > > -                         struct cfg80211_chan_def *chandef, gfp_t =
gfp);
> > > > +void __cfg80211_radar_event(struct wiphy *wiphy,
> > > > +                           struct cfg80211_chan_def *chandef,
> > > > +                           bool offchan, gfp_t gfp);
> > > > +
> > > > +static inline void
> > > > +cfg80211_radar_event(struct wiphy *wiphy,
> > > > +                    struct cfg80211_chan_def *chandef,
> > > > +                    gfp_t gfp)
> > > > +{
> > > > +       __cfg80211_radar_event(wiphy, chandef, false, gfp);
> > > > +}
> > > > +
> > > > +static inline void
> > > > +cfg80211_offchan_radar_event(struct wiphy *wiphy,
> > > > +                            struct cfg80211_chan_def *chandef,
> > > > +                            gfp_t gfp)
> > > > +{
> > > > +       __cfg80211_radar_event(wiphy, chandef, true, gfp);
> > > > +}
> > > >
> > > >  /**
> > > >   * cfg80211_sta_opmode_change_notify - STA's ht/vht operation mode=
 change event
> > > > diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> > > > index ac2e5e732d94..450be1ec70b8 100644
> > > > --- a/net/wireless/mlme.c
> > > > +++ b/net/wireless/mlme.c
> > > > @@ -905,13 +905,13 @@ void cfg80211_dfs_channels_update_work(struct=
 work_struct *work)
> > > >  }
> > > >
> > > >
> > > > -void cfg80211_radar_event(struct wiphy *wiphy,
> > > > -                         struct cfg80211_chan_def *chandef,
> > > > -                         gfp_t gfp)
> > > > +void __cfg80211_radar_event(struct wiphy *wiphy,
> > > > +                           struct cfg80211_chan_def *chandef,
> > > > +                           bool offchan, gfp_t gfp)
> > > >  {
> > > >         struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(w=
iphy);
> > > >
> > > > -       trace_cfg80211_radar_event(wiphy, chandef);
> > > > +       trace_cfg80211_radar_event(wiphy, chandef, offchan);
> > > >
> > > >         /* only set the chandef supplied channel to unavailable, in
> > > >          * case the radar is detected on only one of multiple chann=
els
> > > > @@ -919,6 +919,9 @@ void cfg80211_radar_event(struct wiphy *wiphy,
> > > >          */
> > > >         cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_UNAVAILA=
BLE);
> > > >
> > > > +       if (offchan)
> > > > +               queue_work(cfg80211_wq, &rdev->offchan_cac_abort_wk=
);
> > > > +
> > > >         cfg80211_sched_dfs_chan_update(rdev);
> > > >
> > > >         nl80211_radar_notify(rdev, chandef, NL80211_RADAR_DETECTED,=
 NULL, gfp);
> > > > @@ -926,7 +929,7 @@ void cfg80211_radar_event(struct wiphy *wiphy,
> > > >         memcpy(&rdev->radar_chandef, chandef, sizeof(struct cfg8021=
1_chan_def));
> > > >         queue_work(cfg80211_wq, &rdev->propagate_radar_detect_wk);
> > > >  }
> > > > -EXPORT_SYMBOL(cfg80211_radar_event);
> > > > +EXPORT_SYMBOL(__cfg80211_radar_event);
> > > >
> > > >  void cfg80211_cac_event(struct net_device *netdev,
> > > >                         const struct cfg80211_chan_def *chandef,
> > > > @@ -998,7 +1001,8 @@ __cfg80211_offchan_cac_event(struct cfg80211_r=
egistered_device *rdev,
> > > >                 rdev->offchan_radar_wdev =3D NULL;
> > > >                 break;
> > > >         case NL80211_RADAR_CAC_ABORTED:
> > > > -               cancel_delayed_work(&rdev->offchan_cac_done_wk);
> > > > +               if (!cancel_delayed_work(&rdev->offchan_cac_done_wk=
))
> > > > +                       return;
> > > >                 wdev =3D rdev->offchan_radar_wdev;
> > > >                 rdev->offchan_radar_wdev =3D NULL;
> > > >                 break;
> > > > diff --git a/net/wireless/trace.h b/net/wireless/trace.h
> > > > index 0b27eaa14a18..e854d52db1a6 100644
> > > > --- a/net/wireless/trace.h
> > > > +++ b/net/wireless/trace.h
> > > > @@ -3053,18 +3053,21 @@ TRACE_EVENT(cfg80211_ch_switch_started_noti=
fy,
> > > >  );
> > > >
> > > >  TRACE_EVENT(cfg80211_radar_event,
> > > > -       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *cha=
ndef),
> > > > -       TP_ARGS(wiphy, chandef),
> > > > +       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *cha=
ndef,
> > > > +                bool offchan),
> > > > +       TP_ARGS(wiphy, chandef, offchan),
> > > >         TP_STRUCT__entry(
> > > >                 WIPHY_ENTRY
> > > >                 CHAN_DEF_ENTRY
> > > > +               __field(bool, offchan)
> > > >         ),
> > > >         TP_fast_assign(
> > > >                 WIPHY_ASSIGN;
> > > >                 CHAN_DEF_ASSIGN(chandef);
> > > > +               __entry->offchan =3D offchan;
> > > >         ),
> > > > -       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
> > > > -                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
> > > > +       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT ", offchan %d",
> > > > +                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG, __entry->offchan)
> > > >  );
> > > >
> > > >  TRACE_EVENT(cfg80211_cac_event,
> > > > --
> > > > 2.31.1
> > > >
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

--Z0mlzYjdWslreG7R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZPBPwAKCRA6cBh0uS2t
rPZTAP9c5JdpDFFIFPqvIAwFNTkCyQMYmAAijKPDg7kbqeL4LgD/fPb/LoLQnRHI
IuNta3y6wnmo6KDtahkxIHaqymDqxg8=
=Qr2N
-----END PGP SIGNATURE-----

--Z0mlzYjdWslreG7R--

