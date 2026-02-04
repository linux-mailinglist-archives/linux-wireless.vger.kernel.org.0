Return-Path: <linux-wireless+bounces-31523-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAhMCqspg2kxigMAu9opvQ
	(envelope-from <linux-wireless+bounces-31523-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:12:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 742FEE4F30
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 12:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 497AF30180A1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1632B3E95A3;
	Wed,  4 Feb 2026 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fXekQfV6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA473A1CE7;
	Wed,  4 Feb 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203484; cv=none; b=NUHIbQepoFvzAvGVlMO6EZ4iT9x4ek4vTW5WtpbsZIfcgclXXVI0alCZ1DXZGE4Xs6yT24A+t8M5DaQSjCaPQ3YIFBGS1UHQD+ll0aGMtlY/zvUp/hj2hCLDz8JwAjsSk92aoCz7Kqtd+OkR8Ml5yon/pXYPY5peNBkVPDFmWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203484; c=relaxed/simple;
	bh=K2qOCq+J0Xv9SUVvntuJR/dSh9crrfZEadvxdH6Y58A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hQz0+DLxrKjlt8RcwFC7m+CVYDSOFCvTSv2FD7v8PZuAXs1GARjwTv1TBR3KqG+a9TzaEe9CwgJ0pPbvSjj8rZUynTFpJhJ3lh+tazmL/eN8AFjl7V/65lHxpG5T83fIhlv/LHbwb+BJoSWNCnLI/jErXPq/5sVfIyowJqF0nQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fXekQfV6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=R0el+c04iOjVIPyRYz0kWaDpqSht4LPyIxUGTR2VTDU=;
	t=1770203483; x=1771413083; b=fXekQfV6CsN1V4K+p4CTZydpcpU/Th+GSYmx7Tdz+O+1wfJ
	heSexeOhb9ZKcg/6A7WfKNlUbbyUhOWNbnWcUc0TEd5zOTo6nM8SWORtMo4gsr5vWQj3VTNfGDCPo
	VuancuPacErYfMXTwPtGgqrcB/vQfMurTubaF76D7+nEjQc3FNq4ZwjnMIEZ+GqWxX6xpYSqJSbjr
	HlqtXCFThBeZVqK5jJ+vouNbvs8N4FBA7SwnQgzWRpJC0+HX+plWkMyERTlhcCrvNYGYAcbNa/TZX
	DwGlScwBxWxLCLznsZvh6nm1hvPEtNrQF4LBYWxImvXq9GMFZZeR6VwvMeYtRF2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vnan3-0000000EIkO-0vtX;
	Wed, 04 Feb 2026 12:11:21 +0100
Message-ID: <074b66ab3d63e6640ecd6962c074702225fba19e.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: nl80211: drop impossible negative band check
From: Johannes Berg <johannes@sipsolutions.net>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Feb 2026 12:11:20 +0100
In-Reply-To: <CABFUUZEiMFoGg4r+9q1FabbwD1Pfd0oZZeNxFqnM22nA1xn8UQ@mail.gmail.com> (sfid-20260204_101330_872267_A6E97739)
References: <20260204081821.730673-1-sun.jian.kdev@gmail.com>
	 <bc92582d5de175ec325ae53ed3fe18a5e073438b.camel@sipsolutions.net>
	 <CABFUUZEiMFoGg4r+9q1FabbwD1Pfd0oZZeNxFqnM22nA1xn8UQ@mail.gmail.com>
	 (sfid-20260204_101330_872267_A6E97739)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31523-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 742FEE4F30
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 17:13 +0800, sun jian wrote:
> On Wed, Feb 4, 2026 at 4:36=E2=80=AFPM Johannes Berg <johannes@sipsolutio=
ns.net> wrote:
> >=20
> > On Wed, 2026-02-04 at 16:18 +0800, Sun Jian wrote:
> > > band is derived from nla_type() of a nested netlink attribute, which =
isAgreed =E2=80=94 in general the enum underlying type can be signed.
> > > a masked u16 value and therefore cannot be negative. Drop the dead
> > > "band < 0" checks and keep the upper bound validation.
> >=20
> > I've seen this before, but I'm not really convinced it is entirely
> > correct. C says:
> >=20
> >    All enumerations have an underlying type. The underlying type can be
> >    explicitly specified using an enum type specifier and is its fixed
> >    underlying type. If it is not explicitly specified, the underlying
> >    type is the enumeration=E2=80=99s compatible type, which is either c=
har or a
> >    standard or extended signed or unsigned integer type.
> >=20
>=20
> Agreed =E2=80=94 in general the enum underlying type can be signed.

But nothing says it cannot be "signed char".

> > It would thus _seem_ to be possible for an enum to generally be a signe=
d
> > type, and therefore a 'signed short', and therefore an nla_type() that'=
s
> > a u16 could end up with a negative value...

I was just using 'signed short' as an example, but your argument:

> The key detail here is that band isn't assigned the raw __u16
> nla->nla_type, but nla_type().
>=20
> And nla_type() is effectively:
> nla->nla_type & NLA_TYPE_MASK
>=20
> and NLA_TYPE_MASK clears the two high flag bits:
> NLA_F_NESTED (1 << 15)
> NLA_F_NET_BYTEORDER (1 << 14)
>=20
> So the result is restricted to the low 14 bits, i.e. 0..0x3fff.
>=20
> With that restriction, even if enum nl80211_band ended up with a signed
> 16-bit underlying type, the sign bit (bit 15) can never be set by
> nla_type(), so the value cannot become negative.

applies _only_ to signed short, not to signed char?

Now we can argue a "sane compiler" won't do that, and we can also argue
that "gcc and clang are sane compilers", although sometimes I definitely
have doubts about the latter ;-)

johannes

