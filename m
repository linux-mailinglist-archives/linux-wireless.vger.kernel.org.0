Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A413EEC2E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhHQMKN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 08:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236113AbhHQMKM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 08:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629202179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nOdSm3CC/FGbV6s+mqpA//gRzhFNKrZ/BlRYsyp8/OE=;
        b=RkXRqWJo0C7T0m+2AMSjMCXsQFd/tzGoYPhEhakdRSAywbOVJ8hWHp3Ui6XFGBfpJEMFA7
        5ruYTATLpmUUAD5fI3DunXXLURSrGrBJAxldr3Kcxpam+++IEXoWG4HzRAJlCNcldRgmLm
        PgsdgMalg7LfeW8XShB7HcSTxOJktVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-QvO089YsM7aqubqGq4TdOw-1; Tue, 17 Aug 2021 08:09:37 -0400
X-MC-Unique: QvO089YsM7aqubqGq4TdOw-1
Received: by mail-wm1-f69.google.com with SMTP id m13-20020a7bcf2d000000b002e6cd9941a9so896183wmg.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 05:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nOdSm3CC/FGbV6s+mqpA//gRzhFNKrZ/BlRYsyp8/OE=;
        b=ZLxCC54YjxtYdzyMYp2M+anKHr//uvf7qCM5fruGLHIrtPapfUECS6O072/jM7nYYU
         N4qTfWfKDOpl7eb8RrWm8LcChvJggNMNyixdRC1J/qV06YdJwmicPzqcnpHWq0koxGrL
         nK5byqeOYORVUrqxMQVt6QBbnUZZ8b3+UfL2/Ln03StbGwfBcvjnj1yUYsXW0OIm7dSo
         KlGsW7+z/3bhbfzDmMCztId+LMa7QuyJEz6XZ++eRwp4HY77QWlB9/JnYe6Mc8kiNGf/
         6jX4CVcy77/hVRmct/laTwUayoGxnc+06HZZgZbTR850rgcgwCRiVRiqZAT/ylycaPm1
         sByA==
X-Gm-Message-State: AOAM531A9DdRrQtPwhkGzJgKcnpMOcw7AYaLv+yaxkYy6LqokelUnIXq
        INHNfLqfxLO/T+OZABCODgyfl37Ib3sEUeDJ4PzJB54pxYdeBhe+HHhrshH2fWe0u32wkIxuyra
        +zvRpSO6xyXavU0KoPC+bfYHG8f0=
X-Received: by 2002:a1c:7203:: with SMTP id n3mr3114030wmc.45.1629202176346;
        Tue, 17 Aug 2021 05:09:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCRQMjLb6p4V09UC0C7DKkxrnRO80vR4h3bU+jKItY1FL6brShoShEJJGzh2Zz0MgDMnrecw==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr3114012wmc.45.1629202176116;
        Tue, 17 Aug 2021 05:09:36 -0700 (PDT)
Received: from localhost (net-47-53-237-136.cust.vodafonedsl.it. [47.53.237.136])
        by smtp.gmail.com with ESMTPSA id p8sm1858773wme.22.2021.08.17.05.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 05:09:35 -0700 (PDT)
Date:   Tue, 17 Aug 2021 14:09:32 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        chui-hao.chiu@mediatek.com
Subject: Re: [PATCH v2 mac80211-next 2/7] mac80211: introduce individual TWT
 support in AP mode.
Message-ID: <YRum/ASJ2OnpJB8C@lore-desk>
References: <cover.1628529781.git.lorenzo@kernel.org>
 <e3b70c37cb366399e944a0aa02f0d7cac25b4bb6.1628529781.git.lorenzo@kernel.org>
 <ece8459373db3b76d38a583ec43f73e65d62a6c0.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h4ERRYUSL8Qgc4Fs"
Content-Disposition: inline
In-Reply-To: <ece8459373db3b76d38a583ec43f73e65d62a6c0.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--h4ERRYUSL8Qgc4Fs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >=20
> > +static inline void drv_add_twt_setup(struct ieee80211_local *local,
> > +				     struct ieee80211_sub_if_data *sdata,
> > +				     struct ieee80211_sta *sta,
> > +				     struct ieee80211_twt_params *agrt_req,
> > +				     struct ieee80211_twt_params *agrt_resp)
> > +{
> > +	might_sleep();
> > +	check_sdata_in_driver(sdata);
> > +
> > +	local->ops->add_twt_setup(&local->hw, sta, agrt_req, agrt_resp);
> > +}
> > +
> > +static inline void drv_twt_teardown_request(struct ieee80211_local *lo=
cal,
> > +					    struct ieee80211_sub_if_data *sdata,
> > +					    struct ieee80211_sta *sta,
> > +					    u8 flowid)
> > +{
> > +	might_sleep();
> > +	check_sdata_in_driver(sdata);
> > +
> > +	if (local->ops->twt_teardown_request)
> > +		local->ops->twt_teardown_request(&local->hw, sta, flowid);
> > +}
>=20
> These should have tracing.

ack, I will add tracing in v3

>=20
> > +++ b/net/mac80211/iface.c
> > @@ -1381,6 +1381,19 @@ static void ieee80211_iface_process_skb(struct i=
eee80211_local *local,
> > =A0			WARN_ON(1);
> > =A0			break;
> > =A0		}
> > +	} else if (ieee80211_is_action(mgmt->frame_control) &&
> > +		   mgmt->u.action.category =3D=3D WLAN_CATEGORY_S1G) {
> > +		switch (mgmt->u.action.u.s1g.action_code) {
> > +		case WLAN_S1G_TWT_TEARDOWN:
> > +		case WLAN_S1G_TWT_SETUP:
> > +			if (skb->pkt_type =3D=3D IEEE80211_TX_STATUS_MSG)
> > +				ieee80211_s1g_status_h_twt(sdata, skb);
> > +			else
> > +				ieee80211_s1g_rx_h_twt(sdata, skb);
>=20
>=20
> I *really* don't like what you're doing here with the sdata->skb_queue,
> which we only ever use for RX today.
>=20
> We have today ieee80211_mgd_conn_tx_status() that gets called at the
> right place, so you should add stuff there, and perhaps it needs to
> queue things, or mark a separate TWT data structure before queueing the
> work, or something else - but please don't use the RX skb_queue.

ack, I will review/work on ieee80211_mgd_conn_tx_status() in v3

>=20
> >=20
> > +static ieee80211_rx_result debug_noinline
> > +ieee80211_rx_h_twt(struct ieee80211_rx_data *rx)
>=20
> Please rename this - it's not actually an rx_h_ that's called through
> the normal RX handler stuff, it's just a sub-function for the action RX
> handler.
>=20
> It also doesn't need the rx_result, it can just be bool/int.

ack, naming is hard :)

>=20
> > +	case WLAN_CATEGORY_S1G:
> > +		switch (mgmt->u.action.u.s1g.action_code) {
> > +		case WLAN_S1G_TWT_SETUP:
> > +		case WLAN_S1G_TWT_TEARDOWN:
> > +			if (ieee80211_rx_h_twt(rx) !=3D RX_CONTINUE)
> > +				goto queue;
>=20
>=20
> (see here)
>=20
> > +		default:
>=20
> Also missing a "fallthrough" annotation or such.

ack, I will fix it

>=20
> > +
> > +static int
> > +ieee80211_s1g_rx_h_twt_teardown(struct ieee80211_sub_if_data *sdata,
> > +				struct sta_info *sta, struct sk_buff *skb)
> > +{
> > +	struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)skb->data;
> > +
> > +	drv_twt_teardown_request(sdata->local, sdata, &sta->sta,
> > +				 mgmt->u.action.u.s1g.variable[0]);
> > +
> > +	return 0;
>=20
> Evidently, this cannot fail, so needs no return value.

ack, I will fix it

>=20
> > +void ieee80211_s1g_rx_h_twt(struct ieee80211_sub_if_data *sdata,
> > +			    struct sk_buff *skb)
>=20
> again, not a real RX handler

ack, I will fix it

>=20
> > +{
> > +	struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)skb->data;
> > +	struct ieee80211_local *local =3D sdata->local;
> > +	struct sta_info *sta;
> > +
> > +	mutex_lock(&local->sta_mtx);
> > +
> > +	sta =3D sta_info_get_bss(sdata, mgmt->sa);
> > +	if (!sta)
> > +		goto out;
> > +
> > +	switch (mgmt->u.action.u.s1g.action_code) {
> > +	case WLAN_S1G_TWT_SETUP:
> > +		ieee80211_s1g_rx_h_twt_setup(sdata, sta, skb);
>=20
> You're completely ignoring the return value. That's probably fine in the
> -ENOMEM case, but the other cases you should still send a response. Just
> like the driver callback is void because it should just fill in the
> response to the other side (even in the failure cases).

ack, I will fix it in v3

Regards,
Lorenzo

>=20
> johannes
>=20

--h4ERRYUSL8Qgc4Fs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYRum+gAKCRA6cBh0uS2t
rGpoAPoDPkiO+ug2TUkqjktkUKcTtvrr9oB1IGXYdS7Ss1LYTgD+L5p85+Vg7cpX
tSE+Scwmv9Pnj+Ko42+TM/ZUubJX/wo=
=+A2C
-----END PGP SIGNATURE-----

--h4ERRYUSL8Qgc4Fs--

