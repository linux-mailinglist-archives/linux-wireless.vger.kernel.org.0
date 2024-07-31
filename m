Return-Path: <linux-wireless+bounces-10748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A9A943172
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 15:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAA91F21A27
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9AD1B373D;
	Wed, 31 Jul 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fcH+Msuk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66941B29C6;
	Wed, 31 Jul 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434096; cv=none; b=IyIgMD8spQ9+fFKnC8jpo27weZEJmhe8NtKRSD0c/nefXMYgliurbFHo+Bz/pmD1v+e+ZBeYbgJa5iOdsf2JG2Pvb15YDWjRQOC9foIQAbWgvVCbE2VKjiOoypN2ZSdTqNBQnW6vZxyJFMLCIyLvbTvo0HWu+ISNpFJGNSJekIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434096; c=relaxed/simple;
	bh=hpqMXM/+YsQB0DwTCH/3eXsvIZ0spLvi2/l3BArr2ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5bum03W+lfammCLgjxJqsdrPWE4587j8gsb+GFuux86BHeew3ZPuSqEkkNhB8izI1dzpxRzZ0R4MSdoitOs2sWlqpKx+5h68qaU5xS+ywekG1/5Q1jzB6JFEbrfdMdzDWStFyMOjBjNH7rC6473Yi/SXdzz7HU5zMXP1pzc95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fcH+Msuk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722434091;
	bh=hpqMXM/+YsQB0DwTCH/3eXsvIZ0spLvi2/l3BArr2ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcH+Msuk2Z0nDNSoZXwJnyQ0fnJV5pD7AvP6Y0G57hHxdXdORBxROORWRXW2KtwB4
	 3ObZZF3pI3Ydc71kwBwdyzPmShYD61qycGUlI2yXHpjegmfyoLxWmDiCjoLyPVTL7D
	 Lqda1TfDe3E2gUPRzAJyuApyn5kOGk3DMCQ+36p9LC4VtqKp8M4gK9EUbT+pyGTC2Y
	 IeqcwqXAXWZwH6B8vc3JsabODQvJQPABJLh6sMueSgzAx9SQQo35Uu08DX9Af6BjWB
	 lFBGJCJ3Bm4JPWcXbVS2egsjPZyqIUDnPZzCWosKZIhw292vaIK8BU/Nu5rETdZYH3
	 KeLROjWwyGKtQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AC5C137800DE;
	Wed, 31 Jul 2024 13:54:51 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 5281A10609BB; Wed, 31 Jul 2024 15:54:51 +0200 (CEST)
Date: Wed, 31 Jul 2024 15:54:51 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de, 
	kvalo@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, conor+dt@kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com, 
	Andy Green <andy@warmcat.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P
Message-ID: <sgfd5ccltsi7mjbybmdbs3fmsfcp3vqtpitdac7exzgxav53kk@6lwogbq4fhks>
References: <20240730033053.4092132-1-jacobe.zang@wesion.com>
 <20240730033053.4092132-3-jacobe.zang@wesion.com>
 <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f45c1fa7-f321-4a1f-b65c-6ed326a18268@kernel.org>
 <191030eac78.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3d3b8e0a-7492-4db1-bd73-c30a488edaa7@kernel.org>
 <191035b8c28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <k3dhdsa5bjzad2ha5e2uurg2azzs773ier5thkot4w2qcvnv54@yuf52eluqsae>
 <dd381dc1-454f-4ecd-adb7-55de2e15d592@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cr5sbyun7xohki4r"
Content-Disposition: inline
In-Reply-To: <dd381dc1-454f-4ecd-adb7-55de2e15d592@broadcom.com>


--cr5sbyun7xohki4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 31, 2024 at 02:57:37PM GMT, Arend van Spriel wrote:
> On 7/30/2024 7:38 PM, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, Jul 30, 2024 at 01:16:57PM GMT, Arend Van Spriel wrote:
> > > On July 30, 2024 12:18:20 PM Krzysztof Kozlowski <krzk@kernel.org> wr=
ote:
> > >=20
> > > > On 30/07/2024 11:52, Arend Van Spriel wrote:
> > > > > On July 30, 2024 11:01:43 AM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> > > > >=20
> > > > > > On 30/07/2024 08:37, Arend Van Spriel wrote:
> > > > > > > + Linus W
> > > > > > >=20
> > > > > > > On July 30, 2024 5:31:15 AM Jacobe Zang <jacobe.zang@wesion.c=
om> wrote:
> > > > > > >=20
> > > > > > > > Not only AP6275P Wi-Fi device but also all Broadcom wireles=
s devices allow
> > > > > > > > external low power clock input. In DTS the clock as an opti=
onal choice in
> > > > > > > > the absence of an internal clock.
> > > > > > > >=20
> > > > > > > > Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > > > > > > > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> > > > > > > > ---
> > > > > > > > .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          |=
 8 ++++++++
> > > > > > > > 1 file changed, 8 insertions(+)
> > > > > > > >=20
> > > > > > > > diff --git
> > > > > > > > a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43=
29-fmac.yaml
> > > > > > > > b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43=
29-fmac.yaml
> > > > > > > > index 2c2093c77ec9a..a3607d55ef367 100644
> > > > > > > > --- a/Documentation/devicetree/bindings/net/wireless/brcm,b=
cm4329-fmac.yaml
> > > > > > > > +++ b/Documentation/devicetree/bindings/net/wireless/brcm,b=
cm4329-fmac.yaml
> > > > > > > > @@ -122,6 +122,14 @@ properties:
> > > > > > > > NVRAM. This would normally be filled in by the bootloader f=
rom platform
> > > > > > > > configuration data.
> > > > > > > >=20
> > > > > > > > +  clocks:
> > > > > > > > +    items:
> > > > > > > > +      - description: External Low Power Clock input (32.76=
8KHz)
> > > > > > > > +
> > > > > > > > +  clock-names:
> > > > > > > > +    items:
> > > > > > > > +      - const: lpo
> > > > > > > > +
> > > > > > >=20
> > > > > > > We still have an issue that this clock input is also present =
in the
> > > > > > > bindings specification broadcom-bluetooth.yaml (not in blueto=
oth
> > > > > > > subfolder). This clock is actually a chip resource. What happ=
ens if both
> > > > > > > are defined and both wifi and bt drivers try to enable this c=
lock? Can this
> > > > > > > be expressed in yaml or can we only put a textual warning in =
the property
> > > > > > > descriptions?
> > > > > >=20
> > > > > > Just like all clocks, what would happen? It will be enabled.
> > > > >=20
> > > > > Oh, wow! Cool stuff. But seriously is it not a problem to have tw=
o entities
> > > > > controlling one and the same clock? Is this use-case taken into a=
ccount by
> > > > > the clock framework?
> > > >=20
> > > > Yes, it is handled correctly. That's a basic use-case, handled by C=
CF
> > > > since some years (~12?). Anyway, whatever OS is doing (or not doing)
> > > > with the clocks is independent of the bindings here. The question is
> > >=20
> > > Agree. Probably the bindings would not be the place to document this =
if it
> > > would be an issue.
> > >=20
> > > > about hardware - does this node, which represents PCI interface of =
the
> > > > chip, has/uses the clocks.
> > >=20
> > > The schematics I found for the wifi module and the khadas edge platfo=
rm show
> > > these are indeed wired to the chip.
> >=20
> > I have a Rockchip RK3588 Evaluation Board on my desk, which uses the
> > same WLAN AP6275P module. I think I already commented on a prior
> > version of this series: The LPO clock is needed to make the PCIe
> > device visible on the bus. That means this series only works if the
> > clock has already been running. Otherwise the PCIe driver will never
> > be probed. To become visible the devices requires:
> >=20
> > 1. The LPO clock to be enabled
> > 2. Power to be applied
> > 3. The WL_EN gpio to be configured correctly
> >=20
> > If one of the above is not met, the device will not even appear in
> > 'lspci'. I believe the binding needs to take into consideration, that
> > pwrseq is needed for the PCIe side. Fortuantely the heavy lifting of
> > creating the proper infrastructure for this has already been done by
> > Bartosz Golaszewski for Qualcomm WLAN chips. What is missing is a
> > pwrseq driver for the Broadcom chip (or this specific module?).
>=20
> That does not really make sense. There is no relation between the LPO clo=
ck
> and the PCIe clocks so 1) being a requirement for probing the device looks
> odd. It also does not match past experience when I assisted Andy Green in
> getting this module up and running almost two years ago.

Well, first of all I can easily reproduce this on my RK3588 EVB1. I
intentionally ignore any bluetooth bits to avoid cross-effects from
bluetooth enabling any clocks / regulators / GPIOs and make sure the
RTC output clock is disabled at boot time (i.e. boot once without
any reference to the RTC clock and without 'clk_ignore_unused'
kernel argument). When booting up like this the WLAN device is not
visible in 'lspci' despite the WL_REG_ON GPIO being hogged. If I
additionally hack the RTC output clock to be enabled the WLAN device
becomes visible in 'lspci'.

The datasheet fully explains this:

https://www.lcsc.com/datasheet/lcsc_datasheet_2203281730_AMPAK-Tech-AP6275P=
_C2984107.pdf

PDF Page 23/24 (20/21 in the footer) has the Host Interface Timing
Diagram. WL_REG_ON should only be enabled after 2 cycles from LPO.
That means with LPO being disabled WL_REG_ON cannot be enabled. I'm
pretty sure WL_REG_ON means WLAN_REGULATOR_ON, so the logic is not
powered. On page 27 (24 in the footer) there is also a PCIe Power-On
Timing diagram, which shows that WL_REG_ON must be enabled before
the PCIe refclk is enabled.

So there is a specific power up sequence, which must be followed.

Greetings,

-- Sebastian

--cr5sbyun7xohki4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmaqQhsACgkQ2O7X88g7
+pqg5w/7BH1jKNHBtCjfHnn6etLyRJ8u7GCuDoQJutx3aMQanb2Nqy41JkYnqTld
waTwl+EOCOL3kweDAQwBM1vZawgGZEpdrDdbdBjbhlYXmSpgH/2nYmpoxbaAY5iz
rFb+QgTtoBGzRrMt5hbrwELG+59acPDq8iRFTQ+g0RQMhMIWAzrTJkTrGPSMz1sl
91HNRg/YCHaW7Y0zhviSTSxtVQVKiHUG/aerwt6rUo4Ndigq8NJiFT9X/z95vmcZ
p/7Hqy2GS81x33Q6WGEfhrcpwIO8GcPyua1bcrq+nHltR2jB4ypxLXQT2uuRWHMG
m4cWkI38t0pu2flQZfJcyfNuuTrQohCIQOhR+cprUabIQTYqGa/tdj749vnLQy2F
vmqIaPF3vih9mRoF55COPjbng+mVM5OhxnVa2qsxpLBO4YjadGYePhDlqjt6FWfC
BPYXDSV4cLTc2AQN6olR3VVrZZ7EsQFWNpXXg6AvVpG47r/1j0FWqRBJbh+27OIu
VY+om4xcwsz0sd5Gup9wHOJ9NnLzEC7e6hWMjuvEw+AfUJSoF3Po/1T8rl/hb1LH
ORfmYmBIHmRyRkvN1Ir6CKuFLIVttWtY5xeoIc6Qn4esE7fAFSLasmYzzOb6kHd3
EAciiKvfaP7vVRY3itqwn+bCFIYBocBQO1U2oFInkA58ReJ17Vk=
=tybG
-----END PGP SIGNATURE-----

--cr5sbyun7xohki4r--

