Return-Path: <linux-wireless+bounces-32161-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFElC/8unmmkTwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32161-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 00:06:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D10218E0AC
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 00:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76BDC305F550
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D9F25524C;
	Tue, 24 Feb 2026 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK3ur37e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838263EBF1A
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973735; cv=none; b=Rrh+anefBGGtGNQiHTdCG53aHmS17Zp/tSHkzVJ5HIfqKS/Z76SxsqUhWzThBb+VrrJItc0rlcYWZv4bYdhxc53bY3YYhPsy2bamV3DQdvjDErorjs7gYyEcng5mj5SPxD3W+d/hMPOt6ifZ54CAOXLOtub++WKwnFt2iI2e9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973735; c=relaxed/simple;
	bh=1dy6E35MJ3nUbs31SjA6HZic+temopCK6jjE59LBbj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzTjReyy497brTRscN/9O0JYwRco9LjzFNFj64r9KTfZdHmS02v57aGBW04JoIV8mVSXhdvQ6xtzeOP/0pFMJMyzr/GhDFqwinmQHMnCx5dclXLDjmjy1o+a8n2QZXVacysCPw6I+APaMXsS4y2kR2MQqYGOjZFkYNJc16w5jJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK3ur37e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF4AC116D0;
	Tue, 24 Feb 2026 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771973735;
	bh=1dy6E35MJ3nUbs31SjA6HZic+temopCK6jjE59LBbj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IK3ur37eFHuEhm1f4zTwtdfBreGqMqdUe1L2qqurvfIvj/8p8dhBxIbPZwokn3k5a
	 aO8YR6e2h/pjNqIl6UVW0wnXtcv5CXp2E3kxChlKAAWUj5vLSrT+EQah5gnzRMwLIy
	 axAuvySwxEMmuqWi3t2cad+YeHO9ybvuG4LwiggB6n/h1GPcwFJNQMSZGeUKF4dlwv
	 oCaMT7BTbm0y7PrhNwiwPyspXUphkkDp4/ePFe0MhSfpKKfus8Eu4BbdLzYDrXctwF
	 Lu7M1qJ1KTWK9Z2f4z6uW7kr9v/2l+OLIBk0oNetKdKEWtWE50wQXgmsnMwV6PDhn1
	 lDk4MwlyZPu1g==
Date: Tue, 24 Feb 2026 23:55:31 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	linux-wireless@vger.kernel.org, Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, 
	"John W. Linville" <linville@tuxdriver.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <aZ4r6OUVCiHE-hhZ@devuan>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7pggt6ykh3r55n7g"
Content-Disposition: inline
In-Reply-To: <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32161-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D10218E0AC
X-Rspamd-Action: no action


--7pggt6ykh3r55n7g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	linux-wireless@vger.kernel.org, Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, 
	"John W. Linville" <linville@tuxdriver.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <aZ4r6OUVCiHE-hhZ@devuan>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
MIME-Version: 1.0
In-Reply-To: <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>

Hi Jeff,

On 2026-02-24T13:34:57-0800, Jeff Johnson wrote:
> On 2/24/2026 1:27 PM, Alejandro Colomar wrote:
> > Hi Jeff,
> >=20
> > On 2026-02-24T10:45:02-0800, Jeff Johnson wrote:
> >> On 2/23/2026 7:17 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>> Alejandro Colomar <alx@kernel.org> writes:
> >>>
> >>>> This only worked by chance, because all callers of this macro used t=
he
> >>>> same identifiers that were expected by the macro.
> >>>>
> >>>> 	$ grep -rn ath_for_each_chanctx
> >>>> 	drivers/net/wireless/ath/ath9k/main.c:1576:	ath_for_each_chanctx(sc=
, ctx)
> >>>> 	drivers/net/wireless/ath/ath9k/main.c:2554:	ath_for_each_chanctx(sc=
, ctx) {
> >>>> 	drivers/net/wireless/ath/ath9k/channel.c:165:	ath_for_each_chanctx(=
sc, ctx) {
> >>>> 	drivers/net/wireless/ath/ath9k/channel.c:291:	ath_for_each_chanctx(=
sc, ctx) {
> >>>> 	drivers/net/wireless/ath/ath9k/channel.c:861:	ath_for_each_chanctx(=
sc, ctx) {
> >>>> 	drivers/net/wireless/ath/ath9k/debug.c:717:	ath_for_each_chanctx(sc=
, ctx) {
> >>>> 	drivers/net/wireless/ath/ath9k/ath9k.h:446:#define ath_for_each_cha=
nctx(_sc, _ctx)                               \
> >>>>
> >>>> Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating=
 channel context")
> >>
> >> I'm dropping the Fixes tag since the existing code actually works and =
hence
> >> there is no need to backport to LTS kernels.
> >=20
> > Sounds reasonable.  Alternatively, a line next to it saying
> >=20
> > 	[Do not backport]
> >=20
> > would work, I guess.
> >=20
> > Greg, I've seen this situation already a few times.  A Fixes tag getting
> > removed to avoid triggering a stable backport.  But I think keeping the
> > Fixes tag could be useful.  Should we have a standard way to document
> > that a patch fixes an old commit without meaning that it should be
> > backported?  Maybe something like this?:
> >=20
> > 	[Do not backport to stable]
> > 	Fixes: ...
> >=20
> > In any case, feel free to remove it.
>=20
> Looks like we have this:
> There furthermore is a variant of the stable tag you can use to make the
> stable team=E2=80=99s backporting tools (e.g AUTOSEL or scripts that look=
 for commits
> containing a =E2=80=98Fixes:=E2=80=99 tag) ignore a change:
> Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present
>=20
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#o=
ption-1
>=20
> Do you want to re-spin with that?

Would you mind amending to include the following tag?:

	Cc: <stable+noautosel@kernel.org> # the code worked by chance

I don't know where I keep the patch, so I'd have to apply it from the
email to resend.  Could you amend it yourself?


Have a lovely night!
Alex

>=20
> /jeff

--=20
<https://www.alejandro-colomar.es>

--7pggt6ykh3r55n7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmeLGMACgkQ64mZXMKQ
wqn6kQ//X2W9ghwhNuld1dq1jyJV9qmIfLQqqDh6iLnyYnIGVbv9LnjsurKDt5Ho
l3Pyrag6bOkuCDMl4drax1t5kryLDzsz54B1d+paPylQWMKGl/t+ZxNtk3vY9hFw
9ywqRj98Z3VClSzHCKW9505QyvLNMelDlTGVjk2Cf/pb/wQKYsITVK4ZoIWqD+B2
ulMkfwvcpZpFBX3f7jwhjL1KmWtYFJmjcbUNzaikOq7/x3KDO79b0sRMLjIve2Mu
yJeUHTiem0F8aB4EE17SZF4XpYvIyljWEarqnL2Qm3ixQkVS4whYxWc05AMidvdp
JPm1/9E1IdVhVBoiilPyKMEZn20Edl4P5+RqDxWMNv2BD8doXp6MK+xejJ9YMw7a
Y+4UzPMZu3iOOXfvk1/KuyNzMolLh1V7fmLMSORbiVMyxoRpTSQb3sUiSxNlOouq
vTKnivhJ9rMADlbrkzG6NJcKyNJanPlSNNhMB3e0LIi/onmljpS6bWg0kP4NoSE+
ZTK/4Jfd9mUNUsJbi9iiWwtNvxRpQpIcxJX+Twe0piqLJLYz+VGnZ0YZZ3grphfi
GU/tN+J62naUv8uzJmlrKSjuGeY+4w3tFV+3oxLF2xbqF/gtMEUlI5C/9Y02FI9T
DfPAVP539oKdp9qb/ERdBM4IROcOQ96xdWwhKWBU0QanVFzFG+8=
=auLl
-----END PGP SIGNATURE-----

--7pggt6ykh3r55n7g--

