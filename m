Return-Path: <linux-wireless+bounces-36863-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCtyH3IDFGquIQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36863-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:08:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE83A5C7746
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 976B430041CB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964323DB628;
	Mon, 25 May 2026 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b="KRG1fQQv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.bues.ch (bues.ch [116.203.120.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01453DB626;
	Mon, 25 May 2026 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.120.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696493; cv=none; b=CRb1AW9nWp7bcUqShRtoMyr25HPcD56qre/OQ2VDrL7qp+pOhZSZ2VvF9vfdmSnkEpFU8w7WaeNMrCLHfwqOXPMB/vKj0odJyWrU3WVzDid/w1LKgM76sDzmapFUeF0rdzDGFJDywllKBM8tXm+WvXZxPmd7E4SmmNMV1V6fXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696493; c=relaxed/simple;
	bh=nGU4MjUTgnIx/L/+8NOfdZRN3bLNzYYQG8Cg+uRwiuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qN09NG1tQK9QOJE4pJG1nRsnnljrswrU09EpHgGgSTff4KOAfNIXkFVrUofw3LAzCNkDvXR1x4+zBcivtQYC+o3hcC2ZJZf+b1V76sPPvcciUmj6vBJMmaxMp1xYfihMviC3r9fpm3usbYYhvrTPpiMNQGxdT4muCBRa6yS8Leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b=KRG1fQQv; arc=none smtp.client-ip=116.203.120.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Date: Mon, 25 May 2026 10:07:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bues.ch; s=main;
	t=1779696483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivGnYQGwHypA/E82Fk3MIbZRzRtPVXV32W0d+O471x8=;
	b=KRG1fQQvbcUtKDtnKxtLcBMpJiYpE8vHGCAWe47TVMfpBxnfn8LBp4I6b3kcdiU9xXjprp
	1Rv4SUh0qaK4VCChBCxwD9XGHo7rXdXOHMrf+BWNIqcHp23eZsYpnI2SP677gSussNpzqd
	0GU/LHoXD0mxCrMHJWIkq9nsxKPaK1ykVEEGo5tl1xWnU4n3u2aNDuSxguboPO4y3JP0dW
	5XoLE3ommyBi3hHkM+N+emUK4GdJO2LBtWKMgDW6MCG58hT8klghIa25+51BNuMLMTGJBy
	cyfeaVmIbpCLIfnKdSu7Vju1fDNAWdeVuuE2bp692JqHSD51jxxyzhFCdgxvGA==
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alessio Ferri <alessio.ferri@mythread.it>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
Message-ID: <20260525100752.16cdb59e@barney>
In-Reply-To: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-0-cdad2c8526c6@gmail.com>
References: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-0-cdad2c8526c6@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5s+bOMwc0HHsEDOgBDTv5Fv";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bues.ch,none];
	R_DKIM_ALLOW(-0.20)[bues.ch:s=main];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36863-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m@bues.ch,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[bues.ch:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bues.ch:url,bues.ch:email,bues.ch:dkim,mythread.it:email]
X-Rspamd-Queue-Id: BE83A5C7746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Sig_/5s+bOMwc0HHsEDOgBDTv5Fv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 May 2026 23:56:17 +0200
Alessio Ferri <alessio.ferri@mythread.it> wrote:

> Alessio Ferri (7):
>       b43: add firmware mappings and remove comments wondering about rev2=
2 initvals
>       b43: add d11 core revision 0x16 to id table
>       b43: route d11 corerev 22 to 24-bit indirect radio access
>       b43: support radio 2057 rev 8
>       b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
>       b43: add channel info table for N-PHY r8 + radio 2057 r8
>       b43: add RF power offset for N-PHY r8 + radio 2057 r8
>=20
>  drivers/net/wireless/broadcom/b43/main.c        |  22 ++-
>  drivers/net/wireless/broadcom/b43/radio_2057.c  | 230 ++++++++++++++++++=
++++--
>  drivers/net/wireless/broadcom/b43/tables_nphy.c |  58 ++++++
>  3 files changed, 290 insertions(+), 20 deletions(-)


Looks good and in general low risk because it doesn't change any code
paths of supported hw revisions.
I'd still prefer if somebody could test this change on another supported 20=
57 radio.
I don't have such a device unfortunately.

Does the D-Link DSL-3580L work with full expected wireless throughput after=
 this change
or are there any remaining known issues?

Acked-by: Michael B=C3=BCsch <m@bues.ch>

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/5s+bOMwc0HHsEDOgBDTv5Fv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmoUA1gACgkQ9TK+HZCN
iw7YQA//ds+rSVNTrHzM08KTsGl/0w5pEIUYEWH7cA8MialR55T3d6B+CEbbvegD
x2x5YGn20qP9nXHcWf4zt4IE23lRVo/Xd7htUAJv3KSU5reuwWUa9XAFQE56kjXZ
cU8bPESMlNk8Redqzxdcq2osLxsZ1MmTTXdjPJZB/TWLovGN+ZKNik8BeM1n9IYj
Hq37z99Y3aUBx6le6TkcqRnt98KdE27thlMU0PM7ucSAUGVQ3NJC9BlHvGvlMR32
lKToR5PKPKm11Yi1WwphYdilzxpUgxwuCN0vE7DbE3ZUTNJKYHUiEGlwTD1xO8qA
LLMgLIN7oIrKBnArD1Kro/z5w8Mccg7/d/mMgjUpKeEWzmUFe50poH2lKRmryoGb
NALzix/c6XSpcaNvZ9u85X+cKSLKdiChwHXmu+MNvtrKUw5i5Crr8qOtPrSkxzCq
K5FZUEvY/op/z8NkDmwaGkEqthUSrHCokEOIufOCIWMV8W3sxKlojBhQHXSwdDFi
iXJSZuXnkMcYoaPQFPnEmIM7KN1l3LrM96FDWDmHcoRCGFJkEHQkyzphHxKdjo3Q
hIQT8WwACvoTiJUCZ+EiuCSZ3Y6fYxEAmgV++a9S5rzqSiKyLwwJt8zo2Nay6hdK
W4MTceg4dllkP+H4koQ3V7jvGFyX8cm7K+pLM7PT0jinf6cfMxk=
=ukAu
-----END PGP SIGNATURE-----

--Sig_/5s+bOMwc0HHsEDOgBDTv5Fv--

