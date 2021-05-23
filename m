Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8D938DD37
	for <lists+linux-wireless@lfdr.de>; Sun, 23 May 2021 23:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhEWVUJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 May 2021 17:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhEWVUJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 May 2021 17:20:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A36F261168;
        Sun, 23 May 2021 21:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621804722;
        bh=C3M5g3u/UxfJb6k1YxdamazUj6bL9RjogZwbzmkrhMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPNBp3KSlH00ML7RSyU/T9g8sINSOZq+IMi+11REb+gf8rifArIb0cwXJAKl2QUhI
         MYWHTlZ/IgNe/0Nyc1HiuCm6tly4K/um2LnFpihxbycVqUT+18OvYvS+fvxi2nQN1F
         9VwcAZV3eeC3S03zdNZu4v1DLJ17zOVflQ8kDRPJrZt9Vl47vrYiobU4tdIFj4c1/x
         BYV76O1N79wSXUgQCZibyVkiOVsLpNxlxY3likYFT/qiHJ4bUY7fYAFf0PapFejw/E
         ShAJbLQmkH7xDs0IyMP3AfxZTsBEZ/uSYm2PT3wWpgQ1KO/UWZsxESF62njUwMC+0g
         a/040ho9bxREw==
Date:   Sun, 23 May 2021 23:18:37 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: fix UC entry is being overwritten
Message-ID: <YKrGretiq7wo+pzv@lore-desk>
References: <1621495354-4130-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a65hvaA3CeNihl8+"
Content-Disposition: inline
In-Reply-To: <1621495354-4130-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--a65hvaA3CeNihl8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> Fix UC entry is being overwritten by BC entry
>=20
> Fixes: 36fcc8cff592 ("mt76: mt7921: introduce mt7921_mcu_sta_add routine")
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: YN Chen <yn.chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index 73359defa176..f3decc59a6fe 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -875,10 +875,13 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *ph=
y,
>  	if (IS_ERR(skb))
>  		return PTR_ERR(skb);
> =20
> -	mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta, info->enable);
> -	if (info->enable && info->sta)
> -		mt76_connac_mcu_sta_tlv(phy, skb, info->sta, info->vif,
> -					info->rcpi);
> +	if (info->sta) {
> +		mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta,
> +					      info->enable);
> +		if (info->enable)
> +			mt76_connac_mcu_sta_tlv(phy, skb, info->sta,
> +						info->vif, info->rcpi);
> +	}

with this patch we are changing the mt7663 behaviour since we run
mt76_connac_mcu_add_sta_cmd() in mt7615_remove_interface() with
enable =3D false and sta =3D NULL. Can you please confirm you are
not introducing any regression in mt7663?

Regards,
Lorenzo

> =20
>  	sta_wtbl =3D mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
>  					   sizeof(struct tlv));
> --=20
> 2.25.1
>=20

--a65hvaA3CeNihl8+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYKrGngAKCRA6cBh0uS2t
rGmTAP0Q7j+zTudPGyKeq5cEHlichR+GkkNv1O1Rtz51VTroEwD9Ex/lnIyGNEhZ
ELQ0A3F97+318Pvo9Kjefy4zj/eJrgw=
=tC3Q
-----END PGP SIGNATURE-----

--a65hvaA3CeNihl8+--
