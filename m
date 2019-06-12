Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F4341F05
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 10:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436994AbfFLI00 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 04:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436841AbfFLI00 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 04:26:26 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9DB2063F;
        Wed, 12 Jun 2019 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560327985;
        bh=SeltQsCC2wy87yYogYLFuJgW6iFbwpA137PBXuDvuw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z60Xj9On58T+P2b+vKcLPGEtZ42GiW/RfLcgtgOOTH4zidvls+lPgCT3rk1Pi9e+d
         lB+dwJbXAeUovwForh+dh589bmRPglSuNBQJtAYx0l/eNwcWHmK4VoRKns3DwuVjCi
         J+xowcZtQoU7GNWi7jHRk0YTgGNbSLN6c4g+jUHk=
Date:   Wed, 12 Jun 2019 10:26:19 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mt76: mt7615: update peer's bssid when state
 transition changes
Message-ID: <20190612082618.GA8107@localhost.localdomain>
References: <3065a01998dfa04a5d2d680e820a17cb5c110d0f.1560221172.git.ryder.lee@mediatek.com>
 <449fee28c558b6f02b62275f9beefaab02b47efc.1560221172.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <449fee28c558b6f02b62275f9beefaab02b47efc.1560221172.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Driver should update peer's bssid and bss information when
> state transition changes.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/main.c  |  5 +-
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 49 ++++++++++---------
>  2 files changed, 27 insertions(+), 27 deletions(-)
>=20

[...]

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index e82086eb8aa4..8fc12cd37906 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -741,17 +741,6 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
>  	u8 *buf, *data, tx_wlan_idx =3D 0;
>  	struct req_hdr *hdr;
> =20
> -	if (en) {
> -		len +=3D sizeof(struct bss_info_omac);
> -		features |=3D BIT(BSS_INFO_OMAC);
> -		if (mvif->omac_idx > EXT_BSSID_START) {
> -			len +=3D sizeof(struct bss_info_ext_bss);
> -			features |=3D BIT(BSS_INFO_EXT_BSS);
> -			ntlv++;
> -		}
> -		ntlv++;
> -	}
> -
>  	switch (vif->type) {
>  	case NL80211_IFTYPE_AP:
>  	case NL80211_IFTYPE_MESH_POINT:
> @@ -759,22 +748,23 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
>  		conn_type =3D CONNECTION_INFRA_AP;
>  		break;
>  	case NL80211_IFTYPE_STATION: {
> -		struct ieee80211_sta *sta;
> -		struct mt7615_sta *msta;
> -
> -		rcu_read_lock();
> -
> -		sta =3D ieee80211_find_sta(vif, vif->bss_conf.bssid);
> -		if (!sta) {
> +		/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
> +		if (en) {
> +			struct ieee80211_sta *sta;
> +			struct mt7615_sta *msta;
> +
> +			rcu_read_lock();
> +			sta =3D ieee80211_find_sta(vif, vif->bss_conf.bssid);
> +			if (!sta) {
> +				rcu_read_unlock();
> +				return -EINVAL;
> +			}
> +
> +			msta =3D (struct mt7615_sta *)sta->drv_priv;
> +			tx_wlan_idx =3D msta->wcid.idx;
>  			rcu_read_unlock();
> -			return -EINVAL;
>  		}
> -
> -		msta =3D (struct mt7615_sta *)sta->drv_priv;
> -		tx_wlan_idx =3D msta->wcid.idx;
>  		conn_type =3D CONNECTION_INFRA_STA;
> -
> -		rcu_read_unlock();
>  		break;
>  	}
>  	default:
> @@ -782,6 +772,17 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
>  		break;
>  	}
> =20
> +	if (en) {
> +		len +=3D sizeof(struct bss_info_omac);
> +		features |=3D BIT(BSS_INFO_OMAC);
> +		if (mvif->omac_idx > EXT_BSSID_START) {
> +			len +=3D sizeof(struct bss_info_ext_bss);
> +			features |=3D BIT(BSS_INFO_EXT_BSS);
> +			ntlv++;
> +		}
> +		ntlv++;
> +	}

What did you move this chunk down?

Regards,
Lorenzo

> +
>  	buf =3D kzalloc(len, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
> --=20
> 2.18.0
>=20

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQC3JwAKCRA6cBh0uS2t
rFJyAQCPhUzOHTO9oIBENFN5792OnafbeU2m65jRccNwracrZQD/WD/HqK3FoDS4
EeDnEIgj1yzcCgdAU7vhN8a9VE9gtA4=
=rUIW
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
