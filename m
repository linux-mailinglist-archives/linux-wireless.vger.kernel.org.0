Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDA13E05C6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 18:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhHDQWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 12:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234064AbhHDQWB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 12:22:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E438860F94;
        Wed,  4 Aug 2021 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628094108;
        bh=3KghkMAaEVvO0bpaXEGPMyBaiRpeQXsRfgm2tvbKbFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etP3HeEVLchoQYPkz3OdxNNwoQofy2/aGrtIeOZGh2QzxVAcfDYwx22PX+X3JT3Qn
         lskhxWVyibhOmVbaxw5EzjmndGfFD5/GjZjdrerWa/SOmaG/ajlIiFIIBEy/cYVskr
         Q+k4AtYTnndrzra1dR/j7q83T4kM/syMtjFA88pLlkn18DAAAVmw18heD4clqEINxT
         KK3+RRYNDjJAZPyPtMzJvY4AqwBqhKST4nh9M8B7jjdIhy/IZF/mQamW2bW65srG9M
         pzL31t1SEcYTDxMvWvjgjrV2lEz1/pd4F2ws9zu2tbP6QT4cFlPDwurEXbPTiBjvdj
         N4Gehi8pjP3kg==
Date:   Wed, 4 Aug 2021 18:21:43 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     YN Chen <YN.Chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>, jemele@google.com,
        yenlinlai@google.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] mt76: mt7921: enable VO tx aggregation
Message-ID: <YQq+lxbs7SlKt87h@lore-desk>
References: <889fc1f28a8402f82cb83243af4916c3311c3eb1.1628072837.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vNJtZXllMJRnjY3o"
Content-Disposition: inline
In-Reply-To: <889fc1f28a8402f82cb83243af4916c3311c3eb1.1628072837.git.deren.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--vNJtZXllMJRnjY3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> Avoid throughput drop in VO streaming, enable TX BA by default.

802.11 ampdu is disabled for VO traffic in order to avoid introducing delay=
 I guess.

Regards,
Lorenzo

>=20
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
> ---
> v1 -> v2 : commit format adjustment
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 296e0f7a1d14..1be1e07ae786 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -913,8 +913,6 @@ mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le3=
2 *txwi)
>  		return;
> =20
>  	tid =3D FIELD_GET(MT_TXD1_TID, le32_to_cpu(txwi[1]));
> -	if (tid >=3D 6) /* skip VO queue */
> -		return;
> =20
>  	val =3D le32_to_cpu(txwi[2]);
>  	fc =3D FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
> --=20
> 2.25.1
>=20

--vNJtZXllMJRnjY3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYQq+lAAKCRA6cBh0uS2t
rOWPAQD9D952emRHoqvknYacCFHvccY6iDjStYHSolG6jiE/VQEAq7k5f4u7Sh58
MG0GaWDIbZ4/javYeZ2HrTAQF+R+wAA=
=fERJ
-----END PGP SIGNATURE-----

--vNJtZXllMJRnjY3o--
