Return-Path: <linux-wireless+bounces-34519-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCdQMzEO1mmfAwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34519-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 10:13:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E4E3B8D2A
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 10:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07F5C3016EDE
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540CA38E5CE;
	Wed,  8 Apr 2026 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="nZWzoBmZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7637F8AE;
	Wed,  8 Apr 2026 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635808; cv=none; b=OFTGPcEWwY8YKtSxnbtsbruA0P3biGxbrCi9b2TiXzQFlD1vsaji2by+HsczFUzXQr7/2uG7EFkRFHxGFNFp0XOqlo565XCI0wL0Ikl5dhGVu9kwqeW12mOXRDmWzjdmK6rmvB/iP3espiSY2sRm/93W+bg9drnvJkt2ku5wc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635808; c=relaxed/simple;
	bh=dO4bHNRPUKlKtwpt0obegHQbTntRcNbACjSuqqYdhnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKoaqqNtKWh9Ftb1zD8hqGLyvDJqlpIulcqMIh57xbPJe3Qz5KdoOPXxCvcfWRpJJE/onjEfPYNCjdTZXXqmW1SWPdaNDkWr1ezDJNHTzGP1U47rTPLYMzFUpGMrhLBK/bMp04ZY+4o6qM0Cg0xhifL38s33tvOhxTVQyIiYi2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=nZWzoBmZ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=QEIvcTtiGRvK23zLPZf15u4o7zaJgmjEMQaoZVRypx8=; 
	b=nZWzoBmZaHGX/HIl2o/RktOGugr36Y+JXcBY9zHFLA4MoJRynxUHzyv/UKKmprJh+E0hJ0SCTO0
	H9l5XjqSmP1h7UYjWYI4ugvQ3uefVL+/o2Z/RjAprpVEOUpcrw7o8a/bH4/mxp/GhkCc6XjG+iLZ2
	hVlg6WFYkS4oMNzFkX9Ug0Xd4szT7VRPEqJe74b00vQg9z8WAJBJLhcjHQLZEs94roIFTzHPhGV/P
	c/OprzuqyP5v4p1V8X2RsQZWwgyaSYaFCE8qd/Fnl26CdHFq1NykxG/10Dk+dfGQgvFKHyfmvU1yd
	jRnmAO01F+owIDfD5CUDj9+kvxPIef8jbHkw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wANZZ-004dJ0-10;
	Wed, 08 Apr 2026 16:09:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 08 Apr 2026 16:09:56 +0800
Date: Wed, 8 Apr 2026 16:09:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH wireless-next v2 6/6] crypto: Remove michael_mic from
 crypto_shash API
Message-ID: <adYNVB3n358xm_s8@gondor.apana.org.au>
References: <20260408030651.80336-1-ebiggers@kernel.org>
 <20260408030651.80336-7-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408030651.80336-7-ebiggers@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34519-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: 34E4E3B8D2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:06:51PM -0700, Eric Biggers wrote:
> Remove the "michael_mic" crypto_shash algorithm, since it's no longer
> used.  Its only users were wireless drivers, which have now been
> converted to use the michael_mic() function instead.
> 
> It makes sense that no other users ever appeared: Michael MIC is an
> insecure algorithm that is specific to WPA TKIP, which itself was an
> interim security solution to replace the broken WEP standard.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Please feel free to take this via the wireless tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

