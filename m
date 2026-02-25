Return-Path: <linux-wireless+bounces-32166-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P83JU8+nmkrUQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32166-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 01:11:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE3918E554
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 01:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B67C301F31F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 00:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D294369A;
	Wed, 25 Feb 2026 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siplHjcu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21A3FCC
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978224; cv=none; b=mmxmCTRFVyDfPvIa+DtB+SbJm8UyFHZGqpLR9Y/e/eLzqpnKcNPHY0MDMNVTHvdUedn/QF1R/uvrQkNR1hS/uuNLmarax09s/Yxr3qM3gJlDd0nc54fz+uKxK/Hslxbm+pzYQcCg2KpWzapb+NtkXMLI1GYFDr2kRDHqCViNUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978224; c=relaxed/simple;
	bh=QJmhXmDQZBmj+KkWrL88QgMbxcsN9s7weyY7cvsDo0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwLXhnXR8fLLD3mX/V+e4dzJS+Z58dGlfrb9fEe9wQ+FF55cCZruCkkKNBoIgfdXobBQaHHNHnFXwSFI7j5kbMo2BQ36luq/GrQwrfsDoRjIojSHSXpZ/4EO38nGP4NYWPfM2+oLPAjolJQ1yWMdWsNkAinTfclYnvotDY+j19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siplHjcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACEFC116D0;
	Wed, 25 Feb 2026 00:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771978224;
	bh=QJmhXmDQZBmj+KkWrL88QgMbxcsN9s7weyY7cvsDo0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=siplHjcuNXVrGYcjhz1jgawqI2XCQJUs43bEO7f9b5ykDfXZqkjdYfRLyJrEPgCE9
	 Twb59nD/qoI+LW5NnPlYklEak8febK6baY86ITPFYtU6T8yo7xaddQlK6o1TBDykU5
	 ITWHOmVjxx+X0WgKy9KMQVEXopH5d77FuVwCXBYReZ3DdwkVrzwq6t6aqB2C21cCuJ
	 6xECPHEHA8iXaoEeOwvwZl1jM9O+e8gW1UsSOs0FVggJ8Mgu3gqrEF/AJv5cY2R3xV
	 gZS15ODow8Wr/8kJWT5ILpkjm+37VwNSWRCQuUC5S92uK1XrTQ36Pr80fTJLbVAa37
	 ZlLSP0QMQgzoA==
Date: Wed, 25 Feb 2026 01:10:20 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Greg KH <greg@kroah.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, linux-wireless@vger.kernel.org, 
	Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <aZ49l7LioNRU4CNL@devuan>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
 <aZ4r6OUVCiHE-hhZ@devuan>
 <0b9635b8-05ee-4ae4-b4eb-9b83188a0917@oss.qualcomm.com>
 <828b4d9b-268f-4f7c-ab7c-51aa49c0bde2@oss.qualcomm.com>
 <aZ4xt0TIscdxhseW@devuan>
 <2ad609dd-bfbc-4af8-88e4-9576708c156d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7hu3oopn5ynppvzz"
Content-Disposition: inline
In-Reply-To: <2ad609dd-bfbc-4af8-88e4-9576708c156d@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32166-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alejandro-colomar.es:url]
X-Rspamd-Queue-Id: EBE3918E554
X-Rspamd-Action: no action


--7hu3oopn5ynppvzz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Greg KH <greg@kroah.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, linux-wireless@vger.kernel.org, 
	Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <aZ49l7LioNRU4CNL@devuan>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
 <aZ4r6OUVCiHE-hhZ@devuan>
 <0b9635b8-05ee-4ae4-b4eb-9b83188a0917@oss.qualcomm.com>
 <828b4d9b-268f-4f7c-ab7c-51aa49c0bde2@oss.qualcomm.com>
 <aZ4xt0TIscdxhseW@devuan>
 <2ad609dd-bfbc-4af8-88e4-9576708c156d@oss.qualcomm.com>
MIME-Version: 1.0
In-Reply-To: <2ad609dd-bfbc-4af8-88e4-9576708c156d@oss.qualcomm.com>

Hi Jeff,

On 2026-02-24T16:04:51-0800, Jeff Johnson wrote:
> This format doesn't conform to the format described in:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>=20
> And it fails scripts/checkpatch.pl
>=20
> Review the comments from when a similar change was proposed (including a
> response from Greg):
> https://lore.kernel.org/all/tencent_F8CFC8ED723F6E8103B4AF3D98D63D7F1F08@=
qq.com/

Thanks!  I'll reply there.

>=20
> And referencing a project which you authored as an example of how to do t=
hings
> doesn't give much credibility. Please follow Linux kernel style.

Sure; for this patch please use the amended one.  I was pointing to that
for discussing changing the format used in the kernel, globally, not to
use it in this patch.


Have a lovely night!
Alex

>=20
> /jeff

--=20
<https://www.alejandro-colomar.es>

--7hu3oopn5ynppvzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmePeUACgkQ64mZXMKQ
wqkYlA/9G+GhuqiJR3VkcEkTLu+bVWeW7zMa1SntQwY0h2HCbLpVb4KAha6ErF3V
EmZQpqtfOhHSMwR7GQE9L/jzQX81cFA/Uej5Rb1JeCfaWsoh7xeP8FxKkF24WhJj
eAAu3m0zzrEEM8WkflZ6bEnL76nrgEctWKnqKwgmceMq+lqSrP5Rzd0bDQKdFLfr
Gi1JP2eS4d1FzsBQxwAT+7jzoR/RKskFoambYK6DDYH9E0yj62M9KG44xHqPSnCO
rZqFhHc0m4B9z/cVWvc9VhgCo3QG9YrjP94EffPRMEBNp8NSVL2q+qQGfB9Vvkuy
rOtxFrGLjS58G9iol4KOoQFE1xebfKCZd95DfD2vA79PUdgSqTgPPqxH9VMAC35S
Opb8Swa6T+UlGJ3LtoUcJNdK6bBL5JBLcob4kR3VWerahRG0ZncUn1x+jyVyGEHg
C5JFDAjBypwdo1Thxkg5qdMq4qahv25gxv1tVHsbVNlShLryvNRH216PCBQu7tY2
UTXZ1ptATeyjv9WSY6gq6SFR59t5UNSjd4VeaCcgvHjCFu1K4Y/7MCoc376nRyte
7drRYGZRXvTiSpOJGuZZxD10uLjZhV/yE1PI1OIGLQN5IuG36p2YylJm2uM6FMUc
NFHqj9uqNgKXAgYY7kMeTZ5xQZnrayRolLCMJBURQz04J0JzDZI=
=EdF2
-----END PGP SIGNATURE-----

--7hu3oopn5ynppvzz--

