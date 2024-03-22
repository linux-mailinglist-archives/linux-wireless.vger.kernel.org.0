Return-Path: <linux-wireless+bounces-5150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 140FE886B75
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 12:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985C3B21454
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB13F9CE;
	Fri, 22 Mar 2024 11:45:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AE3F8F4;
	Fri, 22 Mar 2024 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107902; cv=none; b=tCC8bFI8XJoR4T6c6K7iaUiVNGBLkTO0I758ikqMt9bvfO1jzex3KA4oYjiAPglMaWbl2QUG0NTyzAGqu2wPP/w0IgKJw6QNM3QMlBqseglq73iVoh8DaRbreygyyYGj042Xgwe4zbSF85nR9WSNIDKOqXkGwEPch/4lu9CDYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107902; c=relaxed/simple;
	bh=3TzN2Lt6QPOtvQCHtJ7t44fnCg8LERCTZqdH35s6BEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/3xWJZ636Xmd1z9dFFBrxlD3Y2/vBZbQRBIuemvw7sHrGCb+UrWHyUjW02YRnitxc9VIJvOKFX8Ug/4s5NIxaTS1kJTI64oZPAqTUgRZuBo/DP8AYcCIK3GvvGS2O91zfnFllF+U5w5WQuPmsDyiIYLct6nbs/BBzsGUMdSxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rndKP-009XMk-Km; Fri, 22 Mar 2024 19:44:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Mar 2024 19:45:09 +0800
Date: Fri, 22 Mar 2024 19:45:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
	linux-wireless@vger.kernel.org, iwd@lists.linux.dev,
	James Prestwood <prestwoj@gmail.com>,
	Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	Karel Balej <balejk@matfyz.cz>
Subject: Re: [PATCH] Revert "crypto: pkcs7 - remove sha1 support"
Message-ID: <Zf1vRbvwYvj1KcTS@gondor.apana.org.au>
References: <20240313233227.56391-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313233227.56391-1-ebiggers@kernel.org>

On Wed, Mar 13, 2024 at 04:32:27PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This reverts commit 16ab7cb5825fc3425c16ad2c6e53d827f382d7c6 because it
> broke iwd.  iwd uses the KEYCTL_PKEY_* UAPIs via its dependency libell,
> and apparently it is relying on SHA-1 signature support.  These UAPIs
> are fairly obscure, and their documentation does not mention which
> algorithms they support.  iwd really should be using a properly
> supported userspace crypto library instead.  Regardless, since something
> broke we have to revert the change.
> 
> It may be possible that some parts of this commit can be reinstated
> without breaking iwd (e.g. probably the removal of MODULE_SIG_SHA1), but
> for now this just does a full revert to get things working again.
> 
> Reported-by: Karel Balej <balejk@matfyz.cz>
> Closes: https://lore.kernel.org/r/CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz
> Cc: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/asymmetric_keys/mscode_parser.c    |  3 +
>  crypto/asymmetric_keys/pkcs7_parser.c     |  4 ++
>  crypto/asymmetric_keys/public_key.c       |  3 +-
>  crypto/asymmetric_keys/signature.c        |  2 +-
>  crypto/asymmetric_keys/x509_cert_parser.c |  8 +++
>  crypto/testmgr.h                          | 80 +++++++++++++++++++++++
>  include/linux/oid_registry.h              |  4 ++
>  kernel/module/Kconfig                     |  5 ++
>  8 files changed, 107 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

