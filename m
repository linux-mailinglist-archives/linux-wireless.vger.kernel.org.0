Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B2A48C282
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 11:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352618AbiALKum (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 05:50:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40238 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352617AbiALKuk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 05:50:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DA29B81DDD
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 10:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E58C36AEA;
        Wed, 12 Jan 2022 10:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641984638;
        bh=WnA4+SPYcWYIlSIPOu/o74UT852UY+tLgfglnQtVtvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vn7cOp6vf1n06lI5WagEG4Hozxrr7+TzdBX6Bz+MdnIAihsrNuT7+9itDE8sizVle
         QZTz4efIYWafhzCH99u+Oq9/ZTDxfgJSZG+8sCXqKu3FAPDDwkFGGi2VqMjbNlwKy3
         ORxLMPFnOuJ6m2n/4eSrTBK5v+AX5BkelYJXJD8O9LslYt2ABZKLNXZIhSAwRS4BeF
         NEXXSKGMJF7/uj5N5edDBM2Ey9dZa7aO34HdNM8+qiy1AAlk24Ncae0VHrnvEAo+us
         J1KB+Jhe69PzoUuzn9hOG0zs5PSdQmvqMASjrPU1HrPict6EVB8DGwI9Pa+ivu8hfn
         tzPBGKXZDl5xQ==
Date:   Wed, 12 Jan 2022 11:50:33 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 4/5] mt76: mt7915: add Kconfig entry for MT7986
Message-ID: <Yd6yeSfSfr8vmXH8@lore-desk>
References: <cover.1641901681.git.Bo.Jiao@mediatek.com>
 <04237351a4cb3b773f68a1cc55d1b8c419ca06a5.1641901681.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cUIPHAJZx8Su6kMc"
Content-Disposition: inline
In-Reply-To: <04237351a4cb3b773f68a1cc55d1b8c419ca06a5.1641901681.git.Bo.Jiao@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--cUIPHAJZx8Su6kMc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ryder Lee <ryder.lee@mediatek.com>
>=20
> This enables building support for the MT7986 SoC built-in WLAN chip.
>=20
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig b/drivers/=
net/wireless/mediatek/mt76/mt7915/Kconfig
> index b8b98cb..8db1ddc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
> @@ -11,3 +11,14 @@ config MT7915E
>  	  OFDMA, spatial reuse and dual carrier modulation.
> =20
>  	  To compile this driver as a module, choose M here.
> +
> +config MT7986_WMAC
> +	bool "MT7986 (SoC) WMAC support"
> +	depends on MT7915E
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select REGMAP
> +	default y
> +	help
> +	  This adds support for the built-in WMAC on MT7986 SoC devices
> +	  which has the same feature set as a MT7915, but enables 6E
> +	  support.
> --=20
> 2.18.0
>=20

I guess this patch should be squashed with 3/5.

Regards,
Lorenzo

--cUIPHAJZx8Su6kMc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYd6yeQAKCRA6cBh0uS2t
rP7tAP9ckSML6Xqbnj0VwMwql7yklkD+AdtlOeUSKmOCm4Ag4wD+OQUkz9+QBq1S
ocrjA+jE6ORPjDw5a5T8FH9+M3+peAs=
=whHq
-----END PGP SIGNATURE-----

--cUIPHAJZx8Su6kMc--
