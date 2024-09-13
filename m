Return-Path: <linux-wireless+bounces-12853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3717978744
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 19:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D491BB23C70
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE8A12C465;
	Fri, 13 Sep 2024 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BCqFh9sI";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="NKPDIjSs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from a7-48.smtp-out.eu-west-1.amazonses.com (a7-48.smtp-out.eu-west-1.amazonses.com [54.240.7.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D438F6A;
	Fri, 13 Sep 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250066; cv=none; b=iTmqwV8SP/QiCe24+Cte9+UySaQ7vLH4tQGo4w0nGvFN1d3/Op92hUBehPbZDjWAhfq0gU2GbmcRwUlmEaPZWDnzMSCZAcAvVlqsUUD07j2QIwiEBx9satcSpMt1IBzSy0Ytn1KCr3Ax6hkEGXzfy59kZyEqRayNBSf2j7VAo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250066; c=relaxed/simple;
	bh=v5nhcMbhFvs+wOS+fVmcrdClTmYxd97t3TBuVoJB04g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IavdeoztQrLkVcb6LfEDhtu5UBljilQeNKdMF7i+eNXQ+k7cShGoFZS+9SLutrKvTGvCWvjZ/HRu9z49Ie6vyS/TmuvRNWadUpAVTPoornZjXffYLjm7I8423Z9cpZTuCIAktDLN59nBE+XzKJK8B1sALFJmbloiCTfbLtuP+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BCqFh9sI; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=NKPDIjSs; arc=none smtp.client-ip=54.240.7.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726250062;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=v5nhcMbhFvs+wOS+fVmcrdClTmYxd97t3TBuVoJB04g=;
	b=BCqFh9sI5HeW31L31NnuxytM02DvOJS0nlTzxXNOu3Hqa6WwoxNKZVRebSwzB/C+
	jmQXCFgUlg+pkFMNiPhZCHQmJD5am+jSQ3K10+k7MXzQs4MvTRcHw6l9C+nKwHxwZyv
	S3bbMljl4WYEKlNIHlNiKYAzw7ywMJmRePXa2foK0/2SddIWzVSU5Uq8QbVu2TPkiXv
	PGlVYMVPBDz/28SbX2nkrAVJBw0JNWXJEzDYDCdP6aVfG363i2ee3Wmwr0lK+A7lfZa
	H12ZdhGZsjtQ1KoVhHpjXMrQRVPGCXLf9EgIHfwolWyjdADukgs47h41iF3NIClexw9
	R/gqHP5l3w==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726250062;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=v5nhcMbhFvs+wOS+fVmcrdClTmYxd97t3TBuVoJB04g=;
	b=NKPDIjSsifDQBwVQ8HYsuBfC+0decN8grAa6F1ftTxxs5EJvWA+27I7W/li33ego
	OhFzk7YydUXJRU2P3UJnzzKu4EFbyvKLM2tyegQnfpQnE5yOI5AXSMqPJKDrerazk7e
	vQa4b5Hrg4Po3yh+G46o9alsNgn0tXhY70Cf2PKM=
Date: Fri, 13 Sep 2024 17:54:22 +0000
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
	nick@khadas.com, Ondrej Jirman <megi@xff.cz>, 
	Sai Krishna <saikrishnag@marvell.com>
Subject: Re: [PATCH v14 3/4] wifi: brcmfmac: Add optional lpo clock enable
 support
Message-ID: <01020191ec859278-672a5f9e-d8c5-4e0c-a319-7208f95580a0-000000@eu-west-1.amazonses.com>
References: <20240910-wireless-mainline-v14-0-9d80fea5326d@wesion.com>
 <20240910-wireless-mainline-v14-3-9d80fea5326d@wesion.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lrsqblrh4qi5cddb"
Content-Disposition: inline
In-Reply-To: <20240910-wireless-mainline-v14-3-9d80fea5326d@wesion.com>
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.13-54.240.7.48


--lrsqblrh4qi5cddb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 11:04:13AM GMT, Jacobe Zang wrote:
> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> to the top of brcmf_of_probe. Change function prototypes from void
> to int and add appropriate errno's for return values that will be
> send to bus when error occurred.
>=20
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com> # On RK3588 =
EVB1

Greetings,

-- Sebastian

>  .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  4 ++--
>  .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  3 ++-
>  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  | 25 ++++++++++++++++=
------
>  .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |  9 ++++----
>  .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  3 +++
>  .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 22 ++++++++++++----=
---
>  .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |  3 +++
>  7 files changed, 47 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index d35262335eaf7..17f6b33beabd8 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
> =20
>  	/* try to attach to the target device */
>  	sdiodev->bus =3D brcmf_sdio_probe(sdiodev);
> -	if (!sdiodev->bus) {
> -		ret =3D -ENODEV;
> +	if (IS_ERR(sdiodev->bus)) {
> +		ret =3D PTR_ERR(sdiodev->bus);
>  		goto out;
>  	}
>  	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/=
drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> index b24faae35873d..58d50918dd177 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> @@ -561,7 +561,8 @@ struct brcmf_mp_device *brcmf_get_module_param(struct=
 device *dev,
>  	if (!found) {
>  		/* No platform data for this device, try OF and DMI data */
>  		brcmf_dmi_probe(settings, chip, chiprev);
> -		brcmf_of_probe(dev, bus_type, settings);
> +		if (brcmf_of_probe(dev, bus_type, settings) =3D=3D -EPROBE_DEFER)
> +			return ERR_PTR(-EPROBE_DEFER);
>  		brcmf_acpi_probe(dev, bus_type, settings);
>  	}
>  	return settings;
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> index fe4f657561056..6d90be9529012 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> @@ -6,6 +6,7 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_net.h>
> +#include <linux/clk.h>
> =20
>  #include <defs.h>
>  #include "debug.h"
> @@ -65,12 +66,13 @@ static int brcmf_of_get_country_codes(struct device *=
dev,
>  	return 0;
>  }
> =20
> -void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> -		    struct brcmf_mp_device *settings)
> +int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> +		   struct brcmf_mp_device *settings)
>  {
>  	struct brcmfmac_sdio_pd *sdio =3D &settings->bus.sdio;
>  	struct device_node *root, *np =3D dev->of_node;
>  	struct of_phandle_args oirq;
> +	struct clk *clk;
>  	const char *prop;
>  	int irq;
>  	int err;
> @@ -106,7 +108,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bu=
s_type bus_type,
>  		board_type =3D devm_kstrdup(dev, tmp, GFP_KERNEL);
>  		if (!board_type) {
>  			of_node_put(root);
> -			return;
> +			return 0;
>  		}
>  		strreplace(board_type, '/', '-');
>  		settings->board_type =3D board_type;
> @@ -114,8 +116,15 @@ void brcmf_of_probe(struct device *dev, enum brcmf_b=
us_type bus_type,
>  		of_node_put(root);
>  	}
> =20
> +	clk =3D devm_clk_get_optional_enabled(dev, "lpo");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	brcmf_dbg(INFO, "%s LPO clock\n", clk ? "enable" : "no");
> +	clk_set_rate(clk, 32768);
> +
>  	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
> -		return;
> +		return 0;
> =20
>  	err =3D brcmf_of_get_country_codes(dev, settings);
>  	if (err)
> @@ -124,23 +133,25 @@ void brcmf_of_probe(struct device *dev, enum brcmf_=
bus_type bus_type,
>  	of_get_mac_address(np, settings->mac);
> =20
>  	if (bus_type !=3D BRCMF_BUSTYPE_SDIO)
> -		return;
> +		return 0;
> =20
>  	if (of_property_read_u32(np, "brcm,drive-strength", &val) =3D=3D 0)
>  		sdio->drive_strength =3D val;
> =20
>  	/* make sure there are interrupts defined in the node */
>  	if (of_irq_parse_one(np, 0, &oirq))
> -		return;
> +		return 0;
> =20
>  	irq =3D irq_create_of_mapping(&oirq);
>  	if (!irq) {
>  		brcmf_err("interrupt could not be mapped\n");
> -		return;
> +		return 0;
>  	}
>  	irqf =3D irqd_get_trigger_type(irq_get_irq_data(irq));
> =20
>  	sdio->oob_irq_supported =3D true;
>  	sdio->oob_irq_nr =3D irq;
>  	sdio->oob_irq_flags =3D irqf;
> +
> +	return 0;
>  }
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
> index 10bf52253337e..ae124c73fc3b7 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
> @@ -3,11 +3,12 @@
>   * Copyright (c) 2014 Broadcom Corporation
>   */
>  #ifdef CONFIG_OF
> -void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> -		    struct brcmf_mp_device *settings);
> +int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> +		   struct brcmf_mp_device *settings);
>  #else
> -static void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_t=
ype,
> -			   struct brcmf_mp_device *settings)
> +static int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_ty=
pe,
> +			  struct brcmf_mp_device *settings)
>  {
> +	return 0;
>  }
>  #endif /* CONFIG_OF */
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index ce482a3877e90..190e8990618c5 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -2452,6 +2452,9 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct=
 pci_device_id *id)
>  		ret =3D -ENOMEM;
>  		goto fail;
>  	}
> +	ret =3D PTR_ERR_OR_ZERO(devinfo->settings);
> +	if (ret < 0)
> +		goto fail;
> =20
>  	bus =3D kzalloc(sizeof(*bus), GFP_KERNEL);
>  	if (!bus) {
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 1461dc453ac22..a9b4d560cbfc7 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -3943,7 +3943,7 @@ static const struct brcmf_buscore_ops brcmf_sdio_bu=
score_ops =3D {
>  	.write32 =3D brcmf_sdio_buscore_write32,
>  };
> =20
> -static bool
> +static int
>  brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
>  {
>  	struct brcmf_sdio_dev *sdiodev;
> @@ -3953,6 +3953,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
>  	u32 reg_val;
>  	u32 drivestrength;
>  	u32 enum_base;
> +	int ret =3D -EBADE;
> =20
>  	sdiodev =3D bus->sdiodev;
>  	sdio_claim_host(sdiodev->func1);
> @@ -4001,8 +4002,9 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
>  						   BRCMF_BUSTYPE_SDIO,
>  						   bus->ci->chip,
>  						   bus->ci->chiprev);
> -	if (!sdiodev->settings) {
> +	if (IS_ERR_OR_NULL(sdiodev->settings)) {
>  		brcmf_err("Failed to get device parameters\n");
> +		ret =3D PTR_ERR_OR_ZERO(sdiodev->settings);
>  		goto fail;
>  	}
>  	/* platform specific configuration:
> @@ -4071,7 +4073,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
>  	/* allocate header buffer */
>  	bus->hdrbuf =3D kzalloc(MAX_HDR_READ + bus->head_align, GFP_KERNEL);
>  	if (!bus->hdrbuf)
> -		return false;
> +		return -ENOMEM;
>  	/* Locate an appropriately-aligned portion of hdrbuf */
>  	bus->rxhdr =3D (u8 *) roundup((unsigned long)&bus->hdrbuf[0],
>  				    bus->head_align);
> @@ -4082,11 +4084,11 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
>  	if (bus->poll)
>  		bus->pollrate =3D 1;
> =20
> -	return true;
> +	return 0;
> =20
>  fail:
>  	sdio_release_host(sdiodev->func1);
> -	return false;
> +	return ret;
>  }
> =20
>  static int
> @@ -4451,8 +4453,10 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_s=
dio_dev *sdiodev)
> =20
>  	/* Allocate private bus interface state */
>  	bus =3D kzalloc(sizeof(*bus), GFP_ATOMIC);
> -	if (!bus)
> +	if (!bus) {
> +		ret =3D -ENOMEM;
>  		goto fail;
> +	}
> =20
>  	bus->sdiodev =3D sdiodev;
>  	sdiodev->bus =3D bus;
> @@ -4467,6 +4471,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sd=
io_dev *sdiodev)
>  				     dev_name(&sdiodev->func1->dev));
>  	if (!wq) {
>  		brcmf_err("insufficient memory to create txworkqueue\n");
> +		ret =3D -ENOMEM;
>  		goto fail;
>  	}
>  	brcmf_sdiod_freezer_count(sdiodev);
> @@ -4474,7 +4479,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sd=
io_dev *sdiodev)
>  	bus->brcmf_wq =3D wq;
> =20
>  	/* attempt to attach to the dongle */
> -	if (!(brcmf_sdio_probe_attach(bus))) {
> +	ret =3D brcmf_sdio_probe_attach(bus);
> +	if (ret < 0) {
>  		brcmf_err("brcmf_sdio_probe_attach failed\n");
>  		goto fail;
>  	}
> @@ -4546,7 +4552,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sd=
io_dev *sdiodev)
> =20
>  fail:
>  	brcmf_sdio_remove(bus);
> -	return NULL;
> +	return ERR_PTR(ret);
>  }
> =20
>  /* Detach and free everything */
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/dri=
vers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> index 8afbf529c7450..2821c27f317ee 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> @@ -1272,6 +1272,9 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_i=
nfo *devinfo,
>  		ret =3D -ENOMEM;
>  		goto fail;
>  	}
> +	ret =3D PTR_ERR_OR_ZERO(devinfo->settings);
> +	if (ret < 0)
> +		goto fail;
> =20
>  	if (!brcmf_usb_dlneeded(devinfo)) {
>  		ret =3D brcmf_alloc(devinfo->dev, devinfo->settings);
>=20
> --=20
> 2.34.1
>=20
>=20

--lrsqblrh4qi5cddb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbkfEwACgkQ2O7X88g7
+pq3Kw/9H8DXJ0rDkadHRCyfGdAK794X4LIJsYyNkiBnu/Q/SDZYmJLb9BiNZT/w
oe4DMN0xuUpZVCvIDITGmtaltp3bWz2whVkII2Phb/XSkI5LHKyn3em2pUplEwaw
+u3/Q0Ilii3/Z13Shc1BBmZKey+tM5gr9iZfyBGEntb5nXt+vFgB/gRRvxviFcs0
TZKm33rNV6n5U1eF3OPAjj8fohHbzgB7rdAqpmP/3gd+7sIRIc4HT/b3vumxCszl
wp2BvWbPD8EswFXGeAOCA6sDDwXDNhJRcKQpobU8zXzUWqb55/Qik716SsoDFsXD
28H5Rebodd3FBHyjIumZ1w1lrRjeT0Hvt+BsG3b5giwksodekCmpcRb/QBu/3HlH
EVqNvJWXKUUOdXxkd1PATO3m3JbywUyDTqLkv9sm9pb07leH+KXxkAJVElIDpaXv
5Sc12761JylXwMcGIyFK3N5x6+fPzybyFgS3B0VT7ev4M5SaasfvlPK8JYkbUOFS
MhP8vkJ70k5F/caOmW7lV1XaYktYMHPA4CQMNDk6TuWqVvns+7BJqfWZtyFSzhhy
x7heAYFFlW38pTLvYDDky+cxsi4DNZ60pBqeRFdjnIOyeAAc+JZAo8Uz3cYYPfMF
yNp4aqlfre/H8cgQWrh/mUryQgOoXOiB2UEk58ABZAj4aCHeZvY=
=AN9W
-----END PGP SIGNATURE-----

--lrsqblrh4qi5cddb--

