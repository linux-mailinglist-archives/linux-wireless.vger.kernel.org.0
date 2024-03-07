Return-Path: <linux-wireless+bounces-4452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C409874D30
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 12:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A81C20E05
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6068529C;
	Thu,  7 Mar 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/oo9gHk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA945C8E3
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810249; cv=none; b=V5ND37qMKzbU+IxnE+1ze38I+5IG4JpEb2xuW/79a2LMW3gEV6uQEewmUg9jTjSDRs0YhxaSFk/51FgEc1anxPp11uxJib+GJm0gAbTcnUW/tDN8ysWzqaWhrUNZurPHs52VhnhvOETxrGuQ7om4og7jJ3h4o/oDd/Fd/EIedPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810249; c=relaxed/simple;
	bh=noVrTzADk5MLxl13sgvJBZuvtxPbZk2va39CKN/RpZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV/Tc9Ba1C4/MPIPfRU0FIrKYtZu4VLKDPd5A6l8uDjrHpPtcUJE2+2xczIwYJLbugWDTVEfY5L0lpY4l8p4Z+IDRXIReNx8fds3NbKO+GcubyTCysTrvoUffSdhkFNNHDfcGGoS0h+ESquAY93bkxIjGI/GmqyDO8fEt90zMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/oo9gHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEAEC433F1;
	Thu,  7 Mar 2024 11:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709810249;
	bh=noVrTzADk5MLxl13sgvJBZuvtxPbZk2va39CKN/RpZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/oo9gHklGo8uO05iepe8rNIEo6T8MNgguU6igYntI+hs5KIYx9/NFYq36wjUQ/W3
	 Hw5cG941fglskyhsbU3QyiQ0qBeuM4Jy3/lhLV1uR8QfaSBlSP0Qug1L71FT+H32Ow
	 x9Ym3YMZtpaBxhf5tgHHdn94An3bCVQyyyrrvWxuCVnHhG/ku8AsLhA8I9I259nn2o
	 6szOK62LOn0avmXglumCSJvfL960Q2K0Vv6MNohr8mZTVjArRG1icYodwsTDH9qzeI
	 HoqR+dZVsfm4y6cp2YO8RtutMI+NCiH8wB7cX2qcfIHd2DGKndgQt+XsaGXi72/2fD
	 pks4VSPTaGdmA==
Date: Thu, 7 Mar 2024 12:17:25 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, deren.wu@mediatek.com, Sean.Wang@mediatek.com,
	Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com,
	robin.chiu@mediatek.com, ch.yeh@mediatek.com, posh.sun@mediatek.com,
	Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com,
	Shayne.Chen@mediatek.com, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7925: ensure 4-byte alignment for suspend
 & wow command
Message-ID: <ZemiRaRNhNTn-XLb@lore-desk>
References: <20240307110815.527-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hPK9O+BSXO6lyn26"
Content-Disposition: inline
In-Reply-To: <20240307110815.527-1-mingyen.hsieh@mediatek.com>


--hPK9O+BSXO6lyn26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>=20
> Before sending suspend & wow command to FW, its length should be
> 4-bytes alignd.
>=20
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 1 +
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h      | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> index af0c2b2aacb0..ef29d093f9c3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> @@ -2527,6 +2527,7 @@ int mt76_connac_mcu_set_hif_suspend(struct mt76_dev=
 *dev, bool suspend)
>  			__le16 tag;
>  			__le16 len;
>  			u8 suspend;
> +			u8 pad[7];

mt76_connac_mcu_set_hif_suspend() is used even by other drv (e.g. mt7615). =
Is
this change backward compatible?

Regards,
Lorenzo

>  		} __packed hif_suspend;
>  	} req =3D {
>  		.hif_suspend =3D {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mcu.h
> index 2a0bbfe7bfa5..b8315a89f4a9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
> @@ -535,7 +535,7 @@ struct mt7925_wow_pattern_tlv {
>  	u8 offset;
>  	u8 mask[MT76_CONNAC_WOW_MASK_MAX_LEN];
>  	u8 pattern[MT76_CONNAC_WOW_PATTEN_MAX_LEN];
> -	u8 rsv[4];
> +	u8 rsv[7];
>  } __packed;
> =20
>  static inline enum connac3_mcu_cipher_type
> --=20
> 2.18.0
>=20

--hPK9O+BSXO6lyn26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZemiRQAKCRA6cBh0uS2t
rC3TAQD2nyW0jjKsA5ibpFk88RbBGpFj7M5IY6YKAUfYccBL7QEA+ACex8pWuzKC
NG0ubBBlrg29kthxg6x65IyMhkSwHQY=
=VuWY
-----END PGP SIGNATURE-----

--hPK9O+BSXO6lyn26--

