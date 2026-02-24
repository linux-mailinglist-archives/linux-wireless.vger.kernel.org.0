Return-Path: <linux-wireless+bounces-32164-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJmrEw4znmlwUAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32164-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 00:23:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A873618E229
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 00:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 472083031AF1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 23:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527CE3624AF;
	Tue, 24 Feb 2026 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqwUwv1Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9E1624C5
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771975433; cv=none; b=l88rYE38LwhzA1WvzSv/pg2RD33dzpncVs2IA2xHE+4A/fQAONLJkMCs8WwLZqgsMzdyzbvt6IfM24sVXkApI6/9aO0eHiulJTt6Bvtxm4df7KWc/CMJieDHHp/TvhnSbWwCdg9hnjSq1zaOVNQRhcfV6/6qxoMa8M9F35GQ6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771975433; c=relaxed/simple;
	bh=pqYOPfqw75axMkUQkhuElhFSwKQFQWu1msgVQMDsoj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otUSHEdN5H75aI81tln3NWEVU+Qq32NmnPMYEaXOnw5RHEXHkrmlK5P9VNm82Es1a7qKomZ6XRbgee3nTadXcasQI8apPCc9sFhhwswzyZ5hnvSDrZTjQKnY7pUqt98hd7YvnQZUZ+vv6LwFzJ3GKVGj3pMtC5eHSsoSuNP+xVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqwUwv1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0D5C116D0;
	Tue, 24 Feb 2026 23:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771975432;
	bh=pqYOPfqw75axMkUQkhuElhFSwKQFQWu1msgVQMDsoj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqwUwv1YwgNJLdE4xWKO6njHPEotEJ6xTf4xASlN7HRf+AuQnupeBhUkTv1gzGdOH
	 CFeWtKKbcq7kHObK3r2lnjw11IEpjCFa6fY05Tloczjl6V6FZNgvkHD+6ehJ2fJpNz
	 GnaTLZXWrc5a65qIqrM58o1YQANnT3eHwS+B0pxV6Ppoi1wruMtfWz8zWk8/a7uxas
	 pk/lsAgV5pvnxqNhPOAlFn/oPH9zknVCQnTFU8+IT2Nr1kj9QJ61M72COB0hafJFJT
	 nVfU/bNkwAEJ55uYfLrJ/gCvWmu0CD2ZONA+ctROnOwuYkC8Hya6ZJX3eybgvDnKF9
	 GjabKWdz2JPyQ==
Date: Wed, 25 Feb 2026 00:23:48 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Greg KH <greg@kroah.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	linux-wireless@vger.kernel.org, Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, 
	"John W. Linville" <linville@tuxdriver.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <aZ4xt0TIscdxhseW@devuan>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
 <aZ4r6OUVCiHE-hhZ@devuan>
 <0b9635b8-05ee-4ae4-b4eb-9b83188a0917@oss.qualcomm.com>
 <828b4d9b-268f-4f7c-ab7c-51aa49c0bde2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z3fhv2q6tsxkhzkw"
Content-Disposition: inline
In-Reply-To: <828b4d9b-268f-4f7c-ab7c-51aa49c0bde2@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32164-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alejandro-colomar.es:url]
X-Rspamd-Queue-Id: A873618E229
X-Rspamd-Action: no action


--z3fhv2q6tsxkhzkw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Greg KH <greg@kroah.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	linux-wireless@vger.kernel.org, Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, 
	"John W. Linville" <linville@tuxdriver.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <aZ4xt0TIscdxhseW@devuan>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
 <aZ4r6OUVCiHE-hhZ@devuan>
 <0b9635b8-05ee-4ae4-b4eb-9b83188a0917@oss.qualcomm.com>
 <828b4d9b-268f-4f7c-ab7c-51aa49c0bde2@oss.qualcomm.com>
MIME-Version: 1.0
In-Reply-To: <828b4d9b-268f-4f7c-ab7c-51aa49c0bde2@oss.qualcomm.com>

Hi Jeff, Greg,

On 2026-02-24T15:09:05-0800, Jeff Johnson wrote:
> >> I don't know where I keep the patch, so I'd have to apply it from the
> >> email to resend.  Could you amend it yourself?
> >=20
> > sure, I'll amend the patch in my pending branch

Thanks!

> I've also updated the Fixes tag to meet the expected format...
> Fixes: c4dc0d040e35 ("ath9k: Fetch appropriate operating channel context")

Greg, I CCed you in the man-pages thread where I discussed adding the
commit date to the Fixes tags.  I was interested in your opinion, and
also think this could be useful in the kernel.

<https://lore.kernel.org/linux-man/3a656e90329f26d743d0904f56ae847951c852c7=
=2E1770150003.git.alx@kernel.org/>

Do you have any opinion about this?  Should I send a mail to some kernel
mailing list to propose its use in the kernel?

The format I used is documented in the Linux man-pages here:
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CONTRIBUT=
ING.d/patches/trailer#n16>

    Fixes
	Add 'Fixes:' tags as necessary.  'Fixes:' trailer fields should
	have the following format.

		Fixes: 12-char-hash ([author-date,] commit-date; "subject")

	where the author date is optional, and only included if it's
	somehow important.  The commit date is often more important, as
	it's sorted, and thus can be used to find (with a binary search)
	a commit whose hash and subject may have collisions.  For
	example:

		Fixes: bb509e6fcbae (2020-10-16; "kernel_lockdown.7: New page documenting=
 the Kernel Lockdown feature")

	See <CONTRIBUTING.d/git> for how to configure the alias.ref and
	alias.ref2 git aliases.  The commit references can be produced
	with them.

		$ git ref bb509e6fc
		bb509e6fcbae (2020-10-16; "kernel_lockdown.7: New page documenting the Ke=
rnel Lockdown feature")

and here:
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/CONTRIBUT=
ING.d/git#n46>

    alias.ref, alias.ref2
	To produce git commit references, the following git aliases are
	useful.

		$ git config --global alias.ref \
			"show -s --format=3Dtformat:'%C(auto)%h (%cs%x3B \"%s\")%C(reset)'"
		$ git config --global alias.ref2 \
			"show -s --format=3Dtformat:'%C(auto)%h (%as, %cs%x3B \"%s\")%C(reset)'"

    core.abbrev
	Use 12 characters in abbreviated hashes.

		$ git config --global core.abbrev 12

The Fixes tag I used in this particular patch was

Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating channe=
l context")


Have a lovely night!
Alex

>=20
> >=20
> > /jeff
>=20

--=20
<https://www.alejandro-colomar.es>

--z3fhv2q6tsxkhzkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmeMv4ACgkQ64mZXMKQ
wqmRkg//au3yaZBe7mMsA4oQDXo6OG+hmT8iwdT13IXo7TADLsAHGMs3a3eGU1hW
FDAlcFWMyco6NoYUMRohk8ZiEBKFebPU9IY19EuzkVM0xyn8g4GXbAtdgMTuzFJ2
mhTclPWLM1lW3fploS/BVY20pryPvSdX15xhJFy9HdCX8qAv3tuuwB//02gmJ8l8
jl9HpN5FAfkpDQAuUfsY+HaPoSCWjTFMePJxCZOHx3zLovzgfzLoY8wiR+AltxCk
SFwm/Spx+GWmE/aWKSgAVhZ5APcnHnRm37pK8WY4nxriM66L0O4MpAyE6xhKWpRA
S1VzhhTSYnNNc1gfsFHOuOohIJMi2DL35CNU2gyNx0LBN3oLAyAcxT6oBavmKANb
grgz/U6sp31HvA696D95qnGg1fKKCz8+x/aXIgLE2eo+rNGsvbeAS1ZRGihYYgNs
Sn34fvnnPtZ3qd37E/ff6DKZG4/pA0Lq9PvEf6z2u5+M9vykjyG/iWWfGIZSrcZC
Y9ERNCoezV29xKbjKUWI7CFoOUHqy+Ja4RtISt+sfr23/H+orw71QDek1zHe+1Fj
VUQdB8XNmpSZ//U7+Hx9LKtxtuTA7E4CQYaj4zgo1EWIOtL9wiVcGfZgczhjZiJl
6kHoOA7jvOjzA9my7UATpsW2Xp4OHCCVi2qnWsj3haWprxLGomk=
=3v6h
-----END PGP SIGNATURE-----

--z3fhv2q6tsxkhzkw--

