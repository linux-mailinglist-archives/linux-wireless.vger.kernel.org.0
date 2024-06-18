Return-Path: <linux-wireless+bounces-9198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE290D62E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE88B1C24795
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452014B97B;
	Tue, 18 Jun 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FEbEx+UZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD282139C1;
	Tue, 18 Jun 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722083; cv=none; b=oPNbFNjqTodqmy6Ur4LyuaL7N5rEpC4Lc8tBTosiHCUbjtJr5vxZJ64nqG8R5l85AlZWdqo3ifHpVPDg+Lgxz4rni9uNgdotJZ18f3Zo/8PV6Vrg21SA/SvcvKVV0PHKMbK/y9LXAidWN7+Sk6MGqVCY1nDI1qhmh38RwOUp594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722083; c=relaxed/simple;
	bh=AptMB+YIiD2q53qVWsQoJqIp+iSh1nUp7RFHH6Hf/ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PY+C86f19fnMpYAK3uWWLSu2Kqh0wgHPeQK8M2aTwZHwMnC/dUuqeiawS0ElUc7pO3td+LIwrWkvPoU0OyGXNXiXAwJXTxperJ/bgbME95RWEJYoAE7S/J5OxDoyW1Rrc1hvbf8C04NlNdhL98+/BGeEoyD83f3OSo5uzsu9SzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FEbEx+UZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718722080;
	bh=AptMB+YIiD2q53qVWsQoJqIp+iSh1nUp7RFHH6Hf/ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEbEx+UZSasLc7cTDBrhO6RxoZODD2ORZ/GcdPip5l5O1vtkDrBkWHydICrYy80cZ
	 AkgZIln2jKxEU8mSYvmtCtHSoUMn3Vt2KzOTPVe5BSgh5dDOh1XBoQyOIKTFVYDFZL
	 f5ulw1hxHi/tpLIyrWit4RzFFzUZLrv3dv8WGi88112JMtorTp9LhO8xfM/cKk58vl
	 b8o034LkaZdrDSz7PbB2inMB/sbFCoNaQ/er1LVNoM8IIxKGvhX51n08wApd/P0A1k
	 l0BWdgmScyVvQjDD1rEDESKSuEGhvR5SVdo3zgsGxZw96/FLCn5a8dL0dnVBBAzEJJ
	 66x0QI/ESyvDw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 35C6B3780629;
	Tue, 18 Jun 2024 14:48:00 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id D25721060734; Tue, 18 Jun 2024 16:47:59 +0200 (CEST)
Date: Tue, 18 Jun 2024 16:47:59 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Arend Van Spriel <aspriel@gmail.com>
Cc: Jacobe Zang <jacobe.zang@wesion.com>, kvalo@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nick@khadas.com, 
	arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: net: wireless: BCM4329 binding: add
 pci14e4,449d
Message-ID: <si3gjsfqcixdrwzf4nmxvugpcbrhglchxxm5vwnr52rhsvuflc@5r2g4g2xd7au>
References: <20240617024341.3106240-1-jacobe.zang@wesion.com>
 <b6b06a15-b7de-4351-ab9e-5234d2b91496@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bqocjo5pd32uxgd2"
Content-Disposition: inline
In-Reply-To: <b6b06a15-b7de-4351-ab9e-5234d2b91496@gmail.com>


--bqocjo5pd32uxgd2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2024 at 01:09:07PM GMT, Arend Van Spriel wrote:
> On 6/17/2024 4:43 AM, Jacobe Zang wrote:
> > It's a Broadcom Wi-Fi module connected via the PCIe interface and also
> > add prefix in vendor-prefix.yaml
> >=20
> > Link:https://lore.kernel.org/linux-devicetree/20240617023517.3104427-1-=
jacobe.zang@wesion.com/T/#u
> > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> > ---
> >   .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm432=
9-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-f=
mac.yaml
> > index e564f20d8f415..0477566acd72a 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.=
yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.=
yaml
> > @@ -53,6 +53,7 @@ properties:
> >             - pci14e4,4488  # BCM4377
> >             - pci14e4,4425  # BCM4378
> >             - pci14e4,4433  # BCM4387
> > +          - pci14e4,449d  # BCM4329
>=20
> I can not find that device id. Can you provide more information where you
> came across this device. The BCM4329 as I know it is an 802.11n *SDIO*
> device. Not a PCI device.

It's the device id used by AP6275P, see this discussion from half a
year ago [0]. It is used by Rockchip's RK3588 evaluation board, which
apparently resulted in some RK3588 boards using the same chip.

[0] https://patchwork.kernel.org/project/linux-wireless/patch/c7b331edd65b6=
6521a6605177d654e55051568a3.camel@toradex.com/

Greetings,

-- Sebastian

--bqocjo5pd32uxgd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZxnhEACgkQ2O7X88g7
+prHZA/+PhQDVUsUiui4n/4jAvQYSZ6Q5SB7dV1JndGlFwxfs+u8IuBLfSRxID3U
nAkQTcdiC1cPj1g7NPcoI15IM8Xjejt3x9yF+sd7Vx9QqAikJpyT2K/tZynMnikc
2z5LOkNkEBTbGSOWTglD4WsLhz3WDYZRkEGE5ff6WmqODuNwRbJdC2FvgVOkHcn2
hlSSiNeRXW7w6x7HpqHpZZSerauuTIDYSfUMsbnxW8QCKsKv41UwLDWaLy/rplOx
yIUSrHFcgVvhGpB+cAQnjLcGOqrThJ3fuFghn7a9kIdfnj2Wes98kV8nbewMCLd/
c+2hRA61BsNNtfli2xHRShQhkmYuzL+/koO4D4Z6rRnxEftLZx0oITarlTkdOChh
K4pfyQegkK6FM4RJgEwrJh8JrurEwNp3kaVS5nO5S6bHRlrl2R6hZD1B56W70amg
SChGzcyz4mDl8vIEMhWnLh1jAUCtupJtYpNbWJNvD71ouCMgBmyQQrYVSl5nTM6V
K+GTtv4Fr8HlvECgQpU7GbqW/RdNz4y7VOyN1ZWkvfu6ilARR7sr+d3LcKRGwm3+
Ke/Tbjr2VCRy2oUG/T7JO+JutPQABDx9tqhdO7Tzezbp6KZUDnQiz8dKr4YpP4bU
2N3GcDORymGCwqL3ZwnfU4eWcvRQkgGjuT7iJUPPtsr7LGWQG5s=
=UN5E
-----END PGP SIGNATURE-----

--bqocjo5pd32uxgd2--

