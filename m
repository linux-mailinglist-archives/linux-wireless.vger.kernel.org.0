Return-Path: <linux-wireless+bounces-12854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D5B97874A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 19:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9251281328
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3139686131;
	Fri, 13 Sep 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Di/JwXmF";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YOL70UOo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from a7-42.smtp-out.eu-west-1.amazonses.com (a7-42.smtp-out.eu-west-1.amazonses.com [54.240.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9227E563;
	Fri, 13 Sep 2024 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250206; cv=none; b=bp2dgdNaSoQFOIXlUKx/rZfNmQY02Okkmebve9soDmhStZO5BGBFGyBsAVUTksXQ5V6ZKnidBu7VHFDGpu+EqGh2R5Qnbuxhlwd00LeWpOqjp6KSYnln1x/YqP7m9GJIjIwYwpM2tYPvPR6sPpn+4Xxckq3xzvZj9BbICWKwkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250206; c=relaxed/simple;
	bh=az4ZktDFrE5TgTvlrcCfwj/RIYM0HEZatbNxSRklh+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmrqI1Cz+OXxTH+xrNgpynG8egLx/AguYsl4Zej2Qn3gF00mTjAiFBVq2fOOOwp8zSRgJuYvYRreENwk2F41GdVbeqaKc3dwe740lP0wlY7bKZwLyr52JTC7pSncKh8D6KdV2jjEWuCCCKzLAvUXx1tJy5lQYczfTh3sqe9KE64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Di/JwXmF; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=YOL70UOo; arc=none smtp.client-ip=54.240.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726250202;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=az4ZktDFrE5TgTvlrcCfwj/RIYM0HEZatbNxSRklh+w=;
	b=Di/JwXmF/SJcAnKO8D6cAL2CBT9am0orNDFrj0txVP6AwtPc2me+4uTL/LpsMuu1
	Xq0757YIlpmmpmAoUcUR7UYBJaIcPRlkTER+CF+F+m8sJdaesgYTDrwl6Qau6l85Qby
	bBQ1g+aOPwfZrfcEMQKBC/XowbkmKQdmhQDx/t1wYuu4IHp6xKHAKhSdE7ve4t8cUSy
	T5bXGJWyy+4c+DIv/Ys90fSzTt2mxAtmGopV5JkHLKnPZOadZ48El4XCeazvcPlK3ZS
	SgJIn9ZcEfSlIlPjL+e1+xXZrGeawpMQALYFvh1SYmt/LcQLDg17+A+b6rOY71MNPtm
	uMIlsEE0yw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726250202;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=az4ZktDFrE5TgTvlrcCfwj/RIYM0HEZatbNxSRklh+w=;
	b=YOL70UOo692aR5WV8EoRAyLS8cUkDZG+3JUOaEHm1ZFKG0NILHBlFcG/MBro5iSt
	RBCZMKSU76gJakfI50VpojoPgFTKBA/57DYt1Enk83SpY90hlrl0rp6TLsdz9UCXn1h
	dH4ja0d3tTRsJBb3KEj5U1YzLF3lzv1pYLdc1C7w=
Date: Fri, 13 Sep 2024 17:56:42 +0000
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, van Spriel <arend@broadcom.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	nick@khadas.com, Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH v14 4/4] wifi: brcmfmac: add flag for random seed during
 firmware download
Message-ID: <01020191ec87b457-619e709d-46d1-4c57-b3df-d4e6fd13db5d-000000@eu-west-1.amazonses.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
 <20240910-wireless-mainline-v14-4-9d80fea5326d@wesion.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zwbcc5564rrrwrd7"
Content-Disposition: inline
In-Reply-To: <20240910-wireless-mainline-v14-4-9d80fea5326d@wesion.com>
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.13-54.240.7.42


--zwbcc5564rrrwrd7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 11:04:14AM GMT, Jacobe Zang wrote:
> Providing the random seed to firmware was tied to the fact that the
> device has a valid OTP, which worked for some Apple chips. However,
> it turns out the BCM43752 device also needs the random seed in order
> to get firmware running. Suspect it is simply tied to the firmware
> branch used for the device. Introducing a mechanism to allow setting
> it for a device through the device table.
>=20
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com> # On RK3588 =
EVB1

Greetings,

-- Sebastian

>  .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 52 ++++++++++++++++=
++----
>  .../broadcom/brcm80211/include/brcm_hw_ids.h       |  2 +
>  2 files changed, 46 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 190e8990618c5..c0fdaa4dceda4 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -66,6 +66,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
>  BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
>  BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
>  BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
> +BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
>  BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
>  BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
>  BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
> @@ -104,6 +105,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie=
_fwnames[] =3D {
>  	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
>  	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
>  	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
> +	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
>  	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision I=
D 4 */
>  	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision I=
D 3 */
>  	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision I=
D 5 */
> @@ -353,6 +355,7 @@ struct brcmf_pciedev_info {
>  			  u16 value);
>  	struct brcmf_mp_device *settings;
>  	struct brcmf_otp_params otp;
> +	bool fwseed;
>  #ifdef DEBUG
>  	u32 console_interval;
>  	bool console_active;
> @@ -1715,14 +1718,14 @@ static int brcmf_pcie_download_fw_nvram(struct br=
cmf_pciedev_info *devinfo,
>  		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
>  		brcmf_fw_nvram_free(nvram);
> =20
> -		if (devinfo->otp.valid) {
> +		if (devinfo->fwseed) {
>  			size_t rand_len =3D BRCMF_RANDOM_SEED_LENGTH;
>  			struct brcmf_random_seed_footer footer =3D {
>  				.length =3D cpu_to_le32(rand_len),
>  				.magic =3D cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
>  			};
> =20
> -			/* Some Apple chips/firmwares expect a buffer of random
> +			/* Some chips/firmwares expect a buffer of random
>  			 * data to be present before NVRAM
>  			 */
>  			brcmf_dbg(PCIE, "Download random seed\n");
> @@ -2394,6 +2397,37 @@ static void brcmf_pcie_debugfs_create(struct devic=
e *dev)
>  }
>  #endif
> =20
> +struct brcmf_pcie_drvdata {
> +	enum brcmf_fwvendor vendor;
> +	bool fw_seed;
> +};
> +
> +enum {
> +	BRCMF_DRVDATA_CYW,
> +	BRCMF_DRVDATA_BCA,
> +	BRCMF_DRVDATA_WCC,
> +	BRCMF_DRVDATA_WCC_SEED,
> +};
> +
> +static const struct brcmf_pcie_drvdata drvdata[] =3D {
> +	[BRCMF_DRVDATA_CYW] =3D {
> +		.vendor =3D BRCMF_FWVENDOR_CYW,
> +		.fw_seed =3D false,
> +	},
> +	[BRCMF_DRVDATA_BCA] =3D {
> +		.vendor =3D BRCMF_FWVENDOR_BCA,
> +		.fw_seed =3D false,
> +	},
> +	[BRCMF_DRVDATA_WCC] =3D {
> +		.vendor =3D BRCMF_FWVENDOR_WCC,
> +		.fw_seed =3D false,
> +	},
> +	[BRCMF_DRVDATA_WCC_SEED] =3D {
> +		.vendor =3D BRCMF_FWVENDOR_WCC,
> +		.fw_seed =3D true,
> +	},
> +};
> +
>  /* Forward declaration for pci_match_id() call */
>  static const struct pci_device_id brcmf_pcie_devid_table[];
> =20
> @@ -2475,9 +2509,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struc=
t pci_device_id *id)
>  	bus->bus_priv.pcie =3D pcie_bus_dev;
>  	bus->ops =3D &brcmf_pcie_bus_ops;
>  	bus->proto_type =3D BRCMF_PROTO_MSGBUF;
> -	bus->fwvid =3D id->driver_data;
>  	bus->chip =3D devinfo->coreid;
>  	bus->wowl_supported =3D pci_pme_capable(pdev, PCI_D3hot);
> +	bus->fwvid =3D drvdata[id->driver_data].vendor;
> +	devinfo->fwseed =3D drvdata[id->driver_data].fw_seed;
>  	dev_set_drvdata(&pdev->dev, bus);
> =20
>  	ret =3D brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
> @@ -2663,14 +2698,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm =
=3D {
>  		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
>  		PCI_ANY_ID, PCI_ANY_ID, \
>  		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
> -		BRCMF_FWVENDOR_ ## fw_vend \
> +		BRCMF_DRVDATA_ ## fw_vend \
>  	}
>  #define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
>  	{ \
>  		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
>  		(subvend), (subdev), \
>  		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
> -		BRCMF_FWVENDOR_ ## fw_vend \
> +		BRCMF_DRVDATA_ ## fw_vend \
>  	}
> =20
>  static const struct pci_device_id brcmf_pcie_devid_table[] =3D {
> @@ -2698,9 +2733,10 @@ static const struct pci_device_id brcmf_pcie_devid=
_table[] =3D {
>  	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
>  	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
>  	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
> -	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
> -	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
> -	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
> +	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
> =20
>  	{ /* end: all zeroes */ }
>  };
> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.=
h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> index 44684bf1b9acc..c1e22c589d85e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> @@ -52,6 +52,7 @@
>  #define BRCM_CC_43664_CHIP_ID		43664
>  #define BRCM_CC_43666_CHIP_ID		43666
>  #define BRCM_CC_4371_CHIP_ID		0x4371
> +#define BRCM_CC_43752_CHIP_ID		43752
>  #define BRCM_CC_4377_CHIP_ID		0x4377
>  #define BRCM_CC_4378_CHIP_ID		0x4378
>  #define BRCM_CC_4387_CHIP_ID		0x4387
> @@ -94,6 +95,7 @@
>  #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
>  #define BRCM_PCIE_4371_DEVICE_ID	0x440d
>  #define BRCM_PCIE_43596_DEVICE_ID	0x4415
> +#define BRCM_PCIE_43752_DEVICE_ID	0x449d
>  #define BRCM_PCIE_4377_DEVICE_ID	0x4488
>  #define BRCM_PCIE_4378_DEVICE_ID	0x4425
>  #define BRCM_PCIE_4387_DEVICE_ID	0x4433
>=20
> --=20
> 2.34.1
>=20
>=20

--zwbcc5564rrrwrd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbkfNgACgkQ2O7X88g7
+pq7OQ/+IdJA2aA8tgY4+FH+WP79mRil3jqsbZUoHSD74mEMrRuB/2RY2Mbq6B9H
xPNo8Z7pCT01rZBr5ibXbk3MtJjmo5lqEQYtAH+TH7AgUisqIHIVyQEXFRswibQC
IePUgrgW4T8fNyJbfwuuUy+x6ajfTmRkIpMwNLq6cd7X4m2ayeVsWjZvKSmh59U5
5UDhNvY4QJbVkyBV5fXvwagIukZGLXZ9uhjo/JIKubPOCVTTEFbxNB7ZFkA+gTzO
48+hcg7BK/fN/Qb0Eb81VIMG1koSx1h5q9EkHowyyLNrWzs0R+N9sq41HvbYNvY5
IfUWPiagradIY5JyiOfibk0xKlb64j0nZ1er1GaD6EJmQVRhh7KRBoMX0xQGcn0K
4YCAWmDcMhz303cLJkSIQSaF4Oj6ioF9ZGxAHuyz7C2QhqFPWRljzQ3oX8paDXaj
mKwGvVDE528jtgpHB3MC9+EnnyjyQjO4vyeyYhqFrUNu23su76xivdYTJmnrikCH
WDAETRO/RFBA6Z5b8q83C2kM36HIvgkNtwLb1tu+gcQ+94F0ymhzP7v4pLOQ09KJ
XA47mMSvf2u5nqQNkSb37x4xfG2znVDEE8dsQ7TU+5QT3tII4EXKSWz8HBflDZ5r
4PIfFHb+x5UpTNuFRvwikuYSzjUAwDVRg8T+PQ6WoSkCWsErP+A=
=fYCg
-----END PGP SIGNATURE-----

--zwbcc5564rrrwrd7--

