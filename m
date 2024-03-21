Return-Path: <linux-wireless+bounces-5101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4C9885D60
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 17:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1891D28181A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F112CD97;
	Thu, 21 Mar 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqxnzxD/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0F12BF2E;
	Thu, 21 Mar 2024 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038368; cv=none; b=XedDjt//T166t0IuPutCYPIQzLyx+mfGIgADp4Dl3LIcW20U/I7SEaMYoNbi7IZksiIDfsEHq6lpcfWGNQWAH7/Pwii8A0I1TFjth/wTqDnjd+zcMU1okKoRENFwpQP3qQpCQo8EDpQn5cUZxC5rQgC/8OvPP7+BrQS2tJhK6f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038368; c=relaxed/simple;
	bh=o03R27T3nyhgHJSk8Nx5JFM1w/gztzsuOCe0SoTCrAQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pg28s3pK6q0x3Kcj2DZo2B6hRJSnpHFtymCBHKySW8sHw/Eyr7ddVxf3Q8mTGRc30AhWMl5e+J82RrtJlqEDmxCKvkhYb0CPT5A3DHKFQ3weHvvcUWAAUhOlLviaqjE4jD0Dj3619hVkXDPRU63GtbwF6hMV5gkWPwpFXbTtS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqxnzxD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54328C433C7;
	Thu, 21 Mar 2024 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038366;
	bh=o03R27T3nyhgHJSk8Nx5JFM1w/gztzsuOCe0SoTCrAQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nqxnzxD/O7UelVXyOYeBjfH76lNFXycIDL6vIsdi91LcDS3WK1sCL+bGDOUQth5du
	 EXPMXZAXZEZ6LgH54rRJZr/o+UH/u8SLCj9ddwu/eDk7O6qvLGxoXHbzUlxtrwX9Ji
	 Eu756KAePUUNqbKLltLXhlLt6Un1zCVe7JbIAlTmMq3i2GEvbrN5rrGieEdUMJKXJ/
	 7gEFyCs8X7SeLTAvEPGTPaVvuwgnRpUlO9wrQsLl5TIGb+lx7YEdznH4jnKEYgKqut
	 BZIHC7fYIlr0y6Czvmp+0tTazxIm9AgDKU0PAaly8rx9hkoaMT7tOkwA1uIQP8Htpw
	 174xKpw4bRkqA==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 18:26:02 +0200
Message-Id: <CZZKH8G2XPIF.1G895LUGG0JWS@kernel.org>
Cc: <linux-crypto@vger.kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, <keyrings@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <iwd@lists.linux.dev>, "James Prestwood"
 <prestwoj@gmail.com>, "Dimitri John Ledkov" <dimitri.ledkov@canonical.com>,
 "Karel Balej" <balejk@matfyz.cz>
Subject: Re: [PATCH] Revert "crypto: pkcs7 - remove sha1 support"
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240313233227.56391-1-ebiggers@kernel.org>
 <CZXWE5J2QMIN.1L4QKQU7C7UMN@kernel.org>
 <20240321041015.GB2387@sol.localdomain>
In-Reply-To: <20240321041015.GB2387@sol.localdomain>

On Thu Mar 21, 2024 at 6:10 AM EET, Eric Biggers wrote:
> On Tue, Mar 19, 2024 at 07:20:54PM +0200, Jarkko Sakkinen wrote:
> > > diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetr=
ic_keys/mscode_parser.c
> > > index 05402ef8964e..8aecbe4637f3 100644
> > > --- a/crypto/asymmetric_keys/mscode_parser.c
> > > +++ b/crypto/asymmetric_keys/mscode_parser.c
> > > @@ -73,10 +73,13 @@ int mscode_note_digest_algo(void *context, size_t=
 hdrlen,
> > >  	char buffer[50];
> > >  	enum OID oid;
> > > =20
> > >  	oid =3D look_up_OID(value, vlen);
> > >  	switch (oid) {
> > > +	case OID_sha1:
> > > +		ctx->digest_algo =3D "sha1";
> > > +		break;
> >=20
> > I fully agree with the change BUT...
> >=20
> > IMHO it would make sense to e.g either add inline comment about iwd
> > dependency or link to the bug report here.
> >=20
> > I'd like to think that there is common will to eventually get rid of
> > all of SHA-1, and thus in cases where it is not yet possible it would
> > make sense to guide what to needs to be done to make it happen, right?
> >=20
> > BR, Jarkko
>
> This is supposed to just be a revert, so it's best not to mess around wit=
h
> adding additional stuff that wasn't in the original commit.  The sha1 sig=
natures
> are also not unique; iwd is also forcing the kernel to keep supporting MD=
4, RC4,
> KEYCTL_DH_COMPUTE, KEYCTL_PKEY_{QUERY,ENCRYPT,DECRYPT,SIGN,VERIFY}, etc.
> Probably more than I don't know about.  I guess all of this should be doc=
umented
> in the code in appropriate places.  Probably the iwd folks should step in=
 to do
> this, as they know best what they're using and they got a lot of this add=
ed to
> the kernel in the first place.
>
> - Eric

OK, fair point.


BR, Jarkko

