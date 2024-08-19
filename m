Return-Path: <linux-wireless+bounces-11624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCCA957188
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 19:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A691F236F5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3B187FED;
	Mon, 19 Aug 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="HjpYOp9z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108AF48CFC;
	Mon, 19 Aug 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087069; cv=pass; b=jMdD2yEVQYFSAraJ6gi8cbD6ZQRAe0gt3HVivDTJXcKFOOVLpS/jrEGrOkiUIcyl3Oz9pUPTd06sz7qKDf+cczQnxRGGKSFcPZUhAYVCAIRxqQrYnBdoJdIWabU4VLM0HHLr8V1Mvk8GiniK3nqLkVwdTnGK1ExTe0wm9hg3nVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087069; c=relaxed/simple;
	bh=tvnBfqvPBRx+HDhCZhrrAy5UEzQvPjK5237fBaCqoVU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GKhMB9NuybmAffIq5mkxvbIi9WliIVzi7E/t3vAv47PxawCZgPBvWH+sBlvhfZuI6TgsVGXOLdTe4yZD1f09Asag7kplVnLAAtx6VjoPlG/ilWc8ife2B4AEOSVmwjCKUHKiptr/SqojptDn6v1VKSy1wng1eyy1u10q5qsdUGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=HjpYOp9z; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724087022; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n8uWCyB2elCluMJc278Nj13KMcZui0X3ZOO1H8htDvDly4zVwcZmPTja4DRogrv1m7coF5FuMzBPlaNGgdKXUaxNIyyzrgnoLZ/a9+SXkQaZKuCz8HC7se6peeXS8TAs/8rIa8IBDgNmCcoQy7jOgsg42fnD6n8zwkS8IytECDI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724087022; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tvnBfqvPBRx+HDhCZhrrAy5UEzQvPjK5237fBaCqoVU=; 
	b=Sb+Ut17tdpEUH5QwvchUTtzM3nGb3h0uJ+13RWci//0gsE/6tEWxcqiCLcmF+rH42Ha5afAe+eLs9OAh+67edlTfH5cAgnJifVAr2W9MIG9f/5rIMrrsUhjouV9qdweJLt+WQuFjeiOPbRvMwqeLPFz94COYVGCyyWX3V2PpzGU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724087022;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=tvnBfqvPBRx+HDhCZhrrAy5UEzQvPjK5237fBaCqoVU=;
	b=HjpYOp9zsUV49NoOMAqnIKdMup1IV7jYjX9XXTerc7pA0z6dPminm2YS/59p2p89
	Ok18E1GugjteLGxlUrNyIeNzOTpqve7f7AVNFc2m56ymMmOmgcIV3f/dGYcQu2k650J
	+O/SfV72GdDQkC7XhnXZxMf0CU5OgKlfBkYTIsaA=
Received: by mx.zohomail.com with SMTPS id 1724087019835273.7787678036623;
	Mon, 19 Aug 2024 10:03:39 -0700 (PDT)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 03A8B4800E2; Mon, 19 Aug 2024 18:42:43 +0200 (CEST)
Date: Mon, 19 Aug 2024 18:42:43 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: jacobe.zang@wesion.com
Cc: arend.vanspriel@broadcom.com, bhelgaas@google.com, 
	brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev, christophe.jaillet@wanadoo.fr, 
	conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org, 
	duoming@zju.edu.cn, edumazet@google.com, gregkh@linuxfoundation.org, 
	krzk+dt@kernel.org, kuba@kernel.org, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, megi@xff.cz, minipli@grsecurity.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, robh@kernel.org, saikrishnag@marvell.com, 
	stern@rowland.harvard.edu, yajun.deng@linux.dev
Subject: Re: [PATCH v11 0/4] Add AP6275P wireless support
Message-ID: <uzmj5w6byisfguatjyy2ibo6zbn7w52bg2abgf7egych7usv6j@ec4xdmaofach>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="of7hfoh4fqko6jig"
Content-Disposition: inline
In-Reply-To: <20240816020635.1273911-1-jacobe.zang@wesion.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/224.30.53
X-ZohoMailClient: External


--of7hfoh4fqko6jig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I tested this on RK3588 EVB1 and the driver is working fine. The DT
bindings are not correct, though:

linux/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: wifi@0,0:
compatible: 'oneOf' conditional failed, one must be fixed:

['pci14e4,449d', 'brcm,bcm4329-fmac'] is too long
'pci14e4,449d' is not one of ['brcm,bcm43143-fmac', 'brcm,bcm4341b0-fmac',
'brcm,bcm4341b4-fmac', 'brcm,bcm4341b5-fmac', 'brcm,bcm4329-fmac',
'brcm,bcm4330-fmac', 'brcm,bcm4334-fmac', 'brcm,bcm43340-fmac',
'brcm,bcm4335-fmac', 'brcm,bcm43362-fmac', 'brcm,bcm4339-fmac',
'brcm,bcm43430a0-fmac', 'brcm,bcm43430a1-fmac', 'brcm,bcm43455-fmac',
'brcm,bcm43456-fmac', 'brcm,bcm4354-fmac', 'brcm,bcm4356-fmac',
'brcm,bcm4359-fmac', 'brcm,bcm4366-fmac', 'cypress,cyw4373-fmac',
'cypress,cyw43012-fmac', 'infineon,cyw43439-fmac']
=66rom schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-=
fmac.yaml#

It's easy to see the problem in the binding. It does not expect a
fallback string after the PCI ID based compatible. Either the
pci14e4,449d entry must be added to the first enum in the binding,
which has the fallback compatible, or the fallback compatible
should not be added to DTS.

If the fallback compatible is missing in DTS, the compatible check in
brcmf_of_probe() fails and the lpo clock is not requested resulting
in the firmware startup failing. So that would require further
driver changes.

Greetings,

-- Sebastian

--of7hfoh4fqko6jig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbDdf4ACgkQ2O7X88g7
+pr5KRAAjDSIh+I777ZC2eOvfPG2PAsPfp+nGcsq2aP34vzqdrUy9Q7Rd9CDPPGX
7J5O5w7rLfSEHMRr8E6YaRtnDprVP3eLOKBriQQpfjRhcK9jv5CDjAHk7xkD80ya
k6B1k8pWaQ/OMJwCcFpZUyFs6WJZebEieOphbGXuPc81wLt7b8K19MFVXvd5CkuQ
dLLtdwNv0fjEw5rmGbLostKvW2b5QohkqRQDIip3VbK1mg9yKV/oqyvZtS0/YNob
gyqdI4GTzAwqayM+M28tQuaB/oAAqDNjTRHefPmNzGfbO2Ls8/nL1s3div+ckh0z
YEb0wKj23EjR2CslSYJWmkpG71w+sMdQ+ViPaxDCiD2r4plk7GLEQG0tpHr/Amgf
FnpJsNRtyaxdDdOsV2GCj9Y+n8k3M8S9z7FSszCqboDvIMvDx2kcnbKPqA3aPAiM
c5rb6iIwggiTqCxF1qBZbg7LGMZK4V19/5+Ifjg2+nKtlfepyvky9Hmka5SHp0Ep
dHJj1sZiW4qBy3mDfiqMyLaNR/NFq5z4XrwOBmT47ThjuV/SfUsGOeF1ZHapnDOi
gQcnZjkxafVeMvWCVTiyZBg4V38Daxp4hQJx37WyPFgWQr/1GA8gyK9bOH4bjz8R
9IpWzOlAhFgTRCGodl1GFD298gUSPv7CzGIpIIiURZpEHbdzFP8=
=jdlM
-----END PGP SIGNATURE-----

--of7hfoh4fqko6jig--

