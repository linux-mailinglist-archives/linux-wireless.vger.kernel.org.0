Return-Path: <linux-wireless+bounces-36671-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePkKJKXADGqJlgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36671-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 21:57:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDB55845F7
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37EAE3019521
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 19:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B754A3B3899;
	Tue, 19 May 2026 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b="EwgavCyl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.bues.ch (bues.ch [116.203.120.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7B3ACA42;
	Tue, 19 May 2026 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.120.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220421; cv=none; b=OZh3TC+K4F2XmWvsMynRMJaJPqmrHpd4P5HbfJbcs7x7uiErRaLO31DbDeTaUJZIyrj964yutOZry9B0ajpWzWYrCQgYBlShIDo4mBnVNy/BWVjtL9XknFNJO7hhGh8eXpbsRIJYlrEr+jscruDgY/4nnnzje6oWmGb0yKkH/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220421; c=relaxed/simple;
	bh=mc9PbFolJ0S6yow5K8RQZ49f9a+i9DZSo9lEMLBzbx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAZoDUOhj8ZUDpLr0DSzdwf3kRUY/iOtSjJ2W77/d7swe/YUjEQFHp4Q5nDFEMt9mryyNKfhQBBEz56PQQnLFXrU/7MYJdlSoOTLZElvwsdUu8TGq9DwBIwer045iic6ZVsKVYx0n7TjkPSxEFh7GNvr72d5pi+5qKABpuehtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b=EwgavCyl; arc=none smtp.client-ip=116.203.120.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Date: Tue, 19 May 2026 21:52:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bues.ch; s=main;
	t=1779220418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mc9PbFolJ0S6yow5K8RQZ49f9a+i9DZSo9lEMLBzbx8=;
	b=EwgavCylZ2ofil/aycf5Cdg64mL6uk5f5YNdXGQ5XYK8qq7BoNg/74zlz8nANhoexAAIoM
	9YtOiHFP1MGiwvfrRYS9W3L7h1k3/+lTh+LwuC5Wes88jfGkAgBSgxJTUne3EC5VVKgMrR
	bEKVY47DrtnLr1usZ/iKSNEeA2tm57C42foEzLyyf218sTqyZKlI/ElXmiHezyEywFki42
	mHNDfW8WwY6etKfgz0bMuJqhugx2sQ10xgHXGkXF6up6QxTyIbdwM4CYyciOOqcpT71ZDE
	exHfxwrFPXQJR2VA2RhvoSDNssquD5j2ARr8sdogeoX85QjHxOF1D0gGpIViVw==
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: "Joshua Peisach" <jpeisach@ubuntu.com>
Cc: "Alessio Ferri" <alessio.ferri@mythread.it>,
 <linux-wireless@vger.kernel.org>, <b43-dev@lists.infradead.org>,
 <kvalo@kernel.org>, <linux-kernel@vger.kernel.org>, "b43-dev"
 <b43-dev-bounces@lists.infradead.org>
Subject: Re: [PATCH 0/6] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
Message-ID: <20260519215244.2a0d2b29@barney>
In-Reply-To: <DIMWK04RLFCG.17KT0R0YCUMRW@ubuntu.com>
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
 <20260519175812.7ce97ba1@barney>
 <DIMWK04RLFCG.17KT0R0YCUMRW@ubuntu.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ya/n0a=Cznl2sfj19DrTnxn";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spamd-Result: default: False [1.74 / 15.00];
	SEM_URIBL(3.50)[ubuntu.com:email];
	SIGNED_PGP(-2.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36671-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_POLICY_ALLOW(0.00)[bues.ch,none];
	R_DKIM_ALLOW(0.00)[bues.ch:s=main];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bues.ch:+];
	NEURAL_SPAM(0.00)[0.356];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m@bues.ch,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ubuntu.com:email,mythread.it:email]
X-Rspamd-Queue-Id: EFDB55845F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Sig_/Ya/n0a=Cznl2sfj19DrTnxn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 15:32:44 -0400
"Joshua Peisach" <jpeisach@ubuntu.com> wrote:

> On Tue May 19, 2026 at 11:58 AM EDT, Michael B=C3=BCsch wrote:
> > On Mon, 18 May 2026 03:49:33 +0200
> > Alessio Ferri <alessio.ferri@mythread.it> wrote:
> >
> > In general this looks Ok.
> > From the style I assume that this is AI generated, right?
> > If so, can you tell us a bit more about the inputs used for the AI?
> > What information is this implementation based on? =20
>=20
> So... awkward question.

Why?

> Wasn't there just a conversation[1] about the
> future development of this module, that was left off at "don't touch it
> unless you're going to thouroughly test this",

Sure. That's why I ask about the development methods used.

> and now we are going to have a *LLM* work on this?

I don't care whether code was generated with an LLM or not.
What matters is the development methods used.

Changed must be based on actual correct knowledge (e.g. reverse engineering=
).
Just asking an LLM to do the change without putting that knowledge in is no=
t Ok.
Changes must be tested.
Changes must have a real benefit.
Changes should be low risk, if they can't be tested on all hardware right a=
way.
etc. etc.

Most of this patch set looks to be low risk, because it only seems to
touch code paths for core revisions that were previously unimplemented.

But I'm unsure and I can't remember all the details.
This is why I asked about the development methods used.

What would be Ok? Using an LLM to generate a fully functional and well
tested change from reverse engineered information.

What would not be Ok? Asking an LLM to change the driver just for the
sake of changing it or "cleaning it up". Or using an LLM to make
changes from hallucinated "specifications".


Btw, this looks to be the corresponding tool PR for this change, I guess:
https://github.com/mbuesch/b43-tools/pull/10


--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/Ya/n0a=Cznl2sfj19DrTnxn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmoMv4wACgkQ9TK+HZCN
iw4jxw/9GPRSy1mZMFxtuXiNqDXvCTIVzH3YEOZpxcEar3RDEbpLzIzTmpiaqEq+
7E1fo4a4VeV7RYt1BqmjpOcPy0R16Ge2UbGcLQ6uw6AF3J1zqJ6Cy2PhhY1MIk5B
4ddWuJ6zioMy15ZCy3n8OhakOek7+JRvgSX7dQdYX0ydV4o1sPHcEH6ZM2sgLcLo
Du7p5M7XWzQgge1gf4nDTwlA+IMYrtaYFWROVFf7j2MmeAULlNmVrv/bwgwWJapU
rsQG/vOUg5h2Eh/hw+Iy0F7rgk17Xe19BODAF7DONeQk9NB+ujWsLYV8B2ueZf4i
cdTvnpUmuLMc/A7vGRzsbTmRFaGqiUersjJTexWaum4Q1odd8TOCYNhePDeZz0P8
rGwDE2BBqalQIYwoE3DltvdAD9GIB6vc9ZeUQheu389Qa6paPEKMiw5+EYa14QsD
iIeb5qZGdoWrrzflCd2+30+m9EqgFjjc519XpzGSIIhYwjlGGFIWC0pqFTJTvhxZ
DRaG84Q6imtf9psmXJIcGgAonzZB0dYpN7JlNLdrZg0ylyB4r0LA+vp+vo3REpql
kRxTT7grFRXQbUTZl+Sfg0WckkTpS262wzpyuNhhbwtzSyJlO3myISP0XJ7MZF4i
2kLwbOBo8QQ1uHTxyvg9Vyz9BfoIEIKYomVOAH1qtNPuQUEPQdc=
=+7RV
-----END PGP SIGNATURE-----

--Sig_/Ya/n0a=Cznl2sfj19DrTnxn--

