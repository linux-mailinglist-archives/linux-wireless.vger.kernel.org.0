Return-Path: <linux-wireless+bounces-32157-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAsODOUXnmmcTQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32157-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 22:28:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C665818CC28
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DF843038024
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BF8339870;
	Tue, 24 Feb 2026 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/yc/8oL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479D2E2DFB
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968481; cv=none; b=ZiLMHqOhsc77KvYq8pGZOMqK6kkHy5Jz17YmVRO03dRZ8kpMqilbN45nLMtR8YcMbRi2MPwsSk1S2ygpoM8pt0tMWBjHkHwgVrZoSTGn0xtxZz7QWlNmfWKtioRVg467nM2PDPaIUvkKFk+uNa+RbDUkc8ARZDQWxRoYTg1x2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968481; c=relaxed/simple;
	bh=lTDh8y9csgDy6I44Mj+9QPHtSy2wHdegXTAP6+dbdZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+pKQqsuX2dgGYuyXxZ+bJ4uxNApHS3GzKaH57nHEcmwGMkFf/B1ofIsIROBjEEpfdQnseyJEQycJL4Mzyp8dyRbcvvtQRv96vfVdjkmw+zyRs21Knnhz03uJsZJJvxU20dxeJpcueEO2NqSldaOB4xN8zNuF9SLV9mIT2ADtho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/yc/8oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83642C116D0;
	Tue, 24 Feb 2026 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771968480;
	bh=lTDh8y9csgDy6I44Mj+9QPHtSy2wHdegXTAP6+dbdZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/yc/8oLbiPY+XflYWV/iCmeCop9Sy/1oDGYz6eyyOIl7NSS3rSrh9Iy+F0lFPpVT
	 F6OKn0MmjHyA/fG1bxjTAfYZxSfuYMTdx3mC6Km4kX5mn7npsEF2WEvxbGVGuSkF5W
	 TidHcAnSJtB3/Z+BwFiV1UQ3V2bu7h1HqwI+tQeVpwRVumc/X3JudZ35fPwV2+QBP7
	 PbyS0rXfmApGh3NlbEsu7j/frP6Acl5Bl2cIK8T7AV7bM3cx14+TYMG4EM592Vclls
	 /L1rZ+mWPfxQq16QtOYYTHb4vpL1gtlRUIXJmYbtFiMRMNmu/DyhzBaPIfGQC9KKFU
	 mD+n74ytEH8dg==
Date: Tue, 24 Feb 2026 22:27:56 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	linux-wireless@vger.kernel.org, Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, 
	"John W. Linville" <linville@tuxdriver.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <aZ4Wq6h-nMt-G3pC@devuan>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tgsikbvgmhllw5kz"
Content-Disposition: inline
In-Reply-To: <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32157-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alejandro-colomar.es:url,tuxdriver.com:email,toke.dk:email]
X-Rspamd-Queue-Id: C665818CC28
X-Rspamd-Action: no action


--tgsikbvgmhllw5kz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	linux-wireless@vger.kernel.org, Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, 
	"John W. Linville" <linville@tuxdriver.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <aZ4Wq6h-nMt-G3pC@devuan>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
MIME-Version: 1.0
In-Reply-To: <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>

Hi Jeff,

On 2026-02-24T10:45:02-0800, Jeff Johnson wrote:
> On 2/23/2026 7:17 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Alejandro Colomar <alx@kernel.org> writes:
> >=20
> >> This only worked by chance, because all callers of this macro used the
> >> same identifiers that were expected by the macro.
> >>
> >> 	$ grep -rn ath_for_each_chanctx
> >> 	drivers/net/wireless/ath/ath9k/main.c:1576:	ath_for_each_chanctx(sc, =
ctx)
> >> 	drivers/net/wireless/ath/ath9k/main.c:2554:	ath_for_each_chanctx(sc, =
ctx) {
> >> 	drivers/net/wireless/ath/ath9k/channel.c:165:	ath_for_each_chanctx(sc=
, ctx) {
> >> 	drivers/net/wireless/ath/ath9k/channel.c:291:	ath_for_each_chanctx(sc=
, ctx) {
> >> 	drivers/net/wireless/ath/ath9k/channel.c:861:	ath_for_each_chanctx(sc=
, ctx) {
> >> 	drivers/net/wireless/ath/ath9k/debug.c:717:	ath_for_each_chanctx(sc, =
ctx) {
> >> 	drivers/net/wireless/ath/ath9k/ath9k.h:446:#define ath_for_each_chanc=
tx(_sc, _ctx)                               \
> >>
> >> Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating c=
hannel context")
>=20
> I'm dropping the Fixes tag since the existing code actually works and hen=
ce
> there is no need to backport to LTS kernels.

Sounds reasonable.  Alternatively, a line next to it saying

	[Do not backport]

would work, I guess.

Greg, I've seen this situation already a few times.  A Fixes tag getting
removed to avoid triggering a stable backport.  But I think keeping the
Fixes tag could be useful.  Should we have a standard way to document
that a patch fixes an old commit without meaning that it should be
backported?  Maybe something like this?:

	[Do not backport to stable]
	Fixes: ...

In any case, feel free to remove it.


Have a lovely night!
Alex

>=20
> >> Cc: Rajkumar Manoharan <rmanohar@qti.qualcomm.com>
> >> Cc: John W. Linville <linville@tuxdriver.com>
> >> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> >> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> >=20
> > Yeah, looks reasonable - thanks!
> >=20
> > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> >=20
>=20

--=20
<https://www.alejandro-colomar.es>

--tgsikbvgmhllw5kz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmeF9YACgkQ64mZXMKQ
wqnqhw//RlsMT8YRev3PXV3/rnrJbm5x8r97adCelDmknkCXPOOWbsRopGwiVQnD
alJ00aLqu8TaEx36Md2LakyFcWZh/AbGFzP5f5lryWtPHYPAw6C0zb33w+x6e2pe
isagPhPHljr8GTqpUrpNNM29dn6Ly077ErLW332IdiFr0alp7swPUHAR4GNLYcYd
IBv+LVXoUqN2/zfxrfBzfDYXapwytoY2jJKM1eLO7UQNIpoGI7f1FaJy266V9IHj
NIPLQaztaTHWgamgFGLI9MV7OKt4Tsewyjbd+e1nsqqjoF8EVYukLDjegBY7jn4f
iGLb68O0egf9hgTs3av5sWJ9zKVEmSTp6Phfd0q6FUWmfujbsWtwkEE0wCyePzC9
MVXuMTfAC16Q9UO35t4x0vryCr3B77Wkobm+CwYpuFUEdhb70G2bUZTk1G9PdxA2
Bk8OjEjAdkzEbWhYlMawXebY9t2rrAEA+hE+3ZO33u8mFNofAcsbH5kc3KYBToGv
5j36UnJ2J3oirfdnMRY3BQp6o2+pNrKdvvXdyQd8xGBHaSEoFCJJYMhkXuEAU+9A
X6aw7B/PPwMEuD5xrKwvmNcqMkPBcElS99namHDUC7kuayNyQDVnjGhQIplCntG6
EP7RQT3V9YXz3h7HPioegi6uf7XNvNWGan72JPNuudQeZl3i72I=
=nzTu
-----END PGP SIGNATURE-----

--tgsikbvgmhllw5kz--

