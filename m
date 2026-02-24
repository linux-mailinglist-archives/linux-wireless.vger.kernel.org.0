Return-Path: <linux-wireless+bounces-32160-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD01LoosnmmkTwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32160-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 23:56:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C89D18DE52
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 23:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49A1030166D5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 22:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D93729BD88;
	Tue, 24 Feb 2026 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwviNXRf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37125524C
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973569; cv=none; b=KjVklf81wVUSzaP7aihDM5c30f27PxRyt7VQbiEqq/tlKm+nvB+Ow0uE/vG5bCG2V9JkjzWL6DY8v/+y3eKsl4NGKhGKy0bSCGtGuQVgMgpbJj7KiEZ7VUMA2fd9usMlEsFg9T0wceOCq1CiWRtXkDHWn+GRingQxGDZIlBOyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973569; c=relaxed/simple;
	bh=81qnFHx8s5B7LFlQwuxmGdW6A/eonlF2dRmSg5+Dlns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQe3ICbMiwgHGTfCSvWNZ3FfXBNwBTU3dQKsKB+um4878L1EuS2KtC06hvp9N+AiTUc+eBTnLL85RUtt9Pp6RzVf63eSQCqyHC69AEJUfoIlwB+RxMKWXKuIqU0iDY8uWRxD1tEUtCfcbUufhvd2OeKmTVb1+Zt/x0tRi3tpwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwviNXRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91867C116D0;
	Tue, 24 Feb 2026 22:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771973568;
	bh=81qnFHx8s5B7LFlQwuxmGdW6A/eonlF2dRmSg5+Dlns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwviNXRf2aSjqg9kfJFb8menRxFu5ICTEO/Z/n/PycKJVzKNraj9DfzTiHmpJhczV
	 p2z/HtDRjsiPLlzdJo4FRlynCQbyWmV71TF7v+CNi6tHAgJ5aQQVQEe9qNWNyrksvl
	 8LUWTPD8MroETTXVG1PgSHxkSL74Ba2ISmBXSQ0mDtNgAz1t5ulKgeSQI78Gz5PHk5
	 U+c/V1Wcj4a3AIHLH+uZL1a7oE3KnjzhK94loFWCZKkRnfuxheCJiloFXS9uvTS4w5
	 z+0nnXXu3gr0nDYHGdCvl2eHW5yYjMfr0xefJdg4REqGL7/mZDz+1t2Jmd+ZhL8QSO
	 OCK/KtQLGlrZQ==
Date: Tue, 24 Feb 2026 23:52:45 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, linux-wireless@vger.kernel.org, 
	Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <aZ4rgNrA7RS0OuoB@devuan>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <2026022405-mundane-caucus-6aa9@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h2cmyqbekil3anzp"
Content-Disposition: inline
In-Reply-To: <2026022405-mundane-caucus-6aa9@gregkh>
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
	TAGGED_FROM(0.00)[bounces-32160-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C89D18DE52
X-Rspamd-Action: no action


--h2cmyqbekil3anzp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, linux-wireless@vger.kernel.org, 
	Rajkumar Manoharan <rmanohar@qti.qualcomm.com>, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <aZ4rgNrA7RS0OuoB@devuan>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <2026022405-mundane-caucus-6aa9@gregkh>
MIME-Version: 1.0
In-Reply-To: <2026022405-mundane-caucus-6aa9@gregkh>

Hi Greg,

On 2026-02-24T13:37:09-0800, Greg KH wrote:
> > 	[Do not backport to stable]
> > 	Fixes: ...
>=20
> As per the in-kernel documentation file
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>=20
> 	There furthermore is a variant of the stable tag you can use to make the=
 stable
> 	team's backporting tools (e.g AUTOSEL or scripts that look for commits
> 	containing a 'Fixes:' tag) ignore a change::
>=20
> 	     Cc: <stable+noautosel@kernel.org> # reason goes here, and must be p=
resent
>=20
> So I think it is documented already :)

Thanks!  I'll use that.  :)


Cheers,
Alex

>=20
> thanks,
>=20
> greg k-h

--=20
<https://www.alejandro-colomar.es>

--h2cmyqbekil3anzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmeK58ACgkQ64mZXMKQ
wqmkQhAAhjbnJ01bN3xyrxOyDQIBJ/Fjj8cKchRLzbUnhVVUUEsGLiMCpQFMSHos
b20RxseGViutf6awO81YAjKzOTiDwvwC88jJHs0QA2LVtKn7l+m9FDji8wx+FyCM
R7OtqgdZ39xP6fUc1m8zv89sPCYCk+q2G32VIOjqu+RwPGzdhtzAlCiRB6Gudgv7
wRup68D5OzFi6BzhRSMi+hDLu+14zHhY2/WbJPXiQRMAWOJ98G5Eyrhtqkdehfo6
1RtrN4+c2mjQXmAoIc4kstOfiXm6lw1tcvYXu+9iP3mx8Mek682Pzen0UkutWiXm
4FkobUvlAsTU61L+HhpJyI8QN9u35Yhqa1UPzEj87M0x9dek8noPQe9TClJJweJq
Z928Ci+FOYqZc3rFjVVS/f1tArWMTq8erArQ68+V8x5pXZUcA8o0W58Ov34GB9lb
IbIgiOLKISk0QVBOucJSEXbCTul8EoZSD7O263Fy7dAr/Ti5Vv5xGJoHkCoEWtY7
8Livo6vqH1wX8DXtC97Dbju4J8xOLSLpLxHNm4zCfejF19WHcuZn7QMDLCnR5x/r
Ca+dVw1uDPNE0KRX5A4MFUP+DPAqLdqjFJN8T5SLqCHp8QaBT7yM3ZzSbYUBpX7f
z7aEeMak71ACRyEbJ4u8A/0k8GvRrezGxZhqVY1fd18W06vrNxo=
=dZmE
-----END PGP SIGNATURE-----

--h2cmyqbekil3anzp--

