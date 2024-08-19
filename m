Return-Path: <linux-wireless+bounces-11635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8BB9575B5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 22:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E76282398
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6E2158DCA;
	Mon, 19 Aug 2024 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ML3pU1kp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC02158A09;
	Mon, 19 Aug 2024 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099641; cv=pass; b=gBrRicwGEIcqhUHm6Bgwj3+1JlJy/zYJpN9O/Io3tJOWYCoyuXa9cxMx1ICLrFc1fRvNxHXkCnQghZOvFzb0COq5D9hMjbI9wLBPSi/DjE5W+2tctrppOja9SXE5LPPTN6Aezk5FWE5T0nhM4xaiww/ikIKcpTn3dju0tZ8KE0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099641; c=relaxed/simple;
	bh=FMIpa4swUiJlJeOECWbZrRU6dK2ymdZbCfev20eDAXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7t9w4BSzJe2u+J/O2oYnh1+N11sqRtIuLRuXEZY9k65GppRz5eP8FgrkN4wGHBxrn+fzmt69BcD3uV2H6blpOE8Xp7aB2u0TMl8Vdf4+sYV/gk4NyrY/kdbZ87yUzcutVJZDWpYS14uduGlUsfAJbSieaPr/PL97YoOrPtPifA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ML3pU1kp; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724099597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ep8EAWCuVkAP+X3TRh1fF/Kba0IPeYgKLHju44iCgVqsyRQUQlFo82vf573+4u/0ne0r73KGG/0/G7/9Mg61HYaVTF9ehycZ3ktbZZOAAonr4lvoyhbaM51lI0rh0n3r9E/2lCsODLHmbtV5cI4cTFtpnfg4F1ENdgj0ClpA1jU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724099597; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mk2cAEGzILC7tDRXUVAiWcCKesc9c/swlOrflT09qzc=; 
	b=I+8XW4LcmIsdpYn8P34Xj/6N40PIC5PpRK0LN5/FE4lTQnax2RkfM8U9OlsqgF5DvsRWdC79UQvH4GBeiuvHjWqp6XSWsHijQ4/3LTOabxfmIU9D4dUdPlJug4BsMIBWxJGQFI9d3/j2553ztrRuHlhGvWMiKbi5LQ54sWsOs/s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724099597;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=mk2cAEGzILC7tDRXUVAiWcCKesc9c/swlOrflT09qzc=;
	b=ML3pU1kpd6uUK235r2TPCZnf2prEsIvDJByLmKTHP7T4Guqf0z6SAVTYt8KqR6J9
	LciPUvMZuPPXjeKJGA/Xkr36NsE5P43dGxqjICVO5dTBxmy0PXXi5vZPDtCV/Zgbw7f
	qRPB5Rdd9j0pBUZcNBt3FF4reBEkcj99UCocog0g=
Received: by mx.zohomail.com with SMTPS id 1724099595555476.38217330976886;
	Mon, 19 Aug 2024 13:33:15 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id EFD8B106045A; Mon, 19 Aug 2024 22:33:07 +0200 (CEST)
Date: Mon, 19 Aug 2024 22:33:07 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: jacobe.zang@wesion.com, bhelgaas@google.com, 
	brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev, christophe.jaillet@wanadoo.fr, 
	conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org, 
	duoming@zju.edu.cn, edumazet@google.com, gregkh@linuxfoundation.org, 
	krzk+dt@kernel.org, kuba@kernel.org, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, megi@xff.cz, minipli@grsecurity.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, robh@kernel.org, saikrishnag@marvell.com, 
	stern@rowland.harvard.edu, yajun.deng@linux.dev
Subject: Re: [PATCH v11 0/4] Add AP6275P wireless support
Message-ID: <xc5226th2sifhop3gnwnziok4lfl5s6yqbxq6wx4vygnuf4via@4475aaonnmaz>
References: <uzmj5w6byisfguatjyy2ibo6zbn7w52bg2abgf7egych7usv6j@ec4xdmaofach>
 <67d67f15-4631-44ba-bc05-c8da6a1af1bf@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gns3fuhyhqprnogt"
Content-Disposition: inline
In-Reply-To: <67d67f15-4631-44ba-bc05-c8da6a1af1bf@broadcom.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--gns3fuhyhqprnogt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Aug 19, 2024 at 09:35:12PM GMT, Arend van Spriel wrote:
> On 8/19/2024 6:42 PM, Sebastian Reichel wrote:
> > I tested this on RK3588 EVB1 and the driver is working fine. The DT
> > bindings are not correct, though:
> >=20
> > linux/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: wifi@0,0:
> > compatible: 'oneOf' conditional failed, one must be fixed:
> >=20
> > ['pci14e4,449d', 'brcm,bcm4329-fmac'] is too long
> > 'pci14e4,449d' is not one of ['brcm,bcm43143-fmac', 'brcm,bcm4341b0-fma=
c',
> > 'brcm,bcm4341b4-fmac', 'brcm,bcm4341b5-fmac', 'brcm,bcm4329-fmac',
> > 'brcm,bcm4330-fmac', 'brcm,bcm4334-fmac', 'brcm,bcm43340-fmac',
> > 'brcm,bcm4335-fmac', 'brcm,bcm43362-fmac', 'brcm,bcm4339-fmac',
> > 'brcm,bcm43430a0-fmac', 'brcm,bcm43430a1-fmac', 'brcm,bcm43455-fmac',
> > 'brcm,bcm43456-fmac', 'brcm,bcm4354-fmac', 'brcm,bcm4356-fmac',
> > 'brcm,bcm4359-fmac', 'brcm,bcm4366-fmac', 'cypress,cyw4373-fmac',
> > 'cypress,cyw43012-fmac', 'infineon,cyw43439-fmac']
> > from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm432=
9-fmac.yaml#
> >=20
> > It's easy to see the problem in the binding. It does not expect a
> > fallback string after the PCI ID based compatible. Either the
> > pci14e4,449d entry must be added to the first enum in the binding,
> > which has the fallback compatible, or the fallback compatible
> > should not be added to DTS.
>=20
> Never understood why we ended up with such a large list. When the binding
> was introduced there was one compatible, ie. brcm,bcm4329-fmac. People
> wanted all the other flavors because it described a specific wifi chip and
> no other reason whatsoever. The PCI ID based compatible do obfuscate that
> info so those are even less useful in my opinion.
>=20
> > If the fallback compatible is missing in DTS, the compatible check in
> > brcmf_of_probe() fails and the lpo clock is not requested resulting
> > in the firmware startup failing. So that would require further
> > driver changes.
>=20
> Right. The text based bindings file in 5.12 kernel clearly says:
>=20
> Required properties:
>=20
>  - compatible : Should be "brcm,bcm4329-fmac".
>=20
> In 5.13 kernel this was replaced by the json-schema yaml file. The PCI ID
> based enum which was added later does also list brcm,bcm4329-fmac so why
> does that not work for the compatible list ['pci14e4,449d',
> 'brcm,bcm4329-fmac']? Looking at the compatible property in yaml which I
> stripped a bit for brevity:
>=20
> properties:
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - brcm,bcm43143-fmac
>               - brcm,bcm4329-fmac
>               - infineon,cyw43439-fmac
>           - const: brcm,bcm4329-fmac
>       - enum:
>           - brcm,bcm4329-fmac
>           - pci14e4,43dc  # BCM4355
>           - pci14e4,4464  # BCM4364
>           - pci14e4,4488  # BCM4377
>           - pci14e4,4425  # BCM4378
>           - pci14e4,4433  # BCM4387
>=20
> So how should I read this. Searching for some sort of syntax description I
> found [1] which has an example schema with description that has a similar=
ly
> complicated compatible property. From that I think the above should be
> changed to:
>=20
>  properties:
>    compatible:
>      oneOf:
>        - items:
>            - enum:
>                - brcm,bcm43143-fmac
> -              - brcm,bcm4329-fmac
>                - infineon,cyw43439-fmac
>            - const: brcm,bcm4329-fmac
> +      - items:
>            - enum:
> -              - brcm,bcm4329-fmac
>                - pci14e4,43dc  # BCM4355
>                - pci14e4,4464  # BCM4364
>                - pci14e4,4488  # BCM4377
>                - pci14e4,4425  # BCM4378
>                - pci14e4,4433  # BCM4387
> +          - const: brcm,bcm4329-fmac
> +      - const: brcm,bcm4329-fmac
>=20
> This poses a constraint in which the last string in the compatible list is
> always 'brcm,bcm4329-fmac' even if it is the only string. At least that is
> my understanding so if my understanding is wrong feel free to correct me =
on
> this.
>=20
> [1] https://docs.kernel.org/devicetree/bindings/writing-schema.html

Your proposed change should work as you describe. But it will result
in DT check errors for some Apple devices, which followed the
current binding and do not have the "brcm,bcm4329-fmac" fallback
compatible:

$ git grep -E "(pci14e4,43dc)|(pci14e4,4464)|(pci14e4,4488)|(pci14e4,4425)|=
(pci14e4,4433)" arch/
arch/arm64/boot/dts/apple/t8103-jxxx.dtsi:           compatible =3D "pci14e=
4,4425";
arch/arm64/boot/dts/apple/t8112-j413.dts:            compatible =3D "pci14e=
4,4433";
arch/arm64/boot/dts/apple/t8112-j493.dts:            compatible =3D "pci14e=
4,4425";

I guess patch 3/4 from this series will also introduce some
regressions for these devices by moving the check. What is the
purpose of the compatible check in brcmf_of_probe() in the first
place? Can it just be dropped?

I see it was introduced 10 years ago in 61f663dfc1a09, probably to
avoid a spurious error message for systems not having the IRQ
described in DT? The current code exits quietly when none of the
optional resources are defined.

-- Sebastian

--gns3fuhyhqprnogt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbDq/wACgkQ2O7X88g7
+pp6ERAAlqr3X4QlCBWjoUyZqN3E8yPe/Ud9tonie+Snj1L6XDqOKy7bAXqSBXc1
kHS5F0zEKgcn81wyF9FlIxQHT1r482Qt8wrlqZROT/7M3imKrgF6D3kCGT5E0BCr
2gkjHIE6QG8/i26Z4tdopRN+7Yj1c77g7HOU7l5iKBeRxrIjKMkUADmymQ55s2Z1
ly7qTrfHcsoYc6//K3hRrDFk1CGS/gwfZ/HBGiAqKbTYig0HJ9BojmrBYzszG5WL
i/SjhdIK2G/3bD9kVOvIZZNm80RTpBLywvSXeMDT7Q6Lrs+dy8ekU7Nyc0Y1b5Gy
/5jAni1HhlM185zhg6adFBGYVHM05hFGnQ/3G4+jMA3g+AU+gWWBeGt31Ft/UVrw
SfKJj17OBazzhx8mdBkE1VqUNLR5DC7DQIB7GtNd6pKi2XugrU4AHtydiK0NkAg4
nBRocei2fJoD/a9Dw8TL9Wj3X+bcaO18IXOrqNXl0Qa9BSwUyenI537aWdL/XvAW
bbs5rr+GyZMRkRIjGgdUo8LMxVpnutRXxRtbaWklNm4RlsuWaORIUY+8FAOIwF8T
DFXWjZ/eAXBrhCDIiIx1GEzHePgl2/h6m61VeltvF/9ix0P2Dj+jra9lm5/E+wi1
nlynKg+25redhcq0g4tvbuYd5eeduz3OX8CDUC2Ekyq9OmYRpwE=
=/l9m
-----END PGP SIGNATURE-----

--gns3fuhyhqprnogt--

