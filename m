Return-Path: <linux-wireless+bounces-38619-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lxaoL1hCSWoLzwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38619-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 19:26:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FF4708176
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 19:26:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=posteo.net header.s=1984.8680eb header.b="Tghe0cY/";
	dmarc=pass (policy=none) header.from=posteo.net;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38619-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38619-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1374830158B3
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100F374A0C;
	Sat,  4 Jul 2026 17:25:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6735E1B1
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 17:25:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185928; cv=none; b=gr+8QxOdmkoWSQ+ECdMO+tbNXPNAQ61R+fDwJxbkHdFrVnPvCPtdYXbMmTz1rEi5Jae8wRezDCAZtZ/C5iuz9iP9dOW+UD+DpM9QpBPq1EruRXxE3WX4FJVT/9Vsof6ubwamBRsfeyJYQTDumrFpXJ3VX/WQyfeDIe8U/tLBEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185928; c=relaxed/simple;
	bh=Mnr3ZPzwj/dlBlpfVl0nKXm6g9WnUs0l4kKGMb9oNDM=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=aBKGmCbteMq6xuQYwKAHAnxtCW0cFPTdcxaGv+5I40irY2pWCzm+wyRP0N+w7xCQE7LGoSeY45E546l1UeQke7WIzVIPyqnaoZ9PpIzv+aD75gJCDiqzSW90lOLOk3DKJBIrseQbUGMsJXynXxai0eUuUzlDI4BT8HGLJ+c0im8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Tghe0cY/; arc=none smtp.client-ip=185.67.36.65
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 47134240027
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 19:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1783185918;
	bh=Mnr3ZPzwj/dlBlpfVl0nKXm6g9WnUs0l4kKGMb9oNDM=;
	h=Message-ID:Subject:From:To:Content-Type:Date:MIME-Version:
	 Autocrypt:OpenPGP:From;
	b=Tghe0cY/B3eveyZoD+BqQa4kAZcXLIm91BZ/OAj+ZzqFUSyDrBsNGH4PUNmhZ1hs9
	 alDr/Dj5RdGtJtyQYkitqj8NNUbw+2sflBHMT30W80WWLQECKUtV8wjj6KbVOfa4sX
	 cZSlVGJym47z3gOB6HcdOSY48moTvIXX4unk8Tjz4gCh6yUgPF1k5raiyx2vkC3P5t
	 ynpmH7TRzBCLaDz6WRe6foI75TO6vsEiPCGatGdYE4co01IdyQmVwRSTixcbIhD3wW
	 2ybJU7/yc0PGzim4WIo8aP+yoFH7rix1PxsJX9tqR/5S6QENBRpWBcEOxqSLzVJ2bl
	 xCBvYG79Ig70A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gsyDs1GC6z6twf;
	Sat,  4 Jul 2026 19:25:17 +0200 (CEST)
Message-ID: <c2163c6ee67e982fd95d1f965ecf0b853f687214.camel@posteo.net>
Subject: Re: Atheros AR9280 / AR7010 Initial low scaning signal range
From: John Scott <jscott@posteo.net>
To: cybersnow_2001@tutamail.com, Linux Wireless
 <linux-wireless@vger.kernel.org>
In-Reply-To: <OwQQjLm--J-9@tutamail.com>
References: <OwQQjLm--J-9@tutamail.com>
Jabber-ID: me@johnscott.me
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-2O5rGxiky6//Yp4Q3Krp"
Date: Sat, 04 Jul 2026 17:25:18 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=jscott@posteo.net;
  keydata=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
  2Bms0A==
OpenPGP: url=https://posteo.de/keys/jscott@posteo.net.asc
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=1984.8680eb];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38619-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cybersnow_2001@tutamail.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[jscott@posteo.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[posteo.net:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jscott@posteo.net,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,posteo.net:from_mime,posteo.net:dkim,posteo.net:mid,tutamail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3FF4708176


--=-2O5rGxiky6//Yp4Q3Krp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 04:08 +0200, cybersnow_2001@tutamail.com wrote:
> I've read in another forum that people experienced the same issue after a=
 kernel update, maybe after 6.8. What do you think?

I think I can partially reproduce the problem. I have a Sony UWA-BR100 on D=
ebian Trixie (kernel 6.12.94) and a wireless scan only shows very few acces=
s points, never more than -65 dBm or so. The access point for my home, bein=
g the closest one to me, actually has the *worst* signal strength value rep=
orted as -80 dBm consistently. A scan for access points does show 5GHz ones=
, but it chose to connect to my AP on 2.4GHz (which may or may not be legit=
imate; iwd normally joins the 5GHz ones when I'm using dual-band NICs). I d=
id not observe any circumstance in which the reported signal became better,=
 though.

With a TP-Link TL-WN822N v2 (still AR7010, but the 2.4GHz-only AR9287 inste=
ad of dual-band AR9280), everything is excellent, so indeed it seems only t=
he AR9280 devices are affected.
Could you share that forum link? I'm not sure I'll get around to it but my =
next steps would be to bisect the kernel using a virtual machine and USB pa=
ss-through. This is strange indeed...

--=-2O5rGxiky6//Yp4Q3Krp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iPsEABYKAKMWIQSiPzylvTnZ6xisfzWz9N0oYfTNugUCaklB9XIYaHR0cHM6Ly9q
b2huc2NvdHQubWUvLndlbGwta25vd24vbmkvc2hhLTI1Ni9zWUF3OTN6QUVrRkIy
RDREM1hOemRSeHEyMFBjNnByZGdtbEVWeXo0QUZRP2N0PWFwcGxpY2F0aW9uJTJG
cGdwLWtleXMSHGpzY290dEBwb3N0ZW8ubmV0AAoJELP03Shh9M2651QA/1V6GeSJ
5n9S+gbSe5g5xVpfHI73eUukxU+CcGe7KHQMAQDed1bQmX/5OBHpi6h/GUhebBj/
1lh5vMwf309P5sXQBQ==
=JuGN
-----END PGP SIGNATURE-----

--=-2O5rGxiky6//Yp4Q3Krp--

