Return-Path: <linux-wireless+bounces-36887-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL6SF6KRFGrnOQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36887-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 20:14:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B46AA5CD95B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 20:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7D303025719
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8543F5BE3;
	Mon, 25 May 2026 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b="bZbyYGXJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.bues.ch (bues.ch [116.203.120.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42F3537F5;
	Mon, 25 May 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.120.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779732873; cv=none; b=YGOAfyU8MCeP0F+uEbs9/gQrtfhrWc8WFLs3ZUrA47deMW64StyGsuuxn1zqAnhhMgvTY1MEdHvGAPflPHkR/YTOGxnsOk7OdGYkeyuJnx2AvAEej5XFFhJW34jLrdhEJo/cJ8813k2g9kD5M7VH1EB9rbOrh1aoqWVNbQgip9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779732873; c=relaxed/simple;
	bh=0WA2do2ECCCRZbPd27JoUNSPxv+tcgUGqeDNxEx3+EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2PEG/ZMRrapvKCPXo9c8rS/IIg15RTHyX2GFqDw1g0EmySddhGTgtfJqDeiyVqpyvSWaqlvV1UwjJhGAmwvHXkKHd7MKlxH1h9BeSp+DPd4IURSoty5Zm7E756P3jbXn+M80vB1+0BDWbudnE60jM0Qw4C9PFL4bv+6lGgDcZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b=bZbyYGXJ; arc=none smtp.client-ip=116.203.120.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Date: Mon, 25 May 2026 20:14:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bues.ch; s=main;
	t=1779732869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WA2do2ECCCRZbPd27JoUNSPxv+tcgUGqeDNxEx3+EQ=;
	b=bZbyYGXJsQNMNGNk2BdYmHRyHzcPQ1QtXvX8JBiBc1tygHDK/weZFmRfU2kmzAm2rWCwkc
	M8MQ1gF9/QbhHV07ut870FA/yYcuNGgSnHPe3Wuze8UowjxZ4H5SNpc2o27TIdXJpbpY3Z
	7akFqDeTevF/DzQtfo7/FUHsgoN/bOvY9BJ9hZN1WglthjOpw3uAypFnqwlRTdyQqOQjTv
	FovlMeHWP9Uf6tDzfNnSxkTVRbPEVMPuvxCRTeMK3rRNQxy4yQRY7yPBEJTLk1sm55fxzy
	sdIdGmlszvbf4gGwv7BMhUrYVxn/g0jF9hL2MekEvuIQ7ZAG6r7xV+Z0C/98pg==
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alessio Ferri <alessio.ferri@mythread.it>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
Message-ID: <20260525201405.6c60420f@barney>
In-Reply-To: <20260525140438.265975e7@fedora>
References: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-0-cdad2c8526c6@gmail.com>
	<20260525100752.16cdb59e@barney>
	<20260525140438.265975e7@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.MYp7wzPblDhh=wv0hor/qw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bues.ch,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bues.ch:s=main];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36887-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bues.ch:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m@bues.ch,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bues.ch:url,bues.ch:dkim]
X-Rspamd-Queue-Id: B46AA5CD95B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Sig_/.MYp7wzPblDhh=wv0hor/qw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 May 2026 14:04:38 +0200
Alessio Ferri <alessio.ferri@mythread.it> wrote:

> Please clarify "full expected wireless throughput", HT is
> not supported by b43, so it runs only with NOHT in g-like speed:

> Enabling HT for N chips is out of scope, also there nothing to
> gain and a lot to risk, so i won't do it.

That's fine.
Just wanted to know if there were known problems.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/.MYp7wzPblDhh=wv0hor/qw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmoUkW0ACgkQ9TK+HZCN
iw7hQRAAwWCeB2FMbkjfyCYyLJYKhQqWf8RHho76CgqYNVazM/pyfwQ0any2pUHX
NMdJvIuDlMRMmYLWulKlFlOZpQpq8tzbscfJQZpjhfJQoX4BqZXaLeWaT9Vx/iq7
6MgHMms7EY/FSPigQj93h7OToAJq2UYeaFppph9VAFT6xixqjDhG0fRJhiqss4AJ
MzC+zJCqepH5PUEiKuOF0RQU+z7lv3fCsZkbebprysSkKmGqmqlJ/sSbGW9CUtz/
YzYkBFSaS2eEhMYxFDP8ZBLQ3N0U0KOZICTtEfRDhRV+jH7E6jSW5UeQ9xe7XoOs
81pHPVvgVlL9kpGJEnHjoitUbF9HG/+Z6hEcSqRBAa7+Hc8XI6/NT2lpOYvHPgyf
3CPd5yoCuaKwtZvZxGDO4HEFVvqFSWqY6JIVkTxx/gDg26fjV7MD+Yk89waHVglf
EjGDgwJ6IRk/5iTt0B+bQIIhWq0KHtlITtrPAXd5xNecMfaO0zhnhBCT9ktGGFq/
e18h8EWzFZbgXRBTupY/bOvhEtDOjXUUwRQ75etDvw/gXO/61G3D+eV6BS5KfnX5
1VhOI9z3opZDVSq/mH583BNmRhGYzxre6p5TfE3vctrrS+shZf5uzd4Z/oA94Zee
EyoC4RGgvrmH0E6mgeZtlUxuQYgc836HcuwvtCPEfHjW0t9ljpA=
=tc0Y
-----END PGP SIGNATURE-----

--Sig_/.MYp7wzPblDhh=wv0hor/qw--

