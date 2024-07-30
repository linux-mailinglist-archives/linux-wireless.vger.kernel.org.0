Return-Path: <linux-wireless+bounces-10694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D230941EEC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48601F225F7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC90189915;
	Tue, 30 Jul 2024 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LRGoCPiZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C31A76C6;
	Tue, 30 Jul 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361100; cv=none; b=gNZbbI90QNJUIOKwmRPRdxf1st9I4EV1ey98HegzBxL9xVYdeOnlfa0eTr25sAccWE6ZMwy5pvh+knSiV4cbB77KLLQTjZjklX27gcAAVdxUBh2E1zTTWu6IvPBn481ymXyHaF+Hv7oeAhJ6vZwlw0yg9tonoUPQHWIxtvXj/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361100; c=relaxed/simple;
	bh=9IUleP8OzhpQtp7S1NkmiFennhuOo0B3m/rmGIOk5+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu8QHHZRAvb4T9vVmSMKP5zDZmNMK0aJ2OohYkNegAX4I+RJq56iDFujjGhx4rrcU9vWbfFZuE6IO0DnyyMf5mP//OROSIoHOlP4/0VBCEP1Uw5ipaSrWfDC7sV28jwh048+2VPc3VBWW4EQSwfX6J7PVBGSfqm9E/X6DIHbV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LRGoCPiZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722361096;
	bh=9IUleP8OzhpQtp7S1NkmiFennhuOo0B3m/rmGIOk5+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRGoCPiZ0JAyuj7ggrTjMFyQRrwTvDzXOiWdMhoyjs55Te5FcWuCA9a2yMO90y6B+
	 pm7uqlKSKJrS5muy4DTbqQ6E+8r9o8x9wEsFFqKeGj3mDABsPgU6mzkqbTz8UuWop3
	 sCZcybBDE31UicBaqMaCTGoKoqMiJ1C4q9LMvnjLdRVHs6q8WLCqZzN8ibQGKy/FZb
	 KvYHjpHqbX6y7gROPQ/4oZSkWsa4lwQevOiozL9vzus5VKGUzoUxzzbP9BD2HNtns7
	 o6laaQKI8jsgDLBP5MqYg6P1eV5x9fMMEL0KQveiRtfMJl9/DRYlUpGkHrJohdWGu1
	 EU+ryKM3Pt85w==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CC1AA3781139;
	Tue, 30 Jul 2024 17:38:16 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 70AD510609BB; Tue, 30 Jul 2024 19:38:16 +0200 (CEST)
Date: Tue, 30 Jul 2024 19:38:16 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, 
	kvalo@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, conor+dt@kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
Subject: Re: [PATCH v5 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P
Message-ID: <k3dhdsa5bjzad2ha5e2uurg2azzs773ier5thkot4w2qcvnv54@yuf52eluqsae>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-3-jacobe.zang@wesion.com>
 <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f45c1fa7-f321-4a1f-b65c-6ed326a18268@kernel.org>
 <191030eac78.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3d3b8e0a-7492-4db1-bd73-c30a488edaa7@kernel.org>
 <191035b8c28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jf2alk6nvvmfsvtq"
Content-Disposition: inline
In-Reply-To: <191035b8c28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>


--jf2alk6nvvmfsvtq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 30, 2024 at 01:16:57PM GMT, Arend Van Spriel wrote:
> On July 30, 2024 12:18:20 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> > On 30/07/2024 11:52, Arend Van Spriel wrote:
> > > On July 30, 2024 11:01:43 AM Krzysztof Kozlowski <krzk@kernel.org> wr=
ote:
> > >=20
> > > > On 30/07/2024 08:37, Arend Van Spriel wrote:
> > > > > + Linus W
> > > > >=20
> > > > > On July 30, 2024 5:31:15 AM Jacobe Zang <jacobe.zang@wesion.com> =
wrote:
> > > > >=20
> > > > > > Not only AP6275P Wi-Fi device but also all Broadcom wireless de=
vices allow
> > > > > > external low power clock input. In DTS the clock as an optional=
 choice in
> > > > > > the absence of an internal clock.
> > > > > >=20
> > > > > > Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > > > > > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> > > > > > ---
> > > > > > .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 +=
+++++++
> > > > > > 1 file changed, 8 insertions(+)
> > > > > >=20
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-f=
mac.yaml
> > > > > > b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-f=
mac.yaml
> > > > > > index 2c2093c77ec9a..a3607d55ef367 100644
> > > > > > --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43=
29-fmac.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43=
29-fmac.yaml
> > > > > > @@ -122,6 +122,14 @@ properties:
> > > > > > NVRAM. This would normally be filled in by the bootloader from =
platform
> > > > > > configuration data.
> > > > > >=20
> > > > > > +  clocks:
> > > > > > +    items:
> > > > > > +      - description: External Low Power Clock input (32.768KHz)
> > > > > > +
> > > > > > +  clock-names:
> > > > > > +    items:
> > > > > > +      - const: lpo
> > > > > > +
> > > > >=20
> > > > > We still have an issue that this clock input is also present in t=
he
> > > > > bindings specification broadcom-bluetooth.yaml (not in bluetooth
> > > > > subfolder). This clock is actually a chip resource. What happens =
if both
> > > > > are defined and both wifi and bt drivers try to enable this clock=
? Can this
> > > > > be expressed in yaml or can we only put a textual warning in the =
property
> > > > > descriptions?
> > > >=20
> > > > Just like all clocks, what would happen? It will be enabled.
> > >=20
> > > Oh, wow! Cool stuff. But seriously is it not a problem to have two en=
tities
> > > controlling one and the same clock? Is this use-case taken into accou=
nt by
> > > the clock framework?
> >=20
> > Yes, it is handled correctly. That's a basic use-case, handled by CCF
> > since some years (~12?). Anyway, whatever OS is doing (or not doing)
> > with the clocks is independent of the bindings here. The question is
>=20
> Agree. Probably the bindings would not be the place to document this if it
> would be an issue.
>=20
> > about hardware - does this node, which represents PCI interface of the
> > chip, has/uses the clocks.
>=20
> The schematics I found for the wifi module and the khadas edge platform s=
how
> these are indeed wired to the chip.

I have a Rockchip RK3588 Evaluation Board on my desk, which uses the
same WLAN AP6275P module. I think I already commented on a prior
version of this series: The LPO clock is needed to make the PCIe
device visible on the bus. That means this series only works if the
clock has already been running. Otherwise the PCIe driver will never
be probed. To become visible the devices requires:

1. The LPO clock to be enabled
2. Power to be applied
3. The WL_EN gpio to be configured correctly

If one of the above is not met, the device will not even appear in
'lspci'. I believe the binding needs to take into consideration, that
pwrseq is needed for the PCIe side. Fortuantely the heavy lifting of
creating the proper infrastructure for this has already been done by
Bartosz Golaszewski for Qualcomm WLAN chips. What is missing is a
pwrseq driver for the Broadcom chip (or this specific module?).

Greetings,

-- Sebastian

--jf2alk6nvvmfsvtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmapJP4ACgkQ2O7X88g7
+ppEtw//U1k4jbWPNYlqHLMqe+zCNqwKR5lm/UcmOBN5NZbS+CUQkPZxNBGlVGmV
GN7dnCABPzlKtbi+IybAV9D3zuZ9pjWqoUmqXDENHluMxyevsPqeIqUdg+QWQbgr
5XbEXHYbGSl2Ous+jbo3pUBC+riwepUOqO9lMVS/AjpeOgX1JyOIpYEOT9IAqrRn
ZMHASWZ8jZZCgXZcivEAkpVXhz9TrxDjGZzUKe8zXu4JawYlZt7z1bD3pwoxyQ7J
KRZpVm3a5RWSJzWcPefJwJ2mhk+/TmDJHMhn+bGtg5j/IoNiBAqFn+hiNRcn1S9E
Bprr5IAJEs/jYjyytrCAm013AXPpI29pd9k5zBTbj8OeS0DKZA1dOi8gDhB89jVo
wC/+s6YU2RYC4DwY5FXBjvoZGb2jCALl9vWb2Hhrk9OLtjtphUEz3aPkZYnARWpo
ElAVz0x76stHIfe4DOIautJHlH9zf4TaBEiqv8M4Sx2fM10Kq5sps6gbSESNLyru
rswZR4SJwBnJfcAarov9LcWiESEztmGm5HRVGehHqw2470kyUprdElP2h3YLudfx
frNemcdHN9IByCVz70O6m9sHl9wTaIDCRaFul8DlNalIRbcHNE4Gw1Pr7P8t7rRZ
pe2MsIYPSY9JzvYlRcuztpgaGHmChUSdhTMhQdbu6x416/EFaOY=
=lH9x
-----END PGP SIGNATURE-----

--jf2alk6nvvmfsvtq--

