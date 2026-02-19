Return-Path: <linux-wireless+bounces-32041-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFWPB9eLl2n/0AIAu9opvQ
	(envelope-from <linux-wireless+bounces-32041-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 23:16:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7091F16317F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 23:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B86153038A5C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D079732B9A7;
	Thu, 19 Feb 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmVqCS2y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E132ABCC;
	Thu, 19 Feb 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539329; cv=none; b=qksbaHG0UzVOHqr9De6OK1T9VZbSuzvUw8xMA+vOqAct6rS2Np1Zsa7c/eW9ev0FRwE/29tBn0IRUk8DiAgtIRSIP6WqlA9PDeLXosHDE/WjkLH7EzCQMSArHFF20OQW+CBaT+Tlpe6bJqOL6nevCuSiwIICSfu5bjS9mhyFxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539329; c=relaxed/simple;
	bh=eD3uqcKS6urVjsBvU1YIr7SWeYT2YskOxTQEK12NAqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U47/+7oTlVMdGRnM9l/2tVl5X0DH9m/+UVSN1WOpUaNuQOP06IjdD6X9Nw3uXehyAHGXxu8wxsuCldF/ebPTI1nTFThNPO8VQxEBX80uO98gt4akJ5QmBW7cpFtGqCwAg0zITPlYF6z8D4uWqD0AVJ0cAHHUihtcZE2RLkHKalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmVqCS2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25630C4CEF7;
	Thu, 19 Feb 2026 22:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539329;
	bh=eD3uqcKS6urVjsBvU1YIr7SWeYT2YskOxTQEK12NAqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmVqCS2yIsWtdVpijjEW6bI5Is/3qWKsiDhBA3IUKbSX+J3JVTVSim+ub4xvj1DZ0
	 nXGSAqVuJTjpUVRNiXuBHwihkyKiKLJsan0vgdg+GGhQK1XOzvkHLHN9n2SihjA3AZ
	 nlozFVy5cF6QDOCosPXITEEAmidlFg6JCWj2C7M+LnHMHTJ5tsSDy99srR4wS4ifdl
	 mgpZUuwBdU2/y0JZam9YBERXaDID0G3U2VO8/dcfBdpxyMiEB/8j2440EKA5WgV4ZP
	 qLjX/y1F5lSuFQNczWLWLzXCfZCEUlUFtAmrnRwci9/W414mczTYusgS0OEK5TCOMt
	 fY13VGQLkIjkQ==
Date: Thu, 19 Feb 2026 14:15:27 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 15/15] wifi: mac80211: Use AES-CMAC library in aes_s2v()
Message-ID: <20260219221527.GC32578@quark>
References: <20260218213501.136844-1-ebiggers@kernel.org>
 <20260218213501.136844-16-ebiggers@kernel.org>
 <c62915b1956ee4c5d4bad9315f2bc44aeddbb9bc.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62915b1956ee4c5d4bad9315f2bc44aeddbb9bc.camel@sipsolutions.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32041-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:email]
X-Rspamd-Queue-Id: 7091F16317F
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 12:01:14PM +0100, Johannes Berg wrote:
> On Wed, 2026-02-18 at 13:35 -0800, Eric Biggers wrote:
> > Now that AES-CMAC has a library API, convert aes_s2v() to use it instead
> > of a "cmac(aes)" crypto_shash.  The result is faster and simpler code.
> > 
> > It's also more reliable, since with the library the only step that can
> > fail is preparing the key.  In contrast, crypto_shash_digest(),
> > crypto_shash_init(), crypto_shash_update(), and crypto_shash_final()
> > could all fail and return an errno value.  aes_s2v() ignored these
> > errors, which was a bug.  So that bug is fixed as well.
> > 
> > As part of this, change the prototype of aes_s2v() to take the raw key
> > directly instead of a prepared key.  Its only two callers prepare a key
> > for each call, so it might as well be done directly in aes_s2v().
> > 
> > Since this removes the last dependency on the "cmac(aes)" crypto_shash
> > from mac80211, also remove the 'select CRYPTO_CMAC'.
> > 
> 
> > -static int aes_s2v(struct crypto_shash *tfm,
> > +static int aes_s2v(const u8 *in_key, size_t key_len,
> >  		   size_t num_elem, const u8 *addr[], size_t len[], u8 *v)
> >  {
> >  	u8 d[AES_BLOCK_SIZE], tmp[AES_BLOCK_SIZE] = {};
> > -	SHASH_DESC_ON_STACK(desc, tfm);
> > +	struct aes_cmac_key key;
> > +	struct aes_cmac_ctx ctx;
> >  	size_t i;
> > +	int res;
> >  
> > -	desc->tfm = tfm;
> > +	res = aes_cmac_preparekey(&key, in_key, key_len);
> > +	if (res)
> > +		return res;
> 
> Same here, maybe, technically, but also doesn't matter.
> 
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> 
> johannes

In this case aes_s2v() wouldn't otherwise be able to fail, so ignoring
the aes_cmac_preparekey() return value would indeed be a simplification.

However, since the key length isn't a compile-time constant here, we'd
have to rely on non-local validation, which isn't ideal.

To ignore the return value entirely I'd prefer a static_assert that the
length is equal to one of AES_KEYSIZE_*, which isn't possible here.

It's actually not clear to me where the length validation happens before
here.  nl80211_associate() for example just copies the length from
userspace without validating it.  ieee80211_mgd_assoc() only checks that
the length is at most FILS_MAX_KEK_LEN (64).

- Eric

