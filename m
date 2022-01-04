Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF8C48403E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jan 2022 11:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiADK6W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jan 2022 05:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiADK6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jan 2022 05:58:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E489C061784
        for <linux-wireless@vger.kernel.org>; Tue,  4 Jan 2022 02:58:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24276132E
        for <linux-wireless@vger.kernel.org>; Tue,  4 Jan 2022 10:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B55C36AEB;
        Tue,  4 Jan 2022 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641293896;
        bh=zz+S9Bq7PchVOyTYKiIyF/NiyeImmq8GxRopIWAwkT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZg4nvxzn31TDLJhGfYWUJKrL67G6ZBzvrtdnq2U3CLwDk3Aty2/7AOSNcTbWzX8a
         /UVXV6M0kIGZ6MhORMXIdyGElFvi1ukQklNtij1huT939kwFNdv9JdcQ5yrj7qKOkF
         8DQ9SrI4xGuezfehGVjgxQqXUU5B/Wv1Zdnahl6IB1gtY2+fViDfr37YLKOCDuSwRC
         VgRXhd6cN3CzDzA8iJrHkcR/62h20400Mnm6DVrqZSIg+BaVB8xLzQWdDnjJh2PO++
         RHswoNxEmJsjMigZROmzJVfLlfMQvZIIL49WXYvwhFNrx63MIpLRV17VCX0bwldlHx
         lHbpYSn8ynuyw==
Date:   Tue, 4 Jan 2022 11:58:10 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 05/11] mt76: mt7915: ethtool group-5 rx stats information
Message-ID: <YdQoQqyzWHfqc9is@localhost.localdomain>
References: <20211118164056.2965-1-greearb@candelatech.com>
 <20211118164056.2965-5-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OxsLraV/EpS69YX9"
Content-Disposition: inline
In-Reply-To: <20211118164056.2965-5-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--OxsLraV/EpS69YX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20

[...]
> =20
>  		msta =3D container_of(status->wcid, struct mt7915_sta, wcid);
> +		stats =3D &msta->stats;
>  		spin_lock_bh(&dev->sta_poll_lock);
>  		if (list_empty(&msta->poll_list))
>  			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
> @@ -654,8 +656,19 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk=
_buff *skb)
>  				WARN_ON_ONCE(nss > 4);
>  			}
> =20
> +			if (stats) {
> +				if (nss > 3)
> +					stats->rx_nss[3]++;
> +				else
> +					stats->rx_nss[nss - 1]++;
> +
> +				stats->rx_mode[mode]++;
> +			}
> +
>  			switch (FIELD_GET(MT_CRXV_FRAME_MODE, v2)) {
>  			case IEEE80211_STA_RX_BW_20:
> +				if (stats)
> +					stats->rx_bw_20++;
>  				break;
>  			case IEEE80211_STA_RX_BW_40:
>  				if (mode & MT_PHY_TYPE_HE_EXT_SU &&
> @@ -663,14 +676,24 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct s=
k_buff *skb)

after mt7916 support, I guess this patch must be rebased

Regards,
Lorenzo

>  					status->bw =3D RATE_INFO_BW_HE_RU;
>  					status->he_ru =3D
>  						NL80211_RATE_INFO_HE_RU_ALLOC_106;
> +					if (stats) {
> +						stats->rx_bw_he_ru++;
> +						stats->rx_ru_106++;
> +					}
>  				} else {
>  					status->bw =3D RATE_INFO_BW_40;
> +					if (stats)
> +						stats->rx_bw_40++;
>  				}
>  				break;
>  			case IEEE80211_STA_RX_BW_80:
>  				status->bw =3D RATE_INFO_BW_80;
> +				if (stats)
> +					stats->rx_bw_80++;
>  				break;
>  			case IEEE80211_STA_RX_BW_160:
> +				if (stats)
> +					stats->rx_bw_160++;
>  				status->bw =3D RATE_INFO_BW_160;
>  				break;
>  			default:
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index e973b2527b34..bfc81e008f86 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -1170,6 +1170,27 @@ static const char mt7915_gstrings_stats[][ETH_GSTR=
ING_LEN] =3D {
>  	"v_tx_mcs_9",
>  	"v_tx_mcs_10",
>  	"v_tx_mcs_11",
> +
> +	/* per-vif rx counters */
> +	"v_rx_nss1",
> +	"v_rx_nss2",
> +	"v_rx_nss3",
> +	"v_rx_nss4",
> +	"v_rx_mode_cck",
> +	"v_rx_mode_ofdm",
> +	"v_rx_mode_ht",
> +	"v_rx_mode_ht_gf",
> +	"v_rx_mode_vht",
> +	"v_rx_mode_he_su",
> +	"v_rx_mode_he_ext_su",
> +	"v_rx_mode_he_tb",
> +	"v_rx_mode_he_mu",
> +	"v_rx_bw_20",
> +	"v_rx_bw_40",
> +	"v_rx_bw_80",
> +	"v_rx_bw_160",
> +	"v_rx_bw_he_ru",
> +	"v_rx_ru_106",
>  };
> =20
>  #define MT7915_SSTATS_LEN ARRAY_SIZE(mt7915_gstrings_stats)
> --=20
> 2.20.1
>=20

--OxsLraV/EpS69YX9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYdQoPwAKCRA6cBh0uS2t
rOjFAQCSCKvNJlgppOS9LnTavgbnzzZ6kUwkVkwaVM5khqhwEQEAscXa5JWUk3NC
J9pyn7e34x6qvrKbS54hoBMeJDkfxQw=
=7HSy
-----END PGP SIGNATURE-----

--OxsLraV/EpS69YX9--
