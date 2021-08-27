Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9121D3F9E99
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 20:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhH0SNv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 14:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229862AbhH0SNv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 14:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630087981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/8VY6th4bSVsPkwqEJ4X+M5eRdXqdaKLqp253ozSJIs=;
        b=aQzdJ1gK4HbmIAUmICMio5idk9GsjGeTDI4DuNFkqvWe/TVRh/A18veVQ9ptzeVcwZc3P2
        Oedp4a/pb+x+b3WfPVReiCTi9jmHSDVJODjyTC7tpFcXISWedDNlcNQ+T7YSPvO2ewHb5l
        Y2J7mTg/WkmGTpnBiIs7oSFnO4zqfcI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-hjSqHsIcM2SNvMUsrbcJgQ-1; Fri, 27 Aug 2021 14:12:59 -0400
X-MC-Unique: hjSqHsIcM2SNvMUsrbcJgQ-1
Received: by mail-ed1-f72.google.com with SMTP id h4-20020aa7c604000000b003c423efb7efso3662675edq.12
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 11:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/8VY6th4bSVsPkwqEJ4X+M5eRdXqdaKLqp253ozSJIs=;
        b=eVJzkWWl5xqnMH2Vb0sNinKuC9i6Q4RHjLknV7TVcozmJLlrJRD0QUGCd0GrLk6oJv
         dOqhE3HJMwMPD7xJ1IcMhSNr5yyYEfQXZNc98IbsndFD6t13GAjcRUPfP8idSjP2pBjf
         pv5RrRNaVBTNWohlfXjrhVjigcHvTOH902R86jPEQ5WvvLjME2AsM7k23b3k4xeIehWq
         +kW6bQVQwv6j3QQt3fX/7e0hvdAeKrigBYJnT8Gh9tjz+JSIKmcH+XQv61BO8TbalDkZ
         q6MPtiwmcjuatZx6IenjG/jqKTidy+qI1rv6CbwtA5rzkyjjZWilmsSNxURPuHgVPOwV
         o9Cw==
X-Gm-Message-State: AOAM532x+5gokJFvipHDbHXEIUqIvNvaNaU/LZTVINeAgSULxnlBm5iF
        Rsuc0xg5IKExK2yhNqtNPxnGP7nl6N73DMkXD9D62qgByBPl+J4nQGN9qKMN1zgd1iWTQLGf1yD
        m0ZKdVg8QCwRG+r7jEHzpIZ6aDSg=
X-Received: by 2002:a17:906:ae0c:: with SMTP id le12mr11213248ejb.169.1630087978480;
        Fri, 27 Aug 2021 11:12:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYn/Ne0fFY94d2/y5xKlCw9kxnU9vWdOSC4nQy7IIgVAYtqIjwJkS7I6jXIKBsjQXAlMfBTg==
X-Received: by 2002:a17:906:ae0c:: with SMTP id le12mr11213240ejb.169.1630087978330;
        Fri, 27 Aug 2021 11:12:58 -0700 (PDT)
Received: from localhost (net-47-53-3-199.cust.vodafonedsl.it. [47.53.3.199])
        by smtp.gmail.com with ESMTPSA id v24sm3614924edq.79.2021.08.27.11.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 11:12:57 -0700 (PDT)
Date:   Fri, 27 Aug 2021 20:12:54 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Chad Monroe <chad@monroe.io>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Rubio Lu <Rubio-DW.Lu@mediatek.com>,
        Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH 1/2] mt76: mt7615: fix STA mode connection on DFS channels
Message-ID: <YSkrJtKTB40u1U9H@lore-desk>
References: <54c9a89210608d2a9b9adf37a8c2a743275e5723.1630081048.git.chad@monroe.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cAwtYvyHVBtACe+o"
Content-Disposition: inline
In-Reply-To: <54c9a89210608d2a9b9adf37a8c2a743275e5723.1630081048.git.chad@monroe.io>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--cAwtYvyHVBtACe+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Only AP, adhoc and mesh mode needs to check CAC.
> Stations, in particular, do not need this check.
>=20
> Signed-off-by: Rubio Lu <Rubio-DW.Lu@mediatek.com>
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> Signed-off-by: Chad Monroe <chad@monroe.io>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   | 38 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mac.c
> index ed1bba42a322..78b55e872da0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -2153,6 +2153,32 @@ static int mt7615_dfs_start_radar_detector(struct =
mt7615_phy *phy)
>  	return 0;
>  }
> =20
> +struct mt7615_vif_counts {
> +	u32 mesh;
> +	u32 adhoc;
> +	u32 ap;

I think u8 it is enough here. Moreover I think we can just count dfs_vif, w=
hat
do you think?

> +};
> +
> +static void
> +mt7615_vif_counts(void *priv, u8 *mac, struct ieee80211_vif *vif)
> +{
> +	struct mt7615_vif_counts *counts =3D priv;
> +
> +	switch (vif->type) {
> +	case NL80211_IFTYPE_ADHOC:
> +		counts->adhoc++;
> +		break;
> +	case NL80211_IFTYPE_MESH_POINT:
> +		counts->mesh++;
> +		break;
> +	case NL80211_IFTYPE_AP:
> +		counts->ap++;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static int
>  mt7615_dfs_init_radar_specs(struct mt7615_phy *phy)
>  {
> @@ -2196,6 +2222,7 @@ int mt7615_dfs_init_radar_detector(struct mt7615_ph=
y *phy)
>  	struct mt7615_dev *dev =3D phy->dev;
>  	bool ext_phy =3D phy !=3D &dev->phy;
>  	int err;
> +	struct mt7615_vif_counts counts =3D {0};
> =20
>  	if (is_mt7663(&dev->mt76))
>  		return 0;
> @@ -2223,9 +2250,14 @@ int mt7615_dfs_init_radar_detector(struct mt7615_p=
hy *phy)
>  	phy->dfs_state =3D chandef->chan->dfs_state;
> =20
>  	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
> -		if (chandef->chan->dfs_state !=3D NL80211_DFS_AVAILABLE)
> -			return mt7615_dfs_start_radar_detector(phy);
> -
> +		if (chandef->chan->dfs_state !=3D NL80211_DFS_AVAILABLE) {
> +			ieee80211_iterate_active_interfaces(phy->mt76->hw,
> +				IEEE80211_IFACE_ITER_RESUME_ALL,
> +				mt7615_vif_counts, &counts);
> +			if (counts.ap + counts.adhoc + counts.mesh)
> +				mt7615_dfs_start_radar_detector(phy);

here we are not considering the return value of
mt7615_dfs_start_radar_detector()

Regards,
Lorenzo

> +			return 0;
> +		}
>  		return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
>  					  MT_RX_SEL0, 0);
>  	}
> --=20
> 2.20.1
>=20

--cAwtYvyHVBtACe+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYSkrJAAKCRA6cBh0uS2t
rK6PAQDDJusHNSS6Ji0PK6yzz8lYoqtGNB6q2zSzAuGgeBrtVQEA70pLdnR4dkMs
uA47S0Tp+3hYumQL2qbA9OEwqeo0bQo=
=TW1W
-----END PGP SIGNATURE-----

--cAwtYvyHVBtACe+o--

