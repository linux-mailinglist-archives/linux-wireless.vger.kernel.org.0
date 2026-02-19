Return-Path: <linux-wireless+bounces-32040-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIG3EmyIl2nOzwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32040-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 23:02:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E6163025
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 23:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF6933022686
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 22:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F403090E2;
	Thu, 19 Feb 2026 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIrCqCYN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4F2673AA;
	Thu, 19 Feb 2026 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771538533; cv=none; b=VIN8IO2FjC2+V6UTkCR8iu+PfbzGQ8q5ROAJEMMwWUPi8EZE/phehxpx2EPSgRCy+RcvuWXHHqsymUiVwWeDI9HwRPTGxzUhOa+/b+4KMhJ78A6Acy17kXFLBQxzmOWCCkZMpHi6gQcX6yUn5ASSYr2WBbXG/saj54kZcH/f6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771538533; c=relaxed/simple;
	bh=i4s5I7+0DySZg05blGIiMhp5ILHD+X+eP+E1bMlRf28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy6YQ9x0KENzB7+hBGYRWEckqXPwuWoa6bURRvvdj+qSn/knKMGuUIUYz+pdPGS3+08ITSMJiwNsYlqxPLWKY13N61rCRl52hezdQJil1PKOjInI0uK+O2fknSaDmkr/YCu/IhDYkJ0XbxT+QBYFzTV9D8qLHkKW/tJrUMBbQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIrCqCYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DB1C4CEF7;
	Thu, 19 Feb 2026 22:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771538533;
	bh=i4s5I7+0DySZg05blGIiMhp5ILHD+X+eP+E1bMlRf28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIrCqCYNBgDL27CfO2GlC4purKVTbFYTe2fvm08v5SA9/v0q/5aR8e5X/1PZh5BnS
	 ih+F6QsNAXcd+7+6J6NUY86hWqm0nez6C5U1uBXS4ZU3F8UjNRkb+hFB9/zypXRCm1
	 6RqDFJTEBxQpZfPHQ9FCMVZI/IcYxkaXxW4vEI9814YayfPkCuLFHWXoX638WMNQIQ
	 1ADrzHQs/lJOY96JCnLdxNNQY1+bg5rfMzalpXPiTluzrHCP/r8FuWfBJ6x/yGyTKM
	 DE7rDAKw5wHAB1aMvfEtdGU16jq4BH9OjXKNoz1XnFq+iTQKAI+O5RGVG7RgIDv3r3
	 nxAuPH+Z1mgTQ==
Date: Thu, 19 Feb 2026 14:02:11 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 14/15] wifi: mac80211: Use AES-CMAC library in
 ieee80211_aes_cmac()
Message-ID: <20260219220211.GB32578@quark>
References: <20260218213501.136844-1-ebiggers@kernel.org>
 <20260218213501.136844-15-ebiggers@kernel.org>
 <c3b53ea083fa26c863c6a954d13bbd2ef91e1732.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b53ea083fa26c863c6a954d13bbd2ef91e1732.camel@sipsolutions.net>
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
	TAGGED_FROM(0.00)[bounces-32040-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A06E6163025
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 12:00:03PM +0100, Johannes Berg wrote:
> On Wed, 2026-02-18 at 13:35 -0800, Eric Biggers wrote:
> > Now that AES-CMAC has a library API, convert the mac80211 AES-CMAC
> > packet authentication code to use it instead of a "cmac(aes)"
> > crypto_shash.  This has multiple benefits, such as:
> > 
> > - It's faster.  The AES-CMAC code is now called directly, without
> >   unnecessary overhead such as indirect calls.
> > 
> > - MAC calculation can no longer fail.
> > 
> > - The AES-CMAC key struct is now a fixed size, allowing it to be
> >   embedded directly into 'struct ieee80211_key' rather than using a
> >   separate allocation.  Note that although this increases the size of
> >   the 'u.cmac' field of 'struct ieee80211_key', it doesn't cause it to
> >   exceed the size of the largest variant of the union 'u'.  Therefore,
> >   the size of 'struct ieee80211_key' itself is unchanged.
> > 
> 
> Looks good to me in principle, I suppose we should test it? :)

Yes, I don't expect any issues, but testing of this patch would be
appreciated.  I don't know how to test every kernel subsystem.

> > +		err = aes_cmac_preparekey(&key->u.aes_cmac.key, key_data,
> > +					  key_len);
> > +		if (err) {
> >  			kfree(key);
> >  			return ERR_PTR(err);
> >  		}
> 
> Pretty sure that can't fail, per the documentation for
> aes_prepareenckey() and then aes_cmac_preparekey(), but it doesn't
> really matter. We can only get here with a key with size checked by
> cfg80211_validate_key_settings() already.

aes_cmac_preparekey() indeed always succeeds when passed a valid key
length, as documented in its kerneldoc.  But in this case I recommend
just checking the error code anyway, since ieee80211_key_alloc() can
already fail for other reasons (i.e., it needs the ability to report
errors anyway) and the key length isn't a compile-time constant here.

> Since you're probably going to send it through the crypto tree:
> 
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

For library conversions like this I've usually been taking the library
itself through libcrypto-next, then sending the subsystem conversions
afterwards for subsystem maintainers to take in the next release.  But
I'd also be glad to just take this alongside the library itself.

- Eric

