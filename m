Return-Path: <linux-wireless+bounces-28843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978BFC4E478
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 15:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37564189D248
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E435B147;
	Tue, 11 Nov 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oib/AhSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B2335B13D;
	Tue, 11 Nov 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869614; cv=none; b=gUCLyJfhpNvSNOKhJnn6ffPxlRKbmEstFJxpMUxZ8OT9qDmPxBkfB2gQhHfR/1cgscb2oIYglsmK0nf9LYuteGP2xY3bUJS4vS7YQqok8Au3xnJJ2cmVgmKttXYtOMFiOp1RGnrKXCQ0A7pt1Hwn8EQJ0DZ+FawiYHsOBJ/9gLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869614; c=relaxed/simple;
	bh=pKGxohOsLQcLsOLtFArzxf1WdF08CEmoONSvXjw76To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVwR0OlI8++61OvoK5G6CqUDWBHqCldkjG1x5H9OVCgTZwkl9kLrm/dLsfIp5qRwNvoKxnN/fTtHqdQWc/tmP4VETfopTXqZ+JsLXUSaq+zyPftPPDYbCboaMe7S/mvu7lzmMaUy1DNvblcZPI5WtqwFEBnbsGU8mYxtLPBIGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oib/AhSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF0FC4CEF5;
	Tue, 11 Nov 2025 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762869613;
	bh=pKGxohOsLQcLsOLtFArzxf1WdF08CEmoONSvXjw76To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oib/AhSC+LENxt8l6cfvQXi0qe80vMq1BhrYRxNQbXErF+crW6yJqXAhNpM1///Uz
	 HlPs27FoW2v5V53Fq2sjR5VQejrwefP8RtU42ti9vYEa2rLxPgIfPE7ANItwOm83cq
	 Tw7/Ou2UnC5MPPX7juv5eZLEHdM34Sq1UH9P4gJodqwEwYn3uBgB+qPbd0BImwAbFm
	 2f/DT0v3SsWwu51mTIFjFyzo3VwMR98Q/ee9WysUTC4kKNMwZtouEJR3LtoBZ7qpar
	 /w1T3yW1hrCrjGmQFIkmVne2W9gRdc++8c+SSd84P9sXXbEXboEWjd8tPbmvuOavGb
	 Juu3kXKCzsjfw==
Date: Tue, 11 Nov 2025 15:00:10 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Nick Huang <sef1548@gmail.com>
Cc: nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
	sean.wang@mediatek.com, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: connac: remove unused reserved field in gtk rekey
 TLV struct
Message-ID: <aRNBak9Xl_wsBJ6w@lore-desk>
References: <20251111134400.5258-1-sef1548@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3NAqLAM4O8sK+KAA"
Content-Disposition: inline
In-Reply-To: <20251111134400.5258-1-sef1548@gmail.com>


--3NAqLAM4O8sK+KAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The 'reserverd' field in struct mt76_connac_gtk_rekey_tlv was unused
> and misspelled. Removing it cleans up the structure definition and
> improves code readability.
>=20
> Signed-off-by: Nick Huang <sef1548@gmail.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index 27daf4195..28cf46a5f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1681,7 +1681,6 @@ struct mt76_connac_gtk_rekey_tlv {
>  	__le32 group_cipher;
>  	__le32 key_mgmt; /* NONE-PSK-IEEE802.1X */
>  	__le32 mgmt_group_cipher;
> -	u8 reserverd[4];

This field is used to keep the struct size consistent with the fw one so it=
 is
expected to not be used.

Regards,
Lorenzo

>  } __packed;
> =20
>  #define MT76_CONNAC_WOW_MASK_MAX_LEN			16
> --=20
> 2.48.1
>=20

--3NAqLAM4O8sK+KAA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaRNBagAKCRA6cBh0uS2t
rA8XAP92QWJ628UHuby2jMHAqObl3TqsYz3L5+Sblh+15y/FRQEAsXhgZSpVvlhm
LMdSaMTBNy4ja/h10Tz9E+eYjURNTgc=
=pcBD
-----END PGP SIGNATURE-----

--3NAqLAM4O8sK+KAA--

