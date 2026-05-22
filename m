Return-Path: <linux-wireless+bounces-36820-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NkrL0WUEGpSZwYAu9opvQ
	(envelope-from <linux-wireless+bounces-36820-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 19:37:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6705B85A3
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 19:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18A01306B4F5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437B637D124;
	Fri, 22 May 2026 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b="V1SSKAvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.bues.ch (bues.ch [116.203.120.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40AB37BE6A
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.120.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470864; cv=none; b=TXvn/hS8r41SwiHbYmymrGEbjXg4kHgKIP+5XKbjznfoMbuVQl9AvSh5NA5GswOBuOqWTXwjKv9K4yrpiig4LAp2mOArpqWH4estkwfaWr+Sz/PsL5aQ7oaWT2NB3sQrn2XxpWmYvxV6aD/9HKH/7kwbHNH3ZUUIvt3UvYKaCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470864; c=relaxed/simple;
	bh=wi1PP2b9lg2uO06/qGi7T4qMIv8H39CSgzlq7d8fsC4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Dd5Y8DFfHS+NRdwqRvLyNDZV7n9wUFxPotFqgZDQYlSLaRmlX4emWlYTm0Zji2NFzMAj3HcvsxKdX8PXR232kx1K1XF8+SmHcPOmyKmyTXz4tc47MxdRj2qQpZgdXLxhxEFlk9CqF8o3+AeQdUwnWXWeP0vBv5Z65vGoMNZGzFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b=V1SSKAvL; arc=none smtp.client-ip=116.203.120.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Date: Fri, 22 May 2026 19:26:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bues.ch; s=main;
	t=1779470854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=wi1PP2b9lg2uO06/qGi7T4qMIv8H39CSgzlq7d8fsC4=;
	b=V1SSKAvL6jinSYzDkqg4XI9mYGRjMhncmjRCL0dphWiNSu9aqHPgO95lMCYKubEiLfBgNs
	iLt+nmXzWay4SOg4JNbSMfGmNQF1JLIOiNK4qhHXjbrFb1gbQbofanvty4ejBS+Lhc7PyP
	ImGHCt04USbaoIcQfK2MXWe3Uyay3cM+LgVDukX0MDmVDccEeUr1gJ502y1AVWBKzxafgH
	zPsSup16k/dyjEcmQoT9hC8BOSQ8xjCeYZM+6btpH95dbBDUB/5dPAOrTaEu+ocL1P+sEU
	ISGP7WIcd7rww3EZb3k59kd2z6jG/+6hDKDvo8eNC8LXkYwkjvUEOYa085nrTA==
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: b43-dev@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: b43-fwcutter release 020
Message-ID: <20260522192635.6fa6f7e1@barney>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ee6ETjVos92Druhzf431Bpw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spamd-Result: default: False [-3.05 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[bues.ch,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bues.ch:s=main];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36820-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[bues.ch:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m@bues.ch,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bues.ch:url,bues.ch:dkim]
X-Rspamd-Queue-Id: 3F6705B85A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Sig_/ee6ETjVos92Druhzf431Bpw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

b43-fwcutter - Firmware extraction tool for b43 wireless

It's been quite a while since the last release and a couple of changes have=
 piled up.

The release consists mainly of some new extraction lists (thanks to all con=
tributors!)
and compiler warning fixes.

https://github.com/mbuesch/b43-tools/releases/tag/b43-fwcutter-020

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/ee6ETjVos92Druhzf431Bpw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmoQkcsACgkQ9TK+HZCN
iw4AZQ/+OlEQ1W0LnnkxOeEf6Xv3E84EVc7w627yQYjwyJRVZJU0O6nRem4V23Rn
OvCOATWTSpRUSXtn2wDuummxgO+JVJrJ0ZDiJLgbb5gUctCWVnAGTjs+m/FqRWyZ
6M6i0Xo6SgzTBqgs8iFYU1UQ+kpF4TXFUVxCVgclP6wnij9MV2E4+HCFRTEYgAz2
Gec1maUjvkrv2d0tF7P5qkKk/jSZZ4r77PocrjLXBrqT1RrRXYSJY06ap6GfiEcu
PKC0bRB3g6s3jys1/rkjtzMdTXtmlFxi5dZWr7WJKvWaRxw8YCa2Zgg9Y54u2rSY
hY0JkEDojThdHJvEvTzD94E49kvWoV9yugx+FGqFRHKhdm6bh4bu9dU1ksI/wvW+
uUwVQ1wC6kXRryHZ54GUwYdhDRjls1qVQH3Re/w59ERkGYmLxF1JGsdxNSCnxc0C
/R7Cd+RKLkBAZGpVzmDJpX68XyLYMgjrdjDHEo98eosEUyNY1iCnTVn59/an/VPA
MXVrTO3tdoNslcIjNgd4ZjOBIdWTldTlOn/TyAM7cUjtb4L4z9jBsiby07ER4pOF
U1yRSVK/KBnB4PhBlaa4YtYzAeZJed9sgre0O868N9NOMc2Qz/8ZdpHeu9U/0jYZ
UQEoLPR5V4CJnVh1DTwCzkiBzQ8wLGWCz+2kZGppDRK/jIVE22k=
=kvoY
-----END PGP SIGNATURE-----

--Sig_/ee6ETjVos92Druhzf431Bpw--

