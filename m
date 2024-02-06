Return-Path: <linux-wireless+bounces-3195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C684AFAE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A7E1F21506
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 08:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD9912AACA;
	Tue,  6 Feb 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="I4rdJLEr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8E129A88;
	Tue,  6 Feb 2024 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207189; cv=none; b=iXGSh2FCvpdSyi75fWuwPmvQHP5df2923mKpwVlpRX8SLPqSArW96y1ufJWV09v8Fnk2UMte5dHvBn09yF3+ybQefx7zFJf0nbcXHNedXWn0IouvkI5x5o/UrUEqjXeBYJ9qsBmmA/MBPuUyexd7B+y+iHEsowuhwq0YXkJhZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207189; c=relaxed/simple;
	bh=Doz10uRPlhZmG+tUOdZ8260givuhQICoG4FkfAKDcN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikAbY601ZIpB3eme8z8nLOasX0caNkG5Pof826Cba713U2BFvdphjC1Hmo18Ihr/c8g3PG8QS62wrl13IUcV9L6Cb68ZJjeB9r74GltUkNPWG2hqopWicX2mhfXjKKezQaTjznFUVlBxPGUWVA2QKiPA4FjizAOkuunLpQJ6Qms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=I4rdJLEr; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F25311C0081; Tue,  6 Feb 2024 09:12:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1707207177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfK3pz0tQOnn1B4EHvkSrMw3rw8kqeAgHoaHUb8tze4=;
	b=I4rdJLEri1PAJP5D4YMM2Vz/Dx+gQZxOsxcYl/GXlDjfZfwNT/10UpSloeR9SOpsKcDI3V
	wLsNPtV8kRJfvapDOvjP8nE6541XNLxiHBIIdmvsSjkdFqfAYuAvBWhn4gEZMQmkW7s5rj
	VJQ68ozfMkkedjCjp14DY/+LVcXmlu8=
Date: Tue, 6 Feb 2024 09:12:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Subject: Re: [PATCH 5/9] wifi: rtw88: Add rtw8703b.c
Message-ID: <ZcHqCRRcgaLdyQSq@duo.ucw.cz>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-6-fiona.klute@gmx.de>
 <8b20f91585694702bac414680ba937c9@realtek.com>
 <09d93cef-5338-4463-b656-dab934029c63@gmx.de>
 <28c1571cc90b49ce928ddb929e2bc93f@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="On/uG6861zw75SjG"
Content-Disposition: inline
In-Reply-To: <28c1571cc90b49ce928ddb929e2bc93f@realtek.com>


--On/uG6861zw75SjG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi!

> > I'm afraid I'm not familiar with the details either, but this is how the
> > SDIO wifi device for the Pinephone is defined (in
> > arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi, as of v6.8-rc2=
):
> >=20
> > &mmc1 {
> >         pinctrl-names =3D "default";
> >         pinctrl-0 =3D <&mmc1_pins>;
> >         vmmc-supply =3D <&reg_vbat_wifi>;
> >         vqmmc-supply =3D <&reg_dldo4>;
> >         bus-width =3D <4>;
> >         non-removable;
> >         status =3D "okay";
> >=20
> >         rtl8723cs: wifi@1 {
>=20
> I think rtl8723cs is module name of vendor driver, so will you add rtw88_=
8723ds?

dts is supposed to describe hardware, not driver structure. So a) this
label should not really matter b) it really should not really be
changed to match the driver name.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--On/uG6861zw75SjG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZcHqCQAKCRAw5/Bqldv6
8uKrAJ96n3Yaxi6qm68GPsUH0ZrYNDZs+ACfWn97GL3BsZSoXgz4k3+G6sOfeKg=
=ryRX
-----END PGP SIGNATURE-----

--On/uG6861zw75SjG--

