Return-Path: <linux-wireless+bounces-35956-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B1QNWVs+mmaOwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35956-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 00:17:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DF34D4401
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 00:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F7B7303FFDF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5E31716D;
	Tue,  5 May 2026 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbldA9BL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E633064D;
	Tue,  5 May 2026 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778019416; cv=none; b=MtonzhDamBCSTUa5BIsN//IwyiA543HOF7c0FW+UbfBnOis1orO/4uGj/Tn70o2fNpfwaw32fMPMLH4CFvWwtQPsEWxUPjziqCD6UfMZEoq47PQtM9q7UZfSHxfulHRXGMkx9CXk9eEOa56qUNfZlbbSKGK1xhyufQS8yQbQI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778019416; c=relaxed/simple;
	bh=++lntmt6nH/fLIE6NQxbXNUEzwIv69a4DvKg0MtlBfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsgaS39sLc8PytfK3pFn9ZJ+xjITggRANQpKfpdMOgY8rEgzFpCjbseXk2HDGyZGGnCHCett0JB0GeTspZnwl7QbvMsEgS3wXyYPEsMqNIvg8Hvg2qZUeSh/3Yo+HJFbG0P7gPY56tBc8jL6rlDzQk1qit2YG+BvknNZSHEQy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbldA9BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C29C2BCB4;
	Tue,  5 May 2026 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778019416;
	bh=++lntmt6nH/fLIE6NQxbXNUEzwIv69a4DvKg0MtlBfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbldA9BLGrUa977bUZw3p1tQyOwdvQzdSJ7Ed/jSQFOCwXVBdh0c3V+bx9I3qsPtQ
	 sPcfsaMe1wJE0WRdEfmhxv+bFTjp0382JFg4uG99I3pmBDTQpdvN0GJz81uU27CwCf
	 bbPY3HSZOP8e3bbUFlsH9C3srYzopnoDgFSy+CYf5YpgryrxI1woUHVJzI5KiAkLIg
	 i40PGsqKHuEOYzZ/WCPVVfKXr1z15hDdw8UYgak3nh+sOGki3U+hN2jQwoA/Tml5ia
	 XNNElzmVo4ok3aWzVhel/raVFA1d5kn1Wq9j5SjDxqM1LfZ9SP8HzQKCI67GA3oG7n
	 +HwCQ3dg9GGlw==
Date: Tue, 5 May 2026 15:16:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 1/2] wifi: mac80211: use aesgcm library
Message-ID: <20260505221653.GA10301@quark>
References: <20260505211841.669767-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505211841.669767-3-johannes@sipsolutions.net>
X-Rspamd-Queue-Id: 39DF34D4401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35956-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

Hi Johannes,

On Tue, May 05, 2026 at 11:18:38PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Instead of dynamically allocating the gcm(aes) algorithm, use
> the library. This is faster and avoids the extra allocation.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/mac80211/Kconfig   |  2 +-
>  net/mac80211/aes_gcm.h | 39 +++++++++++++++++----------------------
>  net/mac80211/key.c     | 11 +++--------
>  net/mac80211/key.h     |  3 ++-
>  net/mac80211/wpa.c     |  9 +++++----
>  5 files changed, 28 insertions(+), 36 deletions(-)

I really appreciate the enthusiasm for the crypto library!  And it isn't
surprising, since it's clearly the way to go.  But I do think these two
patches are jumping the gun a bit, since we haven't yet migrated all the
optimized AES-GCM code into the library, or added an improved AES-GCM
API that provides enough functionality to fulfill all the in-kernel use
cases (for example, incremental computation of AES-GMAC).

So as-is these two patches could regress performance in some cases
(despite the library having less overhead).  And also the AES-GCM API is
likely to change a bit.  In particular I don't think code outside the
crypto subsystem should be constructing its own AES-GMAC by combining
the GHASH functions with the AES functions, as your second patch does.
Instead they should invoke an AES-GMAC API (or AES-GCM, of which
AES-GMAC is a special case) provided by lib/crypto/.

So I'd ask that we wait just a bit until I can finish getting the
AES-GCM library APIs into a good state.  I got a lot of the prerequisite
work in for 7.0 and 7.1, and I'll see if I can finish it in 7.2.  I've
just been a bit busy with other things in the past few weeks.

Thanks,

- Eric

