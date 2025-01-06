Return-Path: <linux-wireless+bounces-17115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C32A02FF9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 19:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE8818831C9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD6F86359;
	Mon,  6 Jan 2025 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="kpmf6D7+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B6360
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736189657; cv=none; b=OvYjtoEPmFaYQZKBLWMt+8TbPgCImQZpNBY6gxngBiDV4dd04UAaGjEv+meR12VbLavOip+BcK6Iqsm+8CooHIN80p0kGZqhLJ5/gnNADzchm0gT5U4CnqX4vVGixufcd/3hZMGCPd1hi5plSebaGoqC8DDgNyz4LZi2cJyU/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736189657; c=relaxed/simple;
	bh=D7jTUhOH/CLJqLNlmCKhWm8/E8Audw4gMaV6UPdHHmU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UEH+k0986WUjQiU6i4nGqrabXnuZPbA7zqC6u4/lgz5kt2FTg7dx1Yp1EuxhBPa6TlHcI45/fdKWMJXzNQMoPVAbADtlN2Gs/G0yIazGg8pTfFPFnW5ASnL4ThdcRXKStE0Zle1jQFwMv5IEMC5478pZ0Bill++sNN4Ww/FXCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=kpmf6D7+; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D7jTUhOH/CLJqLNlmCKhWm8/E8Audw4gMaV6UPdHHmU=; b=kpmf6D7+wtetkfgWjx59DOlQae
	tGmUPBTTCUyCWbXIWGQH0JjzM8fYkrgqUuD9dIQsnKyB+dTSGyrcKUMNVx5Jh6Fn7ldLbIev4yqYW
	1kJZ6aT3nkyZPGtkRVp3KVMsJjSUyBd1s+HG2WfbGX0KawDZbBWGcEX85faGkiV8xH0gjfUjYcwD/
	z0LCDpHACrWLoI6YwlFGJYqOMEP/ZgdO8Hr4rvH+ehxu5djocG8Wf/ZdxjsxwrJp7hvfbvyfwKpRI
	0o192KLaIR+WJJEJ3QMSHHpbpQXdBKJsmjoeVX+nWvNIGbYgo12zazC3KKqevZ1oOBwUnK6k9P4OP
	GozuasJA==;
Received: from cw141ip135.vpn.codeweavers.com ([10.69.141.135] helo=grey.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <stefan@codeweavers.com>)
	id 1tUsEu-004iDU-2q;
	Mon, 06 Jan 2025 12:54:13 -0600
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefan@codeweavers.com>
To: linux-wireless@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Subject:
 Re: [PATCH] wifi: brcmfmac: Check the return value of
 of_property_read_string_index
Date: Mon, 06 Jan 2025 21:53:57 +0300
Message-ID: <5848081.DvuYhMxLoT@grey>
Organization: CodeWeavers
In-Reply-To: <4619776.LvFx2qVVIh@grey>
References:
 <20250106103749.5764-1-stefan@codeweavers.com>
 <058aba76-817c-480a-9404-38b030325890@broadcom.com> <4619776.LvFx2qVVIh@grey>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6115668.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart6115668.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefan@codeweavers.com>
Date: Mon, 06 Jan 2025 21:53:57 +0300
Message-ID: <5848081.DvuYhMxLoT@grey>
Organization: CodeWeavers
In-Reply-To: <4619776.LvFx2qVVIh@grey>
MIME-Version: 1.0

Hello Arend,

Am Montag, 6. Januar 2025, 14:22:29 Ostafrikanische Zeit schrieb Stefan=20
D=C3=B6singer:
> Am Montag, 6. Januar 2025, 14:02:17 Ostafrikanische Zeit schrieb Arend van
>=20
> Spriel:
> > On 1/6/2025 11:37 AM, Stefan D=C3=B6singer wrote:
> > > Somewhen between 6.10 and 6.11 the driver started to crash on my
> > > MacBookPro14,3. The property doesn't exist and 'tmp' remains
> > > uninitialized, so we pass a random pointer to devm_kstrdup().
> >=20
> > By the looks of it this is an intel-based platform. Is that correct? So
> > does it have a devicetree? I would expect the root node find to fail,
> > but apparently is does not. Strange though that root node does not have
> > a compatible property. Anyway, the analysis looks sane so ...
>=20
> Yes, this is an Intel based MacBook Pro - the 2017 version.

I have an updated theory why the codepath was entered: My kernel config had=
=20
CONFIG_OF (and CONFIG_OF_OVERLAY) enabled. I did not provide any DTBs on bo=
ot,=20
but this configuration apparently resulted in an empty root node being foun=
d.=20
I also see an empty (0 byte) /proc/device-tree/name file. With CONFIG_OF=3D=
n the=20
of.c file isn't compiled in the first place.

I think we still want to patch the code. While enabling this option on=20
standard x86 is arguably wrong, the driver shouldn't crash because of it.

I don't know where CONFIG_OF=3Dy came from. This is a kernel configuration =
grown=20
over 15 years. I might have accidentally enabled it in a "make oldconfig" r=
un,=20
or I enabled it 'just in case' without knowing what I was doing - this=20
particular Linux installation is on a USB drive that I plug into many=20
different x86_64 computers, so I enabled pretty much every driver (as a mod=
ule=20
if possible).

--nextPart6115668.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmd8JsUACgkQPRO8yFRP
GiKyvA/9FNr8N3NFvVPQF8DwM5hpKSCXVxbDKJSXpQM3odmBf3CzAldk3gjbwhZp
+9qw1AGfDe9vzrzRuHFnmD6ofkmOVL5Pe5f+xIhpi+FWwRiNJN1X9evF5t6WmVvc
g35zNfeDfNh03LQuGJcgL4PvRbeZrrOTQOH4fqJx9EgK4wILcib8OWZ7+9B4RdPC
hf1bCG/Eds1jpl9BKcoTF32L+XyOSg3/toHlCPbGLdB3H7vLEQDUHPMhEdRIrkD/
169yWcZX86G9aVnys7vTXefKvu5LzhJxRJxhqGWLCsY6jNy5YR8841pp4kTkYly0
s+APBpsjfxZL1dztLxjDW6HNfEJerVnopsOPcmi9AD7mVwA3KPG7biy8FR1JxhqK
L8265BTxqSyb8ribjlRYuL1mpuin60nUUgenIlQeu7qye1pkbPEh8Ku32OBAPGpZ
f6ELGNvvYpm0h2VAc/ldenVSpaNwSzsvoCGhXJypnm56Qo3FRuy25T7ScLt4R8f5
Gov2vkeLddjB6meXlQlKEdGdE7MZzZvYhLabUzr6J4yo9M5BqG9GdZek5mZg7cfu
aUGh67NI2csdOXX7XVVf1wSMFjP9LW1HUfRg69A+lza4f8uAf/pypiX2aotZEEvz
u/UzPyPliZkvSgeTolUN869mjeVcAtjkKMquKU1ZIOXhQHz/70s=
=aGl+
-----END PGP SIGNATURE-----

--nextPart6115668.lOV4Wx5bFT--




