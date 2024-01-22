Return-Path: <linux-wireless+bounces-2347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9F083740F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 21:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEC11F2998D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 20:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE13540BE2;
	Mon, 22 Jan 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="aFk0COJI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C8405C1
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956069; cv=none; b=Xv0yTzgETPue7OVqhFrHJadr9n/bKDaK307B9XnV1lWwzDdZrR7ZWmmfm08PRo/cUsAQ/wpeyNv/TaV8WwZsPi0TbZn6UrV3VL3MkN1MuaSkULROXNSrWT4mA8wTSVFlb0HE7eNMToco+6i7AaT9byf90Jka3+NbQnElWFnMmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956069; c=relaxed/simple;
	bh=3H5OsgFy6eUbE0jFSEmh85YggYZhC2/wHkWks6Ei/n4=;
	h=Message-ID:Subject:From:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:To:Cc; b=saScweSmu73CDfMK0KHAJyNuFHNLlN/uBIVSRPwDp5oZWcjZn4bxpnwxjlKKp1L3ILU5cSbMNT/7ooN0ql4JJzbNJqk3EyvMxCbetd09XPpoAXhZL5fY3VoP7skckqSuIXG/2Nb32PP551moZDcnUFLF31PHfb7K7jwyE2+zwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=aFk0COJI; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=subject:from:in-reply-to:references:content-type:
	content-transfer-encoding:mime-version:to:cc:cc:content-type:from:subject:to;
	s=sgd; bh=K1ziDB3rOnVMhr0/Ehln8zg81uMjGuiPdnAT871BJ3A=;
	b=aFk0COJIF9+Sdu1ikGbcp62OoBVcGiTVNWkFIxo4dEbInZoPTc38QDq/cyhvZg0CCC2J
	XA7HdMn3qlc8A0YwC/BMQhJBnsUJQejebB8cxCqejZajVaGJ+XYKrx6dUQCvN9oG8RNaVy
	mekzK6Pc1o8JWFq67AFIHBuyZAM2q7uS4NsoDF09BQKUy6LOPy5oWQ1dOD8vpuug6CkBXz
	4BdntsDxOamTJPR2VWk7s9p4ProooxLPyw+q8G8mP9y+1NsHPzvp9V0y1JydAcvsdVvTR/
	FIzJhGv9L/sIeaqkhrRK5nd/CKPBk1WH/7sWydfvVBrMIPdOUdzZYUeDJrLiGjug==
Received: by filterdrecv-5bbdbb56cd-svthp with SMTP id filterdrecv-5bbdbb56cd-svthp-1-65AED2E1-30
        2024-01-22 20:41:05.933809871 +0000 UTC m=+977049.920352849
Received: from bixby.lan (unknown)
	by geopod-ismtpd-21 (SG) with ESMTP
	id KUfRk8PvTXe4O8A8H2h-sA
	Mon, 22 Jan 2024 20:41:05.704 +0000 (UTC)
Message-ID: <5ff15ae65ccb7c144ba8e0f07dc2ac25bd8b2b42.camel@egauge.net>
Subject: Re: RFQ: wifi: wilc1000: make wilc1000-spi bus-probe useful
From: David Mosberger-Tang <davidm@egauge.net>
Date: Mon, 22 Jan 2024 20:41:06 +0000 (UTC)
In-Reply-To: <e17d654a-8bd5-4327-8bf2-ad81c2f7355b@bootlin.com>
References: <90fb762e5840f9d5a6ae46f81692fb947a7796a4.camel@egauge.net>
	 <e17d654a-8bd5-4327-8bf2-ad81c2f7355b@bootlin.com>
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
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvAvxhPqjf0xfaFL0i?=
 =?us-ascii?Q?HX=2FWOjjUvYJlfz07BVUVIwA7RT6patTo+BqBMhR?=
 =?us-ascii?Q?uCR=2Fm5rErncCs0V7CkwmFQkDhx=2F4lZOzjKpLyzO?=
 =?us-ascii?Q?7keSANXfRZMzjveEMq1jc60l8PhT7w+7NZZJ8Oo?=
 =?us-ascii?Q?DmrkbSi72P2AHkCDTxLVZVQvEydUV53+MTte0Mu?=
 =?us-ascii?Q?ZwPUVqjfkiaz4cRoSmNFw=3D=3D?=
To: Alexis =?iso-8859-1?q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Ajay.Kathat@microchip.com
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==

Alexis,

Thanks for your feedback!

On Mon, 2024-01-22 at 15:19 +0100, Alexis Lothor=E9 wrote:
> Hello,
>=20
> On 1/19/24 22:51, David Mosberger-Tang wrote:
> > The current version of the wilc1000 driver has a probe function that si=
mply
> > assumes the chip is present. It is only later, in wilc_spi_init(), that=
 the
> > driver verifies that it can actually communicate with the chip. The res=
ult of
> > this is that the net device (typically wlan0) is created and remains in=
 place as
> > long as the wilc1000-spi driver is loaded, even if the WILC1000 chip is=
 not
> > present or not working.
> >=20
> > Is there any reason not to detect the chip's present in wilc_bus_probe(=
)? The
> > patch below (relative to 5.15.147) works for me, but perhaps I'm missin=
g
> > something? Would it make sense to merge something along these lines int=
o
> > mainline?
>=20
> The general statement sounds relevant to me, it looks not so useful to re=
gister
> the corresponding netdevice if we can not even detect the chip at probe t=
ime.
> I have a series under work which, by "side effect", accomplishes the same=
 kind
> of detection: it aims to fix faulty mac address (00:00:00:00:00:00) which=
 is set
> correctly only after interface has been brought up.

Ahh, that sounds like another useful improvement!

> The series tries to read the
> mac address from NV memory right at probe time. If it fails, it can make =
the
> probe procedure fail and not register the wireless device. Nonetheless,
> validating chip presence with chip id sounds better than with mac address=
 from
> NV memory.

Great!  I'll send an update patch soon (properly formatted this time, I
hope...).

> Aside from that, I have a few more specific comments below
>=20
> >=20
> >  --david
> >=20
> > diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c
>=20
> [...]
>=20
> > + /* we need power to configure the bus protocol and to read the chip i=
d: */
> > +
> > + wilc_wlan_power(wilc, true);
> > +
> > + ret =3D wilc_spi_configure_bus_protocol(wilc);
> > +
> > + wilc_wlan_power(wilc, false);
> > +
> > + if (ret) {
> > + ret =3D -ENODEV;
>=20
> I would keep wilc_spi_configure_bus_protocol original error instead of
> rewriting/forcing it to -ENODEV here. I mean, if something fails in
> wilc_spi_configure_bus_protocol but not right at the first attempt to
> communicate with the chip, it does not translate automatically to an abse=
nce of
> chip, right ?

Hmmh, I'm happy to change it, but, as it happens, all failure returns in
wilc_spi_configure_bus_protocol() basically mean that the device isn't pres=
ent
or a device is present which the driver doesn't support, so I think -ENODEV=
 is
more useful than returning -EINVAL (as would be the case).  Let me know if =
you
still think I should change it.

In the new patch, I broke out the chipid validation code into its own funct=
ion
since it felt wrong to do that in a function called "configure bus protocol=
".

> > + goto netdev_cleanup;
> > + }
> > +
> >  return 0;
> >  netdev_cleanup:
>=20
> [...]
>=20
> > @@ -1187,16 +1189,38 @@ static int wilc_spi_init(struct wilc *wilc, boo=
l resume)
> >  ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
> >  if (ret) {
> >  dev_err(&spi->dev, "Fail cmd read chip id...\n");
> > - goto fail;
> > + return ret;
> > + }
> > + return 0;
> > +}
> > +
> > +static int wilc_spi_init(struct wilc *wilc, bool resume)
> > +{
> > + struct spi_device *spi =3D to_spi_device(wilc->dev);
> > + struct wilc_spi *spi_priv =3D wilc->bus_data;
> > + u32 chipid;
> > + int ret;
> > +
> > + if (spi_priv->isinit) {
> > + /* Confirm we can read chipid register without error: */
> > + ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
> > + if (ret =3D=3D 0)
> > + return 0;
> > +
> > + dev_err(&spi->dev, "Fail cmd read chip id...\n");
> > + }
> > +
> > + wilc_wlan_power(wilc, true);
>=20
> I guess something will break here. This updates now mark the chip as init=
ialized
> (sp_priv->isinit) at probe time, but unpower the chip before finishing pr=
obe, so
> this wilc_wlan_power(wilc, true) needs more likely to be called earlier i=
n
> wilc_spi_init (ie: before trying to read again the chip id).

Oh, no that's definitely not the intention.  The garbled formatting makes
reading the patch more confusing than it should be, but isinit still gets s=
et in
wilc_spi_init(), not in wilc_bus_probe().  That is the reason I had to upda=
te
the comment for the "isinit" member in wilc_spi.  Let me know if I'm missin=
g
something, though.

  --david


