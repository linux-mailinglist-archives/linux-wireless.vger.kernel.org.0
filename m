Return-Path: <linux-wireless+bounces-37900-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ZEILAUzNGocRQYAu9opvQ
	(envelope-from <linux-wireless+bounces-37900-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 20:03:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C6C6A20A0
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 20:03:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bues.ch header.s=main header.b=AgEqRZKK;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37900-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37900-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=bues.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA77E302013F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 18:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56270352021;
	Thu, 18 Jun 2026 18:03:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.bues.ch (bues.ch [116.203.120.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC334EF11;
	Thu, 18 Jun 2026 18:03:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805820; cv=none; b=fdrB1DpDIc7y3Vi/kJqrg7qPk1kZdMfO1xsNazO31kKpsyEDER63voxokGVFv7e3QClzox61p6p1UDwfOqX+7cKJbd5am3GB+PvmvP0mruhWRTQ4fQwQUpvJJRMlzvz2aYxuDK6P2IFileV2iZlWfjvNUt0oeJbWkS6HfgLDsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805820; c=relaxed/simple;
	bh=YRsztucoKe4JwjbdvU4Wjbx5zwXQ31uVCUcyCCX8Nm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOWxgq3HM6uLP1HTRI+OS1Hs6Nqef32Ej/2fTvUh638WDAxmNRJ1RyyjUDq6l+vsSM18/NcfAUQAwAMkctFhAWkiF7zkL5IXh5ge4SUsWpX4Y43T3NLLnFRfOjJfZURgB1/LPzw4JekQUB9w3mTzK9VfIjrfQWCbUDuOHiUkAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b=AgEqRZKK; arc=none smtp.client-ip=116.203.120.240
Date: Thu, 18 Jun 2026 19:57:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bues.ch; s=main;
	t=1781805500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf8+j9kDlIC5pkDl3pjv/qiQOKadn5JWHV7389C8mhE=;
	b=AgEqRZKKtpeSq3dFPD57xFhHMdEySYJDW/JT2zVQwjka4YZzn1YdZIa89TuvT0S9zKxACP
	KR2M9HNeHfYPRypfvXxDs+rLMlr7XJf09+X5rzmwX4hkjl95dncw3AspIZHph8a0kstV8E
	Zp6NyIOyfvJiuD1A3wXsVq9IO1EMbE85oWg34b4DcLbch3VVSozypP9cZSTkD1metj0wNE
	wbn/jsNv8OVJCOcIr2U7Ojornbja5Z79BB7kJSxXnf+YRJGG64HOn9QCaROSTw5B9A82zN
	5AEsImgoU/XQcg2gIDvb1U/M4h8lD4H6/xHX40cuuol1iqQh5XtmZH9h3XTIOg==
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alessio Ferri <alessio.ferri@mythread.it>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 b43-dev@lists.infradead.org, Alessio Ferri <alessio.ferri.3012@gmail.com>
Subject: Re: [PATCH 1/4] bcma: host_pci: add BCM4352 device ID 0x43b3
Message-ID: <20260618195714.5620e0ec@barney>
In-Reply-To: <20260617-b43-add-4352-wip-v1-1-c81323496720@gmail.com>
References: <20260617-b43-add-4352-wip-v1-0-c81323496720@gmail.com>
	<20260617-b43-add-4352-wip-v1-1-c81323496720@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jAjpHEYdavIonoaH4M5Uz/v";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bues.ch,none];
	R_DKIM_ALLOW(-0.20)[bues.ch:s=main];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[m@bues.ch,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alessio.ferri@mythread.it,m:zajec5@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:b43-dev@lists.infradead.org,m:alessio.ferri.3012@gmail.com,m:alessioferri3012@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37900-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[bues.ch:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m@bues.ch,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7C6C6A20A0

--Sig_/jAjpHEYdavIonoaH4M5Uz/v
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2026 23:42:08 +0200
Alessio Ferri <alessio.ferri@mythread.it> wrote:

> From: Alessio Ferri <alessio.ferri.3012@gmail.com>
>=20
> The BCM4352 is an AC PHY. It is missing from bcma_pci_bridge_tbl[],
> so bcma-pci-bridge does not bind. Add the ID.
>=20
> The chip identifies as BCM4352 (chip rev 3, PHY type AC); b43 with AC-PHY
> support handles it once bcma reaches the D11 core.
>=20
> Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
> ---
>  drivers/bcma/host_pci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bcma/host_pci.c b/drivers/bcma/host_pci.c
> index 3dc2985063f1..f6cf722a3798 100644
> --- a/drivers/bcma/host_pci.c
> +++ b/drivers/bcma/host_pci.c
> @@ -298,6 +298,7 @@ static const struct pci_device_id bcma_pci_bridge_tbl=
[] =3D {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x43a9) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x43aa) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x43b1) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x43b3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x4727) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 43227) },	/* 0xa8db, BCM43217 (sic=
!) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 43228) },	/* 0xa8dc */
>=20

Please submit this patch last, after the driver is expected to actually work
on the device.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/jAjpHEYdavIonoaH4M5Uz/v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmo0MXoACgkQ9TK+HZCN
iw79/xAApSa8gie6f7YYYepTM2teMOo7lqt5rKHR0iK5rWqhgF8kca4QFukgP0gs
Ijlj5yyGZ/HOVA5l7bE0BIpJ0bPvjQBwOSbo4xpzNLPVN9dnJbqNu+HLsXRYI9Ze
10c5h75tkEpYq5acGzZ8wmq2hKRWWe24u553qfMm+4QhTDdJF8l6dtp6cQqDDfWI
sUeyfThcdd8YwVBnrLVhHLLPlL1qru/6QMIX3yNuKu5aneI6h3GOMhrMJMz+UH61
rhYmA4wABTP2dnwkvwAjy52K/w0M4Ykg7RKiEyvisJhm10d4ms9i+SywApjNaTUh
hGI2dVBBiRSyWkKtfeVwGxu3fbMsU/rW0wwD/SAMkxgtfvYlROilVQRjwk7WCD7i
JDm8HXq0cfBR7qnPAKr8gN2VsPO3XAHtzRebQP+Ew/SHCoEi/SjFzVVltvQcHrcf
NdY9gIVYY+6qDeDiq2fzCT/rEWSLpEe4aTd2HeFqXn5n3CU3SAYkDUOhPmbuHASy
sZb6AsKSYEjtCNQ4wLLgOnG+v1KlSnXqi74Bm6beTrX19ABP/bekM5n3AMBqIN2F
CHT+6mNjr3PBp1erXEB7XUMZU7xxEaRfaUjtBdFAljdKdLADP8HaJytLcUkrYY8g
Nz5ubxeLP7YM5qulAa7+gI0Vs6kDzzl+YLUxp4ShveB8JBZicJQ=
=htaX
-----END PGP SIGNATURE-----

--Sig_/jAjpHEYdavIonoaH4M5Uz/v--

