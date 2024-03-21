Return-Path: <linux-wireless+bounces-5076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2760881BD1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 05:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBB1282923
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 04:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021A9BE6B;
	Thu, 21 Mar 2024 04:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE+RaFT8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F55C121;
	Thu, 21 Mar 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994217; cv=none; b=KECHWKa4EXQPu2OrzL4kiv7UmecYpWdTaSbNGHV81I3JX+xItFfPsABu8NczUZnIW3j0SCvpMIBFDWuMYiN/d/0jos+M7qH2Q2q2zccqXTpdBXHjexgmOuIm4Zrvst/vahL4Q0XSaCiWxT/mGnNCBZNbhuFQoMQmFgf4g11LJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994217; c=relaxed/simple;
	bh=492oxbbEZ/C2M/Is0xJ5/EiDlPW5Zy2jfrLxEFhETvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUaCCMfZv307m8BUsA/e/sczNzXqxA1JJ64Zg4J74CEt34q1gwFPbzymq560zByJzAh4AJtWsKCPLQ19xEZawTTdQtDnd4UZD9zsGxIEZerDn+gF2iYGoVNy3uxgSsW9YWTqs2wIl86I1fnSiPZbLJvTixUjnUlFbJJjMPDttIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE+RaFT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21794C433C7;
	Thu, 21 Mar 2024 04:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710994217;
	bh=492oxbbEZ/C2M/Is0xJ5/EiDlPW5Zy2jfrLxEFhETvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pE+RaFT8lzpJHiBQG0vJUUueGG70Zi0nvYOSwKvz49eS/D9AxsFidT/aHjOMz+C3y
	 zgyq+utYRc5nTTe0VOWsWCsdh6EjfH7VsDP7pxYWuvI7/t1sT0aFyJGdawzCns7xHH
	 cbZ33zhQy6oyJVU0Pjp4U/GI1jukolbV/+onsXIc8EhSbsJtRG+QS//756XEMSVaMx
	 x4WPHFgaUz+kjPiSZ+utBh36clFc68s/kQvNUyX1bClUl9ABZEx0IxjWtxabLvy7YW
	 xJJd79U3/IeenAhICWkV6ZYKVbWEhwEDm94xSmPzYZM8e3uaqVxD+Ev5L8yrBoSUjW
	 vvzw2kS69O2kA==
Date: Wed, 20 Mar 2024 21:10:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	keyrings@vger.kernel.org, linux-wireless@vger.kernel.org,
	iwd@lists.linux.dev, James Prestwood <prestwoj@gmail.com>,
	Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	Karel Balej <balejk@matfyz.cz>
Subject: Re: [PATCH] Revert "crypto: pkcs7 - remove sha1 support"
Message-ID: <20240321041015.GB2387@sol.localdomain>
References: <20240313233227.56391-1-ebiggers@kernel.org>
 <CZXWE5J2QMIN.1L4QKQU7C7UMN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZXWE5J2QMIN.1L4QKQU7C7UMN@kernel.org>

On Tue, Mar 19, 2024 at 07:20:54PM +0200, Jarkko Sakkinen wrote:
> > diff --git a/crypto/asymmetric_keys/mscode_parser.c b/crypto/asymmetric_keys/mscode_parser.c
> > index 05402ef8964e..8aecbe4637f3 100644
> > --- a/crypto/asymmetric_keys/mscode_parser.c
> > +++ b/crypto/asymmetric_keys/mscode_parser.c
> > @@ -73,10 +73,13 @@ int mscode_note_digest_algo(void *context, size_t hdrlen,
> >  	char buffer[50];
> >  	enum OID oid;
> >  
> >  	oid = look_up_OID(value, vlen);
> >  	switch (oid) {
> > +	case OID_sha1:
> > +		ctx->digest_algo = "sha1";
> > +		break;
> 
> I fully agree with the change BUT...
> 
> IMHO it would make sense to e.g either add inline comment about iwd
> dependency or link to the bug report here.
> 
> I'd like to think that there is common will to eventually get rid of
> all of SHA-1, and thus in cases where it is not yet possible it would
> make sense to guide what to needs to be done to make it happen, right?
> 
> BR, Jarkko

This is supposed to just be a revert, so it's best not to mess around with
adding additional stuff that wasn't in the original commit.  The sha1 signatures
are also not unique; iwd is also forcing the kernel to keep supporting MD4, RC4,
KEYCTL_DH_COMPUTE, KEYCTL_PKEY_{QUERY,ENCRYPT,DECRYPT,SIGN,VERIFY}, etc.
Probably more than I don't know about.  I guess all of this should be documented
in the code in appropriate places.  Probably the iwd folks should step in to do
this, as they know best what they're using and they got a lot of this added to
the kernel in the first place.

- Eric

