Return-Path: <linux-wireless+bounces-1481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D242823F57
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 11:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1773B1F24371
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C89120DC1;
	Thu,  4 Jan 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz7qsW9M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010920B2D
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 10:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9E5C433C9;
	Thu,  4 Jan 2024 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704363374;
	bh=trtYVSxi3isFLB8hoN1od6VQLhV5mwb7swOYF748Zew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cz7qsW9MPjKFpA2TZzP/1KGARempp/UvWITzg2RAYw8MT4wP403BJzUU/ZNJw8xVf
	 VJHSEr6A/g4ALLEgSUEK/qeapu0fcHHQ4YQy5ullzVK9kvRy+sz7HeZn0SRaC9EfS6
	 4BAmppw2aCYswJXoWoo4rIjWtPgMqQ3k4CR0tEqyoDBncVXvACyZ4zOcT8XsjkWvkC
	 QjVoOc4k41JiV36M98UZ2VebtYYtJzXgSdHC6zcN7F+qMn/8U6jH0K0un1M4iQfzB/
	 +dvNdU4ADVqrLBE8oE5MjjJYr0gaGJV5IlAu3tZjj1iL2tsPW33liK69rjZgm7lAbl
	 hBBaUrOM1flSQ==
Date: Thu, 4 Jan 2024 11:16:10 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: nbd@nbd.name, deren.wu@mediatek.com, Sean.Wang@mediatek.com,
	Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
	Eric-SY.Chang@mediatek.com, km.lin@mediatek.com,
	robin.chiu@mediatek.com, ch.yeh@mediatek.com, posh.sun@mediatek.com,
	Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com,
	Shayne.Chen@mediatek.com, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7925: fix the wrong data type for scan
 command
Message-ID: <ZZaFaim6nK2ZvVgi@lore-desk>
References: <20240104094845.11276-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BeFzi6ePts3aTjGP"
Content-Disposition: inline
In-Reply-To: <20240104094845.11276-1-mingyen.hsieh@mediatek.com>


--BeFzi6ePts3aTjGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 04, Mingyen Hsieh wrote:
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>=20
> For the member of 'struct scan_req_tlv', replace data type of
> func_mask_ext from 'u8' to 'u32'.
>=20
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mcu.h
> index 3c41e21303b1..82b7e277397f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
> @@ -208,7 +208,7 @@ struct scan_req_tlv {
>  	__le16 channel_dwell_time; /* channel Dwell interval */
>  	__le16 timeout_value;
>  	__le16 probe_delay_time;
> -	u8 func_mask_ext;
> +	u32 func_mask_ext;

should it be __le32? (even if it is not used yet)

Regards,
Lorenzo

>  };
> =20
>  struct scan_ssid_tlv {
> --=20
> 2.18.0
>=20

--BeFzi6ePts3aTjGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZZaFagAKCRA6cBh0uS2t
rMWXAP9dzAp5Gzih9wedLKC/AGU0SBlg0TJE6lBprCWHYoWZCQEAvtSNhH+cxsK/
dKSs8G4dOsxJdzMxmOLTJCyQy6jIyAc=
=9/B7
-----END PGP SIGNATURE-----

--BeFzi6ePts3aTjGP--

