Return-Path: <linux-wireless+bounces-1306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D562A81F8F0
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 14:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9022728462E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Dec 2023 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3D8826;
	Thu, 28 Dec 2023 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwhCzhas"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1119E881E
	for <linux-wireless@vger.kernel.org>; Thu, 28 Dec 2023 13:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8A8C433C9;
	Thu, 28 Dec 2023 13:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703771818;
	bh=hATKOzQ3Q86ZtUqOoVn7GJyRPGck95qMw+6ADEnabXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwhCzhasK6hswS3nE4O0iXFkWECzy6V4t+bZSD8boruVp/yREufAWt5WF50OyJRbE
	 tXiJTrQsI9yo469f2vD61Qhd3KubX7UGWbpkeYcaVF9rjMmwfvlymkzuHV4CneYSCE
	 XnnC0G62dLcaPzCmMgIfVm6KdEPpWoeRHBJ3NEo5JQACC8s8je/k8/OtQoq6Tmtq5t
	 e1LyAJCStWkOP4enFH7igkYrHx/v6BzUWonwJl8MH/AwiPzHBbJSCsIwjJMwZFSAHW
	 QZnsOn1zARfkRTN7lZajwZXp4pQPcta8dMUV47Td0ywpieRXtKdJMQCdfuUi0drYta
	 qrvFRYh2RTTnA==
Date: Thu, 28 Dec 2023 14:56:52 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, deren.wu@mediatek.com, Sean.Wang@mediatek.com,
	Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com,
	robin.chiu@mediatek.com, ch.yeh@mediatek.com, posh.sun@mediatek.com,
	Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com,
	Shayne.Chen@mediatek.com, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 04/10] wifi: mt76: mt7925: fix wmm queue mapping
Message-ID: <ZY1-pG8isKAXBhqa@lore-rh-laptop>
References: <20231228090749.15191-1-mingyen.hsieh@mediatek.com>
 <20231228090749.15191-5-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WQ30o7v/EYClCnAa"
Content-Disposition: inline
In-Reply-To: <20231228090749.15191-5-mingyen.hsieh@mediatek.com>


--WQ30o7v/EYClCnAa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>=20
> Firmware uses access class index (ACI) for wmm parameters update,
> so convert mac80211 queue to ACI in mt7925_conf_tx().
>=20
> Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for =
mt7925 chips")
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7925/main.c  | 21 ++++++++++++++++++-
>  .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  2 +-
>  2 files changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/main.c
> index a080df58120f..b832dd8adee5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> @@ -1273,6 +1273,25 @@ mt7925_channel_switch_beacon(struct ieee80211_hw *=
hw,
>  	mt792x_mutex_release(dev);
>  }
> =20
> +static int
> +mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> +	       unsigned int link_id, u16 queue,
> +	       const struct ieee80211_tx_queue_params *params)
> +{
> +	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> +	const u8 mq_to_aci[] =3D {

nit: static const here

Regards,
Lorenzo

> +		    [IEEE80211_AC_VO] =3D 3,
> +		    [IEEE80211_AC_VI] =3D 2,
> +		    [IEEE80211_AC_BE] =3D 0,
> +		    [IEEE80211_AC_BK] =3D 1,
> +	};
> +
> +	/* firmware uses access class index */
> +	mvif->queue_params[mq_to_aci[queue]] =3D *params;
> +
> +	return 0;
> +}
> +
>  static int
>  mt7925_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  		struct ieee80211_bss_conf *link_conf)
> @@ -1396,7 +1415,7 @@ const struct ieee80211_ops mt7925_ops =3D {
>  	.add_interface =3D mt7925_add_interface,
>  	.remove_interface =3D mt792x_remove_interface,
>  	.config =3D mt7925_config,
> -	.conf_tx =3D mt792x_conf_tx,
> +	.conf_tx =3D mt7925_conf_tx,
>  	.configure_filter =3D mt7925_configure_filter,
>  	.bss_info_changed =3D mt7925_bss_info_changed,
>  	.start_ap =3D mt7925_start_ap,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mcu.c
> index 4811fccbe30e..0299045b4b83 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -895,7 +895,7 @@ int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct =
ieee80211_vif *vif)
> =20
>  		e =3D (struct edca *)tlv;
>  		e->set =3D WMM_PARAM_SET;
> -		e->queue =3D ac + mvif->mt76.wmm_idx * MT76_CONNAC_MAX_WMM_SETS;
> +		e->queue =3D ac;
>  		e->aifs =3D q->aifs;
>  		e->txop =3D cpu_to_le16(q->txop);
> =20
> --=20
> 2.18.0
>=20

--WQ30o7v/EYClCnAa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZY1+oQAKCRA6cBh0uS2t
rPj8AP0Qg+6JBTjCMzdcyWCdxF9WJUoD8KX46+BDiNcsAwtWfwD9GQOsR6uC8i+V
DBdzmKvn6Mg5rijo8s1SO00vDUv96Ak=
=GFFC
-----END PGP SIGNATURE-----

--WQ30o7v/EYClCnAa--

