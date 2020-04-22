Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC41B4DB6
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 21:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDVTws (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 15:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVTws (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 15:52:48 -0400
Received: from lore-desk-wlan (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CE12071E;
        Wed, 22 Apr 2020 19:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587585167;
        bh=y0JHWvGjvwSO5+iXChXSG8zecr7blu2SJx+hB3TE+eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aiePX+iLt2LFMKUeJYsVzq6tKX7BH2XMrn7zIjfGCZTXY7jHm+LR3vxwtr3oO8cGJ
         7oqaA1UnCFzkPW9rdR8gX1/InvN41Z1JD2xawBFJ9dowktG0B8R9kEcWsmjp64nNXv
         wUDOU65hUfwRyP+gWUyMwvf99SPUAMMGQPYO/API=
Date:   Wed, 22 Apr 2020 21:52:36 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Soul Huang <Soul.Huang@mediatek.com>
Subject: Re: [PATCH v2] mt76: mt7663: fix up BMC entry indicated to unicmd
 firmware
Message-ID: <20200422195236.GB85966@lore-desk-wlan>
References: <71a5733885991a8211104b616d2f51d120efccb9.1587580510.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <71a5733885991a8211104b616d2f51d120efccb9.1587580510.git.sean.wang@mediatek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> BMC entry for MT7663 unicmd firmware should be a broadcast/multicast entr=
y,
> not a unicast entry, that is GTK rekey offload would rely on.
>=20
> Fixes: 138860679b2a ("mt76: mt7615: add more uni mcu commands")
> Cc: Soul Huang <Soul.Huang@mediatek.com>
> Suggested-by: YF Luo <Yf.Luo@mediatek.com>
> Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> --
> v1->v2:
> mt7615_mcu_uni_add_bss is only called on mt7663 with the offload firmware,
> so remove the entire unnecessary if code section.
> ---
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c    | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index 24b78d10d7f7..994446b1baba 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -1359,7 +1359,7 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy,
>  			.short_st =3D true,
>  		},
>  	};
> -	u8 idx, tx_wlan_idx =3D 0;
> +	u8 idx, tx_wlan_idx =3D mvif->sta.wcid.idx;

nitpick: I guess we do not need tx_wlan_idx anymore.

Regards,
Lorenzo

>  	int err;
> =20
>  	idx =3D mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
> @@ -1369,24 +1369,8 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy,
>  	case NL80211_IFTYPE_MESH_POINT:
>  	case NL80211_IFTYPE_AP:
>  		basic_req.basic.conn_type =3D cpu_to_le32(CONNECTION_INFRA_AP);
> -		tx_wlan_idx =3D mvif->sta.wcid.idx;
>  		break;
>  	case NL80211_IFTYPE_STATION:
> -		if (enable) {
> -			struct ieee80211_sta *sta;
> -			struct mt7615_sta *msta;
> -
> -			rcu_read_lock();
> -			sta =3D ieee80211_find_sta(vif, vif->bss_conf.bssid);
> -			if (!sta) {
> -				rcu_read_unlock();
> -				return -EINVAL;
> -			}
> -
> -			msta =3D (struct mt7615_sta *)sta->drv_priv;
> -			tx_wlan_idx =3D msta->wcid.idx;
> -			rcu_read_unlock();
> -		}
>  		basic_req.basic.conn_type =3D cpu_to_le32(CONNECTION_INFRA_STA);
>  		break;
>  	default:
> --=20
> 2.25.1

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXqCggQAKCRA6cBh0uS2t
rAUxAQCcW+AzZMGG20XYXqueNgrfuJTgk3eyNLgLpHG1HDrf2wD/d3dg1WSpFtps
SN3BCUDZo2PIjb1valYRBTiHZon/qgA=
=3J44
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
