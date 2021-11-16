Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A8A4533E5
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhKPOR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 09:17:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237163AbhKPORt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 09:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637072089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dZqFtPRB6VMq1+uLMOyMoAQ/XzYa98ZDgdqLYWHCBpc=;
        b=GpTTQBU2FGX99qP1opoWmP6n0E74YMfOR3p2eZkDQ1BkeWJWqmfbajFo3iOVp7/lEkAcud
        Yx8aW+d/RQxcs2rKJ0PNpxPiY5fn+TwJs7t2gM20xjaMDgU1eW0ouGjXsHOIVJrzbamDQn
        fmDeBzMptRjdQqhiXdmaV7exoEc+wPs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-EE57e-7aNwi0U7BNMRdyMA-1; Tue, 16 Nov 2021 09:14:47 -0500
X-MC-Unique: EE57e-7aNwi0U7BNMRdyMA-1
Received: by mail-ed1-f70.google.com with SMTP id w13-20020a05640234cd00b003e2fde5ff8aso17226168edc.14
        for <linux-wireless@vger.kernel.org>; Tue, 16 Nov 2021 06:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZqFtPRB6VMq1+uLMOyMoAQ/XzYa98ZDgdqLYWHCBpc=;
        b=off04s6RtgitpE82Hf7prACxN3d2w31DR/FQOLujkCZ3l43C8UIgZIXfWQVrAQlJom
         KPkcYvErtC/qj0cme1BgXNM11vZvMGbLWXPqfg3z/BZ2CjuC9a6wQ28k1a+HYLi2uH76
         /8vF1yDS2PE3JoDKyu56kY05cI+MqK7mKZzHj9jIJ9cLeYiK3YgJSU091nd0qmjGUY0t
         JebDCXwWTSKJWghNEQimxVc8zfnv1/bgi4WE2LLvX6G//HG8pr/USNoZxqzpTfl/FWQS
         dPMorolU/TeKkAEjlSAwf9H7lwl0MGgySlCZTZ8SKJa4oKrqQKjVYXic37+bFOLp1nQo
         3bBA==
X-Gm-Message-State: AOAM530xQ9lK5wlJiBgu+8ZyA4np54FkzcCmf6FzqDlHKExUpN2nBCAh
        VB+7b94mc3NAei34w7Nb6NIVbh1YfVqXN1x65lo+Kx0tfBvpEP1FJUrXwuZsizCFMN8S9bcnfVt
        8f3eSSsQBEiMKvZIsytgko+54g60=
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr5405374edd.113.1637072086616;
        Tue, 16 Nov 2021 06:14:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzW3LgNlahxMx7wWsiqOBjZLOmYliC0cYm66ncbo3pSyuGMmPF+cnPJiF5hPxLVe00X5BIFdQ==
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr5405341edd.113.1637072086358;
        Tue, 16 Nov 2021 06:14:46 -0800 (PST)
Received: from localhost (net-93-151-197-210.cust.vodafonedsl.it. [93.151.197.210])
        by smtp.gmail.com with ESMTPSA id jy28sm3631717ejc.118.2021.11.16.06.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 06:14:45 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:14:44 +0100
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
Message-ID: <YZO81KczA9gqh4bO@lore-desk>
References: <3ff583e021e3343a3ced54a7b09b5e184d1880dc.1637062727.git.lorenzo@kernel.org>
 <CAFED-j=i9wuN4JuiF4z2q5qbrhrLL_Php7pi6mpniMUeHHFUPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XBXuJ8M9uQUjuF10"
Content-Disposition: inline
In-Reply-To: <CAFED-j=i9wuN4JuiF4z2q5qbrhrLL_Php7pi6mpniMUeHHFUPA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--XBXuJ8M9uQUjuF10
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> wt., 16 lis 2021 o 12:46 Lorenzo Bianconi <lorenzo@kernel.org> napisa=C5=
=82(a):
> >
> > If necessary schedule offchan_cac_abort_wk work in cfg80211_radar_event
> > routine adding offchan parameter to cfg80211_radar_event signature.
> > Rename cfg80211_radar_event in __cfg80211_radar_event and introduce
> > the two following inline helpers:
> > - cfg80211_radar_event
> > - cfg80211_offchan_radar_event
> > Doing so the drv will not need to run cfg80211_offchan_cac_abort() after
> > radar detection on the offchannel chain.
> >
> > Tested-by: Owen Peng <owen.peng@mediatek.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  include/net/cfg80211.h | 24 +++++++++++++++++++++---
> >  net/wireless/mlme.c    | 16 ++++++++++------
> >  net/wireless/trace.h   | 11 +++++++----
> >  3 files changed, 38 insertions(+), 13 deletions(-)
> >
>=20
> BTW, if we don't have user for this yet, maybe we should change name
> offchannel -> background.
> In ETSI spec
> https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60/en_=
301893v020101p.pdf
> we have off-channel CAC defined little bit different:
>=20
> "Off-Channel CAC is performed by a number of non-continuous checks
> spread over a period in time. This period, which is required to
> determine the presence of radar signals, is defined as the Off-Channel
> CAC Time."
>=20
> And:
> "Minimum Off-Channel CAC Time 6 minutes (see note 2) Maximum
> Off-Channel CAC Time 4 hours (see note 2)"
>=20
> So, your implementation simple run "background CAC" - use one (or
> more) chain for that.
>=20
> BR
> Janusz

Hi Janusz,

I have just posted a patch [0] in order to allow continuous radar monitoring
through the off-channel chain. I guess it is what you are referring to, rig=
ht?

Regards,
Lorenzo

[0] "cfg80211: allow continuous radar monitoring on offchannel chain"
https://lore.kernel.org/linux-wireless/d46217310a49b14ff0e9c002f0a6e0547d70=
fd2c.1637071350.git.lorenzo@kernel.org/T/#u

>=20
>=20
>=20
> > diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> > index 362da9f6bf39..a887086cb103 100644
> > --- a/include/net/cfg80211.h
> > +++ b/include/net/cfg80211.h
> > @@ -7605,15 +7605,33 @@ void cfg80211_cqm_txe_notify(struct net_device =
*dev, const u8 *peer,
> >  void cfg80211_cqm_beacon_loss_notify(struct net_device *dev, gfp_t gfp=
);
> >
> >  /**
> > - * cfg80211_radar_event - radar detection event
> > + * __cfg80211_radar_event - radar detection event
> >   * @wiphy: the wiphy
> >   * @chandef: chandef for the current channel
> > + * @offchan: the radar has been detected on the offchannel chain
> >   * @gfp: context flags
> >   *
> >   * This function is called when a radar is detected on the current cha=
nenl.
> >   */
> > -void cfg80211_radar_event(struct wiphy *wiphy,
> > -                         struct cfg80211_chan_def *chandef, gfp_t gfp);
> > +void __cfg80211_radar_event(struct wiphy *wiphy,
> > +                           struct cfg80211_chan_def *chandef,
> > +                           bool offchan, gfp_t gfp);
> > +
> > +static inline void
> > +cfg80211_radar_event(struct wiphy *wiphy,
> > +                    struct cfg80211_chan_def *chandef,
> > +                    gfp_t gfp)
> > +{
> > +       __cfg80211_radar_event(wiphy, chandef, false, gfp);
> > +}
> > +
> > +static inline void
> > +cfg80211_offchan_radar_event(struct wiphy *wiphy,
> > +                            struct cfg80211_chan_def *chandef,
> > +                            gfp_t gfp)
> > +{
> > +       __cfg80211_radar_event(wiphy, chandef, true, gfp);
> > +}
> >
> >  /**
> >   * cfg80211_sta_opmode_change_notify - STA's ht/vht operation mode cha=
nge event
> > diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
> > index ac2e5e732d94..450be1ec70b8 100644
> > --- a/net/wireless/mlme.c
> > +++ b/net/wireless/mlme.c
> > @@ -905,13 +905,13 @@ void cfg80211_dfs_channels_update_work(struct wor=
k_struct *work)
> >  }
> >
> >
> > -void cfg80211_radar_event(struct wiphy *wiphy,
> > -                         struct cfg80211_chan_def *chandef,
> > -                         gfp_t gfp)
> > +void __cfg80211_radar_event(struct wiphy *wiphy,
> > +                           struct cfg80211_chan_def *chandef,
> > +                           bool offchan, gfp_t gfp)
> >  {
> >         struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wiphy=
);
> >
> > -       trace_cfg80211_radar_event(wiphy, chandef);
> > +       trace_cfg80211_radar_event(wiphy, chandef, offchan);
> >
> >         /* only set the chandef supplied channel to unavailable, in
> >          * case the radar is detected on only one of multiple channels
> > @@ -919,6 +919,9 @@ void cfg80211_radar_event(struct wiphy *wiphy,
> >          */
> >         cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_UNAVAILABLE);
> >
> > +       if (offchan)
> > +               queue_work(cfg80211_wq, &rdev->offchan_cac_abort_wk);
> > +
> >         cfg80211_sched_dfs_chan_update(rdev);
> >
> >         nl80211_radar_notify(rdev, chandef, NL80211_RADAR_DETECTED, NUL=
L, gfp);
> > @@ -926,7 +929,7 @@ void cfg80211_radar_event(struct wiphy *wiphy,
> >         memcpy(&rdev->radar_chandef, chandef, sizeof(struct cfg80211_ch=
an_def));
> >         queue_work(cfg80211_wq, &rdev->propagate_radar_detect_wk);
> >  }
> > -EXPORT_SYMBOL(cfg80211_radar_event);
> > +EXPORT_SYMBOL(__cfg80211_radar_event);
> >
> >  void cfg80211_cac_event(struct net_device *netdev,
> >                         const struct cfg80211_chan_def *chandef,
> > @@ -998,7 +1001,8 @@ __cfg80211_offchan_cac_event(struct cfg80211_regis=
tered_device *rdev,
> >                 rdev->offchan_radar_wdev =3D NULL;
> >                 break;
> >         case NL80211_RADAR_CAC_ABORTED:
> > -               cancel_delayed_work(&rdev->offchan_cac_done_wk);
> > +               if (!cancel_delayed_work(&rdev->offchan_cac_done_wk))
> > +                       return;
> >                 wdev =3D rdev->offchan_radar_wdev;
> >                 rdev->offchan_radar_wdev =3D NULL;
> >                 break;
> > diff --git a/net/wireless/trace.h b/net/wireless/trace.h
> > index 0b27eaa14a18..e854d52db1a6 100644
> > --- a/net/wireless/trace.h
> > +++ b/net/wireless/trace.h
> > @@ -3053,18 +3053,21 @@ TRACE_EVENT(cfg80211_ch_switch_started_notify,
> >  );
> >
> >  TRACE_EVENT(cfg80211_radar_event,
> > -       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef=
),
> > -       TP_ARGS(wiphy, chandef),
> > +       TP_PROTO(struct wiphy *wiphy, struct cfg80211_chan_def *chandef,
> > +                bool offchan),
> > +       TP_ARGS(wiphy, chandef, offchan),
> >         TP_STRUCT__entry(
> >                 WIPHY_ENTRY
> >                 CHAN_DEF_ENTRY
> > +               __field(bool, offchan)
> >         ),
> >         TP_fast_assign(
> >                 WIPHY_ASSIGN;
> >                 CHAN_DEF_ASSIGN(chandef);
> > +               __entry->offchan =3D offchan;
> >         ),
> > -       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
> > -                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
> > +       TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT ", offchan %d",
> > +                 WIPHY_PR_ARG, CHAN_DEF_PR_ARG, __entry->offchan)
> >  );
> >
> >  TRACE_EVENT(cfg80211_cac_event,
> > --
> > 2.31.1
> >
>=20
>=20
> --=20
> Janusz Dziedzic
>=20

--XBXuJ8M9uQUjuF10
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZO80wAKCRA6cBh0uS2t
rDo4AP0aU5Nzu0qgQ4BBYO8ZQrkp++itvLW7IUNAF1Sn0axN/QEAywyeR2ehoGB+
Np5gikJuG7BRLTaAp4FIPn+8c6AD6Qg=
=ByID
-----END PGP SIGNATURE-----

--XBXuJ8M9uQUjuF10--

