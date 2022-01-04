Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DD448409F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jan 2022 12:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiADLQF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jan 2022 06:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiADLQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jan 2022 06:16:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2500C061761
        for <linux-wireless@vger.kernel.org>; Tue,  4 Jan 2022 03:16:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7096761320
        for <linux-wireless@vger.kernel.org>; Tue,  4 Jan 2022 11:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479D4C36AEB;
        Tue,  4 Jan 2022 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641294963;
        bh=IpB/Do7r+JMPbS58aYB/l1LIUvYvxdvEh1UkMetfWno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDuzjkvFzr+CjcW1JDbsrPd92QaaEes03UtSuUpSbDLuFIpxmEnRjZGU+NiHeV27y
         jGIPcI9LntfRjcJ/wAlHvftCvD8ZriwRFFmoZ0mPooshXQV3X4ZXkgPWu/JPPPSD+d
         D+zlYRyZ6p+bU902uvcPqJej426Mri5InRNuLC7WnWwwAdPi19YRkO318NBJ1tBQn7
         3GYHutQ8zBeX+5vcF32E0xPaQVd9rpn/aAaCposCrVY1h1bsPxixWcoHb1Lr04GsrH
         Ple/h5AXfn8665pAnQfnXWcSoVz4A1UhqBy7jHfBqPG3wVnOiStUKs06lYC+FXrdJw
         eMWZ+ez1o9sIA==
Date:   Tue, 4 Jan 2022 12:15:58 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 07/11] mt76: mt7915: fix rate rix and flags in txs path
Message-ID: <YdQsbsb9ayaBUvyO@localhost.localdomain>
References: <20211118164056.2965-1-greearb@candelatech.com>
 <20211118164056.2965-7-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0Ge9CcSI5HdjC6zb"
Content-Disposition: inline
In-Reply-To: <20211118164056.2965-7-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--0Ge9CcSI5HdjC6zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> Do not initialize rix to -1, build the rix and set flags
> based on the mcs, nss, and mode.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index edf33540658e..300928edd0d7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -1571,7 +1571,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, stru=
ct mt76_wcid *wcid, int pid,
>  	struct ieee80211_supported_band *sband;
>  	struct mt76_dev *mdev =3D &dev->mt76;
>  	struct mt76_phy *mphy;
> -	struct ieee80211_tx_info *info;
> +	struct ieee80211_tx_info *info =3D NULL;
>  	struct sk_buff_head list;
>  	struct rate_info rate =3D {};
>  	struct sk_buff *skb =3D NULL;
> @@ -1596,8 +1596,6 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, stru=
ct mt76_wcid *wcid, int pid,
>  		info->status.ampdu_len =3D 1;
>  		info->status.ampdu_ack_len =3D !!(info->flags &
>  						IEEE80211_TX_STAT_ACK);
> -
> -		info->status.rates[0].idx =3D -1;
>  	}
> =20
>  	txrate =3D FIELD_GET(MT_TXS0_TX_RATE, txs);
> @@ -1627,6 +1625,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, stru=
ct mt76_wcid *wcid, int pid,
> =20
>  		rate.mcs =3D mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
>  		rate.legacy =3D sband->bitrates[rate.mcs].bitrate;
> +		if (info)
> +			info->status.rates[0].idx =3D rate.mcs;

can it be NULL?

>  		break;
>  	case MT_PHY_TYPE_HT:
>  	case MT_PHY_TYPE_HT_GF:
> @@ -1637,6 +1637,10 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, str=
uct mt76_wcid *wcid, int pid,
>  		rate.flags =3D RATE_INFO_FLAGS_MCS;
>  		if (wcid->rate_short_gi)
>  			rate.flags |=3D RATE_INFO_FLAGS_SHORT_GI;
> +		if (info) {
> +			info->status.rates[0].idx =3D rate.mcs + rate.nss * 8;
> +			info->status.rates[0].flags |=3D IEEE80211_TX_RC_MCS;
> +		}
>  		break;
>  	case MT_PHY_TYPE_VHT:
>  		if (rate.mcs > 9)
> @@ -1645,6 +1649,10 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, str=
uct mt76_wcid *wcid, int pid,
>  		rate.flags =3D RATE_INFO_FLAGS_VHT_MCS;
>  		if (wcid->rate_short_gi)
>  			rate.flags |=3D RATE_INFO_FLAGS_SHORT_GI;
> +		if (info) {
> +			info->status.rates[0].idx =3D (rate.nss << 4) | rate.mcs;

ieee80211_rate_set_vht()

> +			info->status.rates[0].flags |=3D IEEE80211_TX_RC_VHT_MCS;
> +		}
>  		break;
>  	case MT_PHY_TYPE_HE_SU:
>  	case MT_PHY_TYPE_HE_EXT_SU:
> @@ -1656,6 +1664,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, stru=
ct mt76_wcid *wcid, int pid,
>  		rate.he_gi =3D wcid->rate_he_gi;
>  		rate.he_dcm =3D FIELD_GET(MT_TX_RATE_DCM, txrate);
>  		rate.flags =3D RATE_INFO_FLAGS_HE_MCS;
> +		if (info)
> +			info->status.rates[0].idx =3D (rate.nss << 4) | rate.mcs;
>  		break;
>  	default:
>  		WARN_ON_ONCE(true);
> --=20
> 2.20.1
>=20

--0Ge9CcSI5HdjC6zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYdQsagAKCRA6cBh0uS2t
rGTHAQDxxNkfCSFDooR6oleQxkoegWWCyuaEyodSA+N6nuu97wD9HVHvSYNHhDDj
3KMx9ZN2js8KQbWUqVXLfzEAg2PQxAU=
=Mnxe
-----END PGP SIGNATURE-----

--0Ge9CcSI5HdjC6zb--
