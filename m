Return-Path: <linux-wireless+bounces-10763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A556894352C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 19:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F07B2124C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F1938FA3;
	Wed, 31 Jul 2024 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4kZycYuV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D445007;
	Wed, 31 Jul 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722448222; cv=none; b=NBD2wJWISSe0PufVru10hEXip34Y12SXALxCqxkbR9ZyKu6Jl4Cc5kxE3kMgIFlIlzvy53lseZ9WFh2MVxhz2uuH5duxzSuUuE3GA5UAhWyy6lvLExt5M1sxCEmVyrNIArmkQsRkAEy0PgW55ng43mn2FGX7NFOSQW3Wgg3qzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722448222; c=relaxed/simple;
	bh=SUbvt4YQ/Ri8ijmIeyQW1LP0iNmjh7l+SdztU2CMSK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv1BT4D8tvwjDHiWTImdle9Es8SSHPXoxeA2cP05d8BH+RJpyTuNAnpJdjsaiyJYH//DPagRGU1Ba7rsxLwp/rCoOuEv31G8DIXbB7VcO3k/4PZ73V/uKdiCo5gB1XWG8oT/wupbsuT+6iJWglcNWs23ohn+fLvG2WKgK4+jvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4kZycYuV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722448218;
	bh=SUbvt4YQ/Ri8ijmIeyQW1LP0iNmjh7l+SdztU2CMSK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4kZycYuV7rNgk7MiZhkpjl4EucXIPgirUN25IkczKeVsWf+15NwbJgmL7FnZf0Iur
	 qw8GHuzCnO6tgfbiIFh/5peplsfE1E3D2xM2eu4L2dxdZ7xGDPcDvy3DjQpYEFdEf2
	 wiKbpoEzmbEZvYt6LCvZlssx1UzfkrTlU1AKKefjV85WokbvHb/tuo0sBsKTYF26Ub
	 nbJ/2vNhxt9f/YkkozjXB1px0JuPFgZ2HrEvC86dCvS8dn5yHcmNYrtaMFT7lXc0F7
	 nVxwtQv/otUZX+QNT4RIJVBzCtxmQX4MvxG8cQfFbOlPftdXn79iNbfxY0G89qYD4O
	 wmmMUVbMZcc4A==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5484437804C8;
	Wed, 31 Jul 2024 17:50:18 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id F37A110609BB; Wed, 31 Jul 2024 19:50:17 +0200 (CEST)
Date: Wed, 31 Jul 2024 19:50:17 +0200
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
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com, 
	Andy Green <andy@warmcat.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P
Message-ID: <cn4vykgbj6mhiikyco5uvyfa424njoun67hsoof4lbwvscwoc2@5xfl4q5mvooy>
References: <20240730033053.4092132-3-jacobe.zang@wesion.com>
 <191025b5268.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f45c1fa7-f321-4a1f-b65c-6ed326a18268@kernel.org>
 <191030eac78.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3d3b8e0a-7492-4db1-bd73-c30a488edaa7@kernel.org>
 <191035b8c28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <k3dhdsa5bjzad2ha5e2uurg2azzs773ier5thkot4w2qcvnv54@yuf52eluqsae>
 <dd381dc1-454f-4ecd-adb7-55de2e15d592@broadcom.com>
 <sgfd5ccltsi7mjbybmdbs3fmsfcp3vqtpitdac7exzgxav53kk@6lwogbq4fhks>
 <1910959c1f8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="my2grf6ekzwdybt6"
Content-Disposition: inline
In-Reply-To: <1910959c1f8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>


--my2grf6ekzwdybt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 31, 2024 at 05:12:43PM GMT, Arend Van Spriel wrote:
> On July 31, 2024 3:54:52 PM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > On Wed, Jul 31, 2024 at 02:57:37PM GMT, Arend van Spriel wrote:
> > > On 7/30/2024 7:38 PM, Sebastian Reichel wrote:
> > > > On Tue, Jul 30, 2024 at 01:16:57PM GMT, Arend Van Spriel wrote:
> > > > > On July 30, 2024 12:18:20 PM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> > > > >=20
> > > > > > On 30/07/2024 11:52, Arend Van Spriel wrote:
> > > > > > > On July 30, 2024 11:01:43 AM Krzysztof Kozlowski <krzk@kernel=
=2Eorg> wrote:
> > > > > > >=20
> > > > > > > > On 30/07/2024 08:37, Arend Van Spriel wrote:
> > > > > > > > > + Linus W
> > > > > > > > >
> > > > > > > > > On July 30, 2024 5:31:15 AM Jacobe Zang <jacobe.zang@wesi=
on.com> wrote:
> > > > > > > > >
> > > > > > > > > > Not only AP6275P Wi-Fi device but also all Broadcom wir=
eless devices allow
> > > > > > > > > > external low power clock input. In DTS the clock as an =
optional choice in
> > > > > > > > > > the absence of an internal clock.
> > > > > > > > > >
> > > > > > > > > > Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom=
=2Ecom>
> > > > > > > > > > Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> > > > > > > > > > ---
> > > > > > > > > > .../bindings/net/wireless/brcm,bcm4329-fmac.yaml       =
   | 8 ++++++++
> > > > > > > > > > 1 file changed, 8 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git
> > > > > > > > > > a/Documentation/devicetree/bindings/net/wireless/brcm,b=
cm4329-fmac.yaml
> > > > > > > > > > b/Documentation/devicetree/bindings/net/wireless/brcm,b=
cm4329-fmac.yaml
> > > > > > > > > > index 2c2093c77ec9a..a3607d55ef367 100644
> > > > > > > > > > --- a/Documentation/devicetree/bindings/net/wireless/br=
cm,bcm4329-fmac.yaml
> > > > > > > > > > +++ b/Documentation/devicetree/bindings/net/wireless/br=
cm,bcm4329-fmac.yaml
> > > > > > > > > > @@ -122,6 +122,14 @@ properties:
> > > > > > > > > > NVRAM. This would normally be filled in by the bootload=
er from platform
> > > > > > > > > > configuration data.
> > > > > > > > > >
> > > > > > > > > > +  clocks:
> > > > > > > > > > +    items:
> > > > > > > > > > +      - description: External Low Power Clock input (3=
2.768KHz)
> > > > > > > > > > +
> > > > > > > > > > +  clock-names:
> > > > > > > > > > +    items:
> > > > > > > > > > +      - const: lpo
> > > > > > > > > > +
> > > > > > > > >
> > > > > > > > > We still have an issue that this clock input is also pres=
ent in the
> > > > > > > > > bindings specification broadcom-bluetooth.yaml (not in bl=
uetooth
> > > > > > > > > subfolder). This clock is actually a chip resource. What =
happens if both
> > > > > > > > > are defined and both wifi and bt drivers try to enable th=
is clock? Can this
> > > > > > > > > be expressed in yaml or can we only put a textual warning=
 in the property
> > > > > > > > > descriptions?
> > > > > > > >=20
> > > > > > > > Just like all clocks, what would happen? It will be enabled.
> > > > > > >=20
> > > > > > > Oh, wow! Cool stuff. But seriously is it not a problem to hav=
e two entities
> > > > > > > controlling one and the same clock? Is this use-case taken in=
to account by
> > > > > > > the clock framework?
> > > > > >=20
> > > > > > Yes, it is handled correctly. That's a basic use-case, handled =
by CCF
> > > > > > since some years (~12?). Anyway, whatever OS is doing (or not d=
oing)
> > > > > > with the clocks is independent of the bindings here. The questi=
on is
> > > > >=20
> > > > > Agree. Probably the bindings would not be the place to document t=
his if it
> > > > > would be an issue.
> > > > >=20
> > > > > > about hardware - does this node, which represents PCI interface=
 of the
> > > > > > chip, has/uses the clocks.
> > > > >=20
> > > > > The schematics I found for the wifi module and the khadas edge pl=
atform show
> > > > > these are indeed wired to the chip.
> > > >=20
> > > > I have a Rockchip RK3588 Evaluation Board on my desk, which uses the
> > > > same WLAN AP6275P module. I think I already commented on a prior
> > > > version of this series: The LPO clock is needed to make the PCIe
> > > > device visible on the bus. That means this series only works if the
> > > > clock has already been running. Otherwise the PCIe driver will never
> > > > be probed. To become visible the devices requires:
> > > >=20
> > > > 1. The LPO clock to be enabled
> > > > 2. Power to be applied
> > > > 3. The WL_EN gpio to be configured correctly
> > > >=20
> > > > If one of the above is not met, the device will not even appear in
> > > > 'lspci'. I believe the binding needs to take into consideration, th=
at
> > > > pwrseq is needed for the PCIe side. Fortuantely the heavy lifting of
> > > > creating the proper infrastructure for this has already been done by
> > > > Bartosz Golaszewski for Qualcomm WLAN chips. What is missing is a
> > > > pwrseq driver for the Broadcom chip (or this specific module?).
> > >=20
> > > That does not really make sense. There is no relation between the LPO=
 clock
> > > and the PCIe clocks so 1) being a requirement for probing the device =
looks
> > > odd. It also does not match past experience when I assisted Andy Gree=
n in
> > > getting this module up and running almost two years ago.
> >=20
> > Well, first of all I can easily reproduce this on my RK3588 EVB1. I
> > intentionally ignore any bluetooth bits to avoid cross-effects from
> > bluetooth enabling any clocks / regulators / GPIOs and make sure the
> > RTC output clock is disabled at boot time (i.e. boot once without
> > any reference to the RTC clock and without 'clk_ignore_unused'
> > kernel argument). When booting up like this the WLAN device is not
> > visible in 'lspci' despite the WL_REG_ON GPIO being hogged. If I
> > additionally hack the RTC output clock to be enabled the WLAN device
> > becomes visible in 'lspci'.
> >=20
> > The datasheet fully explains this:
> >=20
> > https://www.lcsc.com/datasheet/lcsc_datasheet_2203281730_AMPAK-Tech-AP6=
275P_C2984107.pdf
> >=20
> > PDF Page 23/24 (20/21 in the footer) has the Host Interface Timing
> > Diagram. WL_REG_ON should only be enabled after 2 cycles from LPO.
> > That means with LPO being disabled WL_REG_ON cannot be enabled. I'm
> > pretty sure WL_REG_ON means WLAN_REGULATOR_ON, so the logic is not
> > powered. On page 27 (24 in the footer) there is also a PCIe Power-On
> > Timing diagram, which shows that WL_REG_ON must be enabled before
> > the PCIe refclk is enabled.
> >=20
> > So there is a specific power up sequence, which must be followed.
>=20
> The chip also has an (less accurate) internal LPO so the 32khz sleep clock
> in the diagram does not have to be an external clock. Maybe Ampak
> bootstrapped the chip to disable the internal clock. Dunno.
>=20
> What Andy needed back then to get firmware running was a change in the nv=
ram
> file to force using the internal LPO, but the device was already visible =
on
> the PCIe bus.

mh, I just tested again and I can no longer reproduce the LPO
requirement for PCIe detection. Maybe it was something else all
along (I did most of my tests quite some time ago).
Sorry for the noise.

-- Sebastian

--my2grf6ekzwdybt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmaqeUsACgkQ2O7X88g7
+pp84w/+KBmheZfpb0fRtyqgN36WgVqY9s5Gox0tnnz/NiXMcnTlgKuFpzHgWkPF
c+6p/y8tcZnKqx4cUzOUERWdqLKhv4Eg79XECqCfryltPVF5Ws1/Q3SKOH/mfIQM
392BAuZhrk0tu5OGir02czB0Am6yWsbsWNgmCqgK0HEPOdAOG635B0bgXe9Mao+c
b5MRSoDcMVIkm0N1I5HECk6fAojJfENfWHvHsT83Ehg8Jrkbbm/d9ddcbfw+Bd/J
ydUzMu+FZMLWQk6jr2ToB6Vtgjkoa5uTh4zjdIvsDP5gijQ31rQSQBEhCph1UONs
Ug9v3YVpQVZJ8zKXZYL3lelPVyUd3izhCB0pApRDXottaMSjzW7TjVT7YdDeu1mX
qjQlW5U/tiexec2NUsoKrCjXdpd2nh2rMbF08qCgjQLTqVaKThxILtN8I67DPn8E
ikV4rwXSLsnq6KKYLycJmSBRHVsMJTfwXF0OyNXi8ISNsdT1WTlUpYED/nLfyFxB
S6mkYaOFFHO+FqQ+uXWveskh235zEJLqq9XJdlpZlFfySI6D5TxaBbnfanCnrJsH
fUQD9szb1KuJ8RnvIIvYLX7Izl5IpHYo1lEeTIfLRCmDwtrCLEmcj06Q2cfOcaWz
FyEBLa7DmERYhwIvtWCzA8NTXM7j+gYmcNEM0Mia8d0MYIhYjFw=
=Uz9w
-----END PGP SIGNATURE-----

--my2grf6ekzwdybt6--

