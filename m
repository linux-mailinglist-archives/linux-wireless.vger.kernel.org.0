Return-Path: <linux-wireless+bounces-2393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5291839692
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5401F23141
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 17:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A8280032;
	Tue, 23 Jan 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="YRL4Vvvn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13247FBA1
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031600; cv=none; b=ExYEuYGr6oRItLNuWq6d4q5VGYf7cH2qRHc76lt+iG8fyoScWNWB1Oj8QpwBHvfX6Ma9alozweha7X6891JrvIFhL/BTK6piqktOTT0Q2NKZqjuBhxYNTzrsLJdPRz8mnGUyjJqEvu2/QcGKvnDBByRChGx6bJqEcmpVqKYedPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031600; c=relaxed/simple;
	bh=4JC8fiVsdKE2jubm9XMIZTREKPMxOqRPqsFXIUuinG8=;
	h=Message-ID:Subject:From:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:To:Cc; b=Erh7hQMnoSWyZfP0TOjoEQMBgJowbNBj+q07DCSFsULJaMWyESNyiRB8BS7+JKI2n1Kidctj8Fx6y7SV8Dcp1LjzuyDeIKE7LLSdBOSwrtK8LafiPv3Xdqs+XuX18SthJmxg3bsy97CzxBkFl83MAqoFMUTgVhvGXPEEt14C+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=YRL4Vvvn; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=subject:from:in-reply-to:references:content-type:
	content-transfer-encoding:mime-version:to:cc:cc:content-type:from:subject:to;
	s=sgd; bh=olPpQNrjSe2ocX4t3a8rCBMheiPYf786xLY+gSSGAX4=;
	b=YRL4VvvngeXqg36eeiFoor5MznyBqZpv5LLtXlhjM6wivq2ICHrw9vx2EdgRYGPtlUem
	LSzVEQs6dBo0GYB1/HZW0eva/5WCIWf3FtAgoaL4kl2KVlaxUYeI77J6V5EdJcBRx3NWBG
	FdqlmvYNIC7xDG+JJF3sF8T+xexStoe15NKDk1v8agOQnZPkiOU9+OYQQz9Rdd5PcQdVNo
	pFmk5+II9zfdiPvB/FY+385GtieeiyGSM4iwEm5jwo8al1zFMajOJ0AYbDyMVRVZnTvyQN
	vSEl3ZffXSD3iFjs0c3ha8WhylAdmvk2BnPGdZyxO3zoduthW/jZztPADss/n98A==
Received: by recvd-6886bd9456-847bl with SMTP id recvd-6886bd9456-847bl-1-65AFF9ED-E
	2024-01-23 17:39:57.368300247 +0000 UTC m=+11022.515465021
Received: from bixby.lan (unknown)
	by geopod-ismtpd-0 (SG) with ESMTP
	id 73ZvYYpkQquk_24UATH4aA
	Tue, 23 Jan 2024 17:39:57.227 +0000 (UTC)
Message-ID: <b8e8a3f82fe240506e82322a10be7b4e9f218eca.camel@egauge.net>
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
From: David Mosberger-Tang <davidm@egauge.net>
Date: Tue, 23 Jan 2024 17:39:57 +0000 (UTC)
In-Reply-To: <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
References: <20240122211315.1444880-2-davidm@egauge.net>
	 <20240122220350.1449413-1-davidm@egauge.net>
	 <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvN8d63MrpGy8HGW2W?=
 =?us-ascii?Q?zrSO3XUjxDpwTVKVOh5ASkTIZhGhdZ=2FLaALJfQY?=
 =?us-ascii?Q?4LHnLrjW9gOsnFb1gidOpje6TQ8l9jT2Ee3KSP5?=
 =?us-ascii?Q?SAjuIojbU9RSGw8Txc0CoG=2FrnORJjiVQ0OpigyZ?=
 =?us-ascii?Q?1neVUaFKZh7O60ZACDLPU9MzG6a8lakMhebtYRu?=
 =?us-ascii?Q?nKPtOh+RX1cdiEvr4itgA=3D=3D?=
To: Alexis =?iso-8859-1?q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	linux-wireless@vger.kernel.org
Cc: Ajay.Kathat@microchip.com, kvalo@kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==

On Tue, 2024-01-23 at 11:18 +0100, Alexis Lothor=E9 wrote:
> On 1/22/24 23:03, David Mosberger-Tang wrote:
> > Previously, the driver created a net device (typically wlan0) as soon
> > as the module was loaded.  This commit changes the driver to follow
> > normal Linux convention of creating the net device only when bus
> > probing detects a supported chip.
>=20
> I would gladly help review/test the patch, but please give us some time b=
etween
> versions to take a look (even if you can mention if you found issues your=
self).
> Also, each version should be a separate thread, bearing the new version i=
n the
> "Subject" line.
> Additionally (to answer your cover letter), the patches must target the w=
ireless
> branches (likely wireless-testing), not linux-next
> (https://wireless.wiki.kernel.org/en/developers/documentation/git-guide)

Yeah, sorry about that.

> I have a working wilc-over-spi setup with which I can easily unplug the m=
odule,
> so I gave a try to your series, and while the lack of chip detect indeed =
makes
> the netdevice registration not executed, I've got a nasty kasan warning:
>=20
>  driver_probe_device from __driver_attach+0x1a0/0x29c
>=20
>=20
>=20
>                                                  [141/1863]
>  __driver_attach from bus_for_each_dev+0xf0/0x14c
>  bus_for_each_dev from bus_add_driver+0x130/0x288
>  bus_add_driver from driver_register+0xd4/0x1c0
>  driver_register from do_one_initcall+0xfc/0x204
>  do_one_initcall from kernel_init_freeable+0x240/0x2a0
>  kernel_init_freeable from kernel_init+0x20/0x144
>  kernel_init from ret_from_fork+0x14/0x28
> Exception stack(0xc3163fb0 to 0xc3163ff8)
> 3fa0:                                     00000000 00000000 00000000 0000=
0000
> 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>=20
> Allocated by task 1:
>  kasan_set_track+0x3c/0x5c
>  __kasan_kmalloc+0x8c/0x94
>  __kmalloc_node+0x64/0x184
>  kvmalloc_node+0x48/0x114
>  alloc_netdev_mqs+0x68/0x664
>  alloc_etherdev_mqs+0x28/0x34
>  wilc_netdev_ifc_init+0x34/0x37c
>  wilc_cfg80211_init+0x278/0x330
>  wilc_bus_probe+0xb4/0x398
>  spi_probe+0xb8/0xdc
>  really_probe+0x134/0x588
>  __driver_probe_device+0xe0/0x288
>  driver_probe_device+0x60/0x118
>  __driver_attach+0x1a0/0x29c
>  bus_for_each_dev+0xf0/0x14c
>  bus_add_driver+0x130/0x288
>  driver_register+0xd4/0x1c0
>  do_one_initcall+0xfc/0x204
>  kernel_init_freeable+0x240/0x2a0
>  kernel_init+0x20/0x144
>  ret_from_fork+0x14/0x28
>=20
> Freed by task 1:
>  kasan_set_track+0x3c/0x5c
>  kasan_save_free_info+0x30/0x3c
>  __kasan_slab_free+0xe4/0x12c
>  __kmem_cache_free+0x94/0x1cc
>  device_release+0x54/0xf8
>  kobject_put+0xf4/0x238
>  netdev_run_todo+0x414/0x7dc
>  wilc_netdev_cleanup+0xe4/0x244
>  wilc_bus_probe+0x2b8/0x398
>  spi_probe+0xb8/0xdc
>  really_probe+0x134/0x588
>  __driver_probe_device+0xe0/0x288
>  driver_probe_device+0x60/0x118
>  __driver_attach+0x1a0/0x29c
>  bus_for_each_dev+0xf0/0x14c
>  bus_add_driver+0x130/0x288
>  driver_register+0xd4/0x1c0
>  do_one_initcall+0xfc/0x204
>  kernel_init_freeable+0x240/0x2a0
>  kernel_init+0x20/0x144
>  ret_from_fork+0x14/0x28
>=20
> It looks like an already existing/dormant issue in the error-managing pat=
h of
> spi probe of the driver (looks like we are trying to unregister a netdevi=
ce
> which has never been registered ?), but since your series triggers it, it=
 should
> be handled too.

I need help interpreting this.  What does KASAN actually complain about?  A
double free or something else?

register_netdev() does get called (through wilc_cfg80211_init()) and then w=
hen
the chip detect fails, unregister_netdev() gets called (from
wilc_netdev_cleanup()), so I don't see any obvious issues, but there is a l=
ot of
other stuff going on there that I'm not familiar with.

>=20
> > +	}
> > +
> >  	return 0;
> > =20
> >  netdev_cleanup:
> > @@ -1074,58 +1092,43 @@ static int wilc_spi_write(struct wilc *wilc, u3=
2 addr, u8 *buf, u32 size)
> >   *
> >   ********************************************/
> > =20
> > -static int wilc_spi_reset(struct wilc *wilc)
> > +static const char *
> > +strbool(bool val)
>=20
> I am not convinced we need a dedicated helper just to print boolean value=
s (and
> why the super short line break ?)

Sure, I can remove that.

> Also, such change should likely be in a separate patch since it generate =
quite
> some lines of diff but none of those being about the initial topic

Sure, I can rearrange the order of the functions to mimize the size of the =
diff.

> >  {
> > -	struct spi_device *spi =3D to_spi_device(wilc->dev);
> > -	struct wilc_spi *spi_priv =3D wilc->bus_data;
> > -	int result;
> > -
> > -	result =3D wilc_spi_special_cmd(wilc, CMD_RESET);
> > -	if (result && !spi_priv->probing_crc)
> > -		dev_err(&spi->dev, "Failed cmd reset\n");
> > -
> > -	return result;
> > -}
> > -
> > -static bool wilc_spi_is_init(struct wilc *wilc)
> > -{
> > -	struct wilc_spi *spi_priv =3D wilc->bus_data;
> > -
> > -	return spi_priv->isinit;
> > +	return val ? "on" : "off";
> >  }
> > =20
> > -static int wilc_spi_deinit(struct wilc *wilc)
> > +static int wilc_validate_chipid(struct wilc *wilc)
> >  {
> > -	struct wilc_spi *spi_priv =3D wilc->bus_data;
> > +	struct spi_device *spi =3D to_spi_device(wilc->dev);
> > +	u32 chipid, base_id;
> > +	int ret;
> > =20
> > -	spi_priv->isinit =3D false;
> > -	wilc_wlan_power(wilc, false);
> > +	/*
> > +	 * make sure can read chip id without protocol error
> > +	 */
> > +	ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "Fail cmd read chip id...\n");
> > +		return ret;
> > +	}
> > +	base_id =3D chipid & ~WILC_CHIP_REV_FIELD;
> > +	if (base_id !=3D WILC_1000_BASE_ID && base_id !=3D WILC_3000_BASE_ID)=
 {
>=20
> - WILC3000 is currently not supported (yet) by the upstream driver, so th=
ere is
> no reason to validate its presence if we can not handle it later. Any men=
tion of
> it should then be removed from this series

Oh, I didn't realize that.  I was just going off of this web page:

 https://www.microchip.com/en-us/software-library/wilc1000_3000_linux_drive=
r

as I never played with WILC3000.

> - I see that there is already a helper to handle masking and check chip i=
d in
> wlan.c (is_wilc1000). You should likely reuse this/avoid the duplication

Sure, it'll need to be an exported symbol, but other than that, it's fine.

>=20
> > +		dev_err(&spi->dev, "Unknown chip id 0x%x\n", chipid);
> > +		return ret;
> > +	}
> > +	dev_info(&spi->dev, "Detected chip id 0x%x (crc7=3D%s, crc16=3D%s)\n"=
,
> > +		 chipid, strbool(enable_crc7), strbool(enable_crc16));
> >  	return 0;
> >  }
> > =20
> > -static int wilc_spi_init(struct wilc *wilc, bool resume)
> > +static int wilc_spi_configure_bus_protocol(struct wilc *wilc)
> >  {
> >  	struct spi_device *spi =3D to_spi_device(wilc->dev);
> >  	struct wilc_spi *spi_priv =3D wilc->bus_data;
> >  	u32 reg;
> > -	u32 chipid;
> >  	int ret, i;
> > =20
> > -	if (spi_priv->isinit) {
> > -		/* Confirm we can read chipid register without error: */
> > -		ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
> > -		if (ret =3D=3D 0)
> > -			return 0;
> > -
> > -		dev_err(&spi->dev, "Fail cmd read chip id...\n");
> > -	}
> > -
> > -	wilc_wlan_power(wilc, true);
> > -
> > -	/*
> > -	 * configure protocol
> > -	 */
> > -
> >  	/*
> >  	 * Infer the CRC settings that are currently in effect.  This
> >  	 * is necessary because we can't be sure that the chip has
> > @@ -1176,12 +1179,54 @@ static int wilc_spi_init(struct wilc *wilc, boo=
l resume)
> > =20
> >  	spi_priv->probing_crc =3D false;
> > =20
> > -	/*
> > -	 * make sure can read chip id without protocol error
> > -	 */
> > -	ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
> > +	return 0;
> > +}
> > +
> > +static int wilc_spi_reset(struct wilc *wilc)
> > +{
> > +	struct spi_device *spi =3D to_spi_device(wilc->dev);
> > +	struct wilc_spi *spi_priv =3D wilc->bus_data;
> > +	int result;
> > +
> > +	result =3D wilc_spi_special_cmd(wilc, CMD_RESET);
> > +	if (result && !spi_priv->probing_crc)
> > +		dev_err(&spi->dev, "Failed cmd reset\n");
> > +
> > +	return result;
> > +}
> > +
> > +static bool wilc_spi_is_init(struct wilc *wilc)
> > +{
> > +	struct wilc_spi *spi_priv =3D wilc->bus_data;
> > +
> > +	return spi_priv->isinit;
> > +}
> > +
> > +static int wilc_spi_deinit(struct wilc *wilc)
> > +{
> > +	struct wilc_spi *spi_priv =3D wilc->bus_data;
> > +
> > +	spi_priv->isinit =3D false;
> > +	wilc_wlan_power(wilc, false);
> > +	return 0;
> > +}
> > +
> > +static int wilc_spi_init(struct wilc *wilc, bool resume)
> > +{
> > +	struct wilc_spi *spi_priv =3D wilc->bus_data;
> > +	int ret;
> > +
> > +	if (spi_priv->isinit) {
>=20
> Ok, so indeed in this new version of the patch, the flag still makes sens=
e for
> upper layers.
>=20
> > +		/* Confirm we can read chipid register without error: */
> > +		if (wilc_validate_chipid(wilc) =3D=3D 0)
> > +			return 0;
> > +	}
> > +
> > +	wilc_wlan_power(wilc, true);
> > +
> > +	ret =3D wilc_spi_configure_bus_protocol(wilc);
> >  	if (ret) {
> > -		dev_err(&spi->dev, "Fail cmd read chip id...\n");
> > +		wilc_wlan_power(wilc, false);
> >  		return ret;
> >  	}
> > =20
> > diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/n=
et/wireless/microchip/wilc1000/wlan.h
> > index a72cd5cac81d..43dda9f0d9ca 100644
> > --- a/drivers/net/wireless/microchip/wilc1000/wlan.h
> > +++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
> > @@ -182,6 +182,7 @@
> >  #define WILC_CORTUS_BOOT_FROM_IRAM	0x71
> > =20
> >  #define WILC_1000_BASE_ID		0x100000
> > +#define WILC_3000_BASE_ID		0x300000
>=20
> See comment above for WILC3000
>=20
> > =20
> >  #define WILC_1000_BASE_ID_2A		0x1002A0
> >  #define WILC_1000_BASE_ID_2A_REV1	(WILC_1000_BASE_ID_2A + 1)
>=20


