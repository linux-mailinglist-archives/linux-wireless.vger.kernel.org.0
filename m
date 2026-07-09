Return-Path: <linux-wireless+bounces-38832-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 13ivCvS9T2qingIAu9opvQ
	(envelope-from <linux-wireless+bounces-38832-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 17:27:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6320732E1C
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 17:27:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Uty3H4Ne;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38832-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38832-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C1C13071E70
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8E63655C9;
	Thu,  9 Jul 2026 15:20:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060EC29994B;
	Thu,  9 Jul 2026 15:20:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610429; cv=none; b=qHvJrzLQJNxCdBKo0KIxi9kneqwsaxo8tg017aJHDe25OZlqItLTxGrrspJXpq2+hxoysC88WOxcQ9CRWVHBXXstL4Xu5+F5bwfwLgvUPIMUtY6ijEPhvEb/u/TeZ4jX9s9KereVastbvpkaEpUPYxAy2I45IvXA+P3+w5ZF5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610429; c=relaxed/simple;
	bh=l+O/N7/Sfo+OIJ29+vq2Ncy6LI0rpLCq7cdZnMdfmFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCCK9OYPwZWWi/Qzh/NWk5Q8zB50avGLsaWByoWMlxpdy98Lq9DQ5KJGxGYnFvpKk2XT41pBEop3A/BN415kdw/L5Mca4vZsZbErpmfs4MkrjSah33ZG5nTVel6zxml0gn/ul8Cv86kTg8mYkwrblQ92SunzUpBcBC0nSGmuWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uty3H4Ne; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4FA1F000E9;
	Thu,  9 Jul 2026 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783610427;
	bh=4l8lY6Q6Go3CcxEyF3ceEniIs1l0TP4SkSw4jvr90+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uty3H4Ne/CuhS2WYsssWWEiDnAPo/3Irw0Q23jiEBXAo8vl7QsH2WdIdYC8cZACF3
	 z+pgtQ/HR8P4jVlbRrhLAO+/DdAWFeDn+/USeIi/ZeiRyM4VvNDt6KqMlLsJQ/ZGGQ
	 qMsKQNmFOEEvEr2k1uWV6Iv0SZV1opAthgNYCMfi9ECvG/rJqPgDkgdTw2/gm9aby9
	 Z4Jp4HvtMyGxFGARtY4oE7MznkM7e+AZqjFErpViZa2InRhC7UDFLkUV968H5v4Nrf
	 HG90HaTBB7QihEIVelvG36sTBA89p3OpL8taOYX/ZTqNRUF86lnOYiK7WDKIJv6Rbq
	 ZtRiKrolsMQyw==
Date: Thu, 9 Jul 2026 11:20:25 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Jouni Malinen <jouni.malinen@oss.qualcomm.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: Fix cryptographic MAC comparison to be
 constant-time
Message-ID: <20260709152025.GA3342@quark>
References: <20260709024443.58132-1-ebiggers@kernel.org>
 <3e8e6ff58a0809b0346d133c01eda720367eb511.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e8e6ff58a0809b0346d133c01eda720367eb511.camel@sipsolutions.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:jouni.malinen@oss.qualcomm.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38832-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6320732E1C

On Thu, Jul 09, 2026 at 08:45:35AM +0200, Johannes Berg wrote:
> On Wed, 2026-07-08 at 22:44 -0400, Eric Biggers wrote:
> > To prevent timing attacks, the comparison of cryptographic message
> > authentication codes (MACs) needs to have data-independent timing.
> > Replace the memcmp() with the correct function, crypto_memneq().
> > 
> > Fixes: 39404feee691 ("mac80211: FILS AEAD protection for station mode association frames")
> > Cc: stable@vger.kernel.org
> 
> I guess I'll apply (a variant of) this patch for -next, but that commit
> log really makes it sound like something is actually broken and needs
> fixing, and I don't think that's true in this specific context.
> 
> What happens is that the frame is validated and then we associate
> successfully (upon success) or drop the frame (upon failure). Only the
> failure case is relevant for the timing issue, but in that case we
> simply drop the frame and there isn't really an observable signal -
> nothing else happens, at least not immediately, we may retry the request
> later after a timer.
> 
> So sure, it looks better to have a crypto_memneq() in AES-SIV related
> code, but in practice I don't see how it would make a difference now,
> and it's even unlikely this code will ever matter for anything else in
> the future, given that things are moving more and more towards full
> frame encryption, including association request/response now.

Surely the other end of the connection could observe a difference in
timing at some point?  Even if only a very small amount and not right
away?  A timing attack doesn't take much.

It's safest to assume that this is a bug fix.

We've gone through similar crypto_memneq() conversions in other
subsystems, where maintainers try to come up with some heuristic
argument that timing attacks don't apply.  Those arguments tend to have
holes.  I'm not sure why people are so eager to risk it.

> I saw you originally had this in the "use libraries" patch [1], I'm also
> good with you just keeping the change there. This might even be better
> if you're planning to have this in -next soon, where it would otherwise
> conflict if I keep this to -next.
> 
> [1] https://lore.kernel.org/linux-crypto/20260707053503.209874-24-ebiggers@kernel.org/

I just figured this is a bug fix worth splitting out.

Only patches 1-13 of that series are intended for 7.3, so this would be
a good time to get any preliminary fixes in to code that is going to get
converted to use the library later.

- Eric

