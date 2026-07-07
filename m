Return-Path: <linux-wireless+bounces-38724-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HgSYFk2TTGrVmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38724-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 07:49:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94C717953
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 07:49:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=emx5GChy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38724-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38724-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2102A3001FFE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 05:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0EF420877;
	Tue,  7 Jul 2026 05:48:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73362420867;
	Tue,  7 Jul 2026 05:48:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403337; cv=none; b=JO4y2aec1l4FJ5ZOOtdahSDRvtzoWyo+FGVAdGfuxzbWO+zpIsR763hzNm2SITFJM9Q2ebsrIVD+Szsi94nU6Luvd4BKyjHrsybBG5nfiIKKlps/qkEdfao36asmGtWjnz+1sSWBf1qM97UJtPTB18X76FWYjDji2N6X0g+rEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403337; c=relaxed/simple;
	bh=anW19eFsSIJVBDpy1qgRpoTdy9wnCsNqZb16JlXlA7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMjjyV+/RHQTquX8o0l4wcgtyO/er14Ev9TxfOtTOlUtehmTYcTevQu8QiLZfxu5H0dqrZCgi2/ybc96/PTjqgCYOOyEldtM2/937NzTcrxgIsJiG+z9YtfUPjY80G/WvTNXxVSKkGkwuoj6gTQ6nAqrh3sHbrKAtqyZUWEtU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emx5GChy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED32A1F000E9;
	Tue,  7 Jul 2026 05:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783403336;
	bh=QU/N7EOWA0pTmbm6JqvHRwqhI8zxRYtn/Z8dK9VXm94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=emx5GChyymV0h+9hQgfH/03uenGrRszU4oVNF2/0fG/6NglWrLpoXDLKYqKLufPbr
	 hts8EzW5+B7qnenXZwpNhOBQCQlDYadeDPModJ33QwsX4PNDH+u2VmUIxQfNrUmL/J
	 5nThCRsJF1L2uKK0G9WraToYCX/yLhTcxWF29COeCgisLMbLhJ1gvzFZG7oBgvgV42
	 GBTwybvTLsdtDZSRCnNq7foKvVF/JFI74ll+HzWh51jzeIbLx+ywthbuwR0dEN5dQk
	 hg1RrUMfjM75OUkRSGFR7mWm4n0BWZdTwiLM+zfrQ76SSJvS9EydNi2gs7EarG8xf9
	 E9atppRXei8eA==
Date: Mon, 6 Jul 2026 22:47:06 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: mac80211: use aesgcm library
Message-ID: <20260707054706.GA1791@sol>
References: <20260505211841.669767-3-johannes@sipsolutions.net>
 <20260505221653.GA10301@quark>
 <3114cff87fee71ffca7b48f271e2503876518257.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3114cff87fee71ffca7b48f271e2503876518257.camel@sipsolutions.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38724-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD94C717953

On Wed, May 06, 2026 at 09:06:21AM +0200, Johannes Berg wrote:
> Hi Eric,
> 
> > I really appreciate the enthusiasm for the crypto library!
> 
> :)
> 
> > And it isn't
> > surprising, since it's clearly the way to go.
> 
> I was kinda just playing with it, having been reminded that some code
> was already ported.
> 
> > But I do think these two
> > patches are jumping the gun a bit, since we haven't yet migrated all the
> > optimized AES-GCM code into the library, or added an improved AES-GCM
> > API that provides enough functionality to fulfill all the in-kernel use
> > cases (for example, incremental computation of AES-GMAC).
> 
> > So as-is these two patches could regress performance in some cases
> > (despite the library having less overhead).
> 
> Fair. I don't think the performance matters all that much (though I
> shouldn't lie about it in the commit log) since this is mostly used for
> testing - I don't think there are many users of software crypto beyond
> that. Some, for sure, but I believe those are all old drivers that will
> get you a maximum of ~25 Mbps throughput (both directions combined) if
> you're lucky :)
> 
> Anyway, I don't really disagree either, none of this is urgent or
> important at this point.
> 
> Also, there's a separate conversation to be had here - I was looking and
> we also instantiate ccm(aes) and ctr(aes) in mac80211, and I didn't find
> equivalent library calls for those.
> 
> > And also the AES-GCM API is
> > likely to change a bit.  In particular I don't think code outside the
> > crypto subsystem should be constructing its own AES-GMAC by combining
> > the GHASH functions with the AES functions, as your second patch does.
> > Instead they should invoke an AES-GMAC API (or AES-GCM, of which
> > AES-GMAC is a special case) provided by lib/crypto/.
> 
> I _was_ thinking that could be better ... and forgot that GMAC is just a
> GCM special case, despite obviously constructing it by hand. Oops.
> 
> I actually thought about exporting aesgcm_mac(), but of course that'd
> basically be equivalent to just using aesgcm_encrypt() without data.
> 
> However, both of them can only use a single buffer for the associated
> data, so they can't be used here. The crypto API used sg tables which
> aren't great either, but definitely more flexible than the current
> function. Note that in this case I actually need to use three or four
> AAD buffers:
> 
>  - the pseudo-header constructed outside the frame buffer specifically
>    for WiFi, representing the frame header but not exactly the same
>  - for beacons an 8-byte zero buffer representing the Timestamp
>  - the frame payload without the MIC
>    (and without the Timestamp for beacons)
>  - a 16-byte zero buffer representing the MIC
> 
> This would require a more specific GMAC API like the CMAC API, or,
> equivalently but more flexible, an init/aad_update/data_update/final GCM
> API. Could even have
> 
>   aes_gcm_init()
>   aes_gcm_update_aad()
>   aes_gcm_update_data()
>   aes_gcm_final()
> 
> and
>   #define aes_gmac_init aes_gcm_init
>   #define aes_gmac_update aes_gmac_update_aad
>   #define aes_gmac_final aes_gcm_final
> 
> or something like that, I guess.
> 
> > So I'd ask that we wait just a bit until I can finish getting the
> > AES-GCM library APIs into a good state.  I got a lot of the prerequisite
> > work in for 7.0 and 7.1, and I'll see if I can finish it in 7.2.  I've
> > just been a bit busy with other things in the past few weeks.
> 
> Sure, no hurry, was mostly playing with how that'd look like. Maybe it
> even helps figure out the right APIs ;-)

FYI, the following series adds new library APIs for AES-GCM, AES-CCM,
and AES-CTR (and also several other modes):
https://lore.kernel.org/linux-crypto/20260707053503.209874-1-ebiggers@kernel.org/

It also has proof of concept patches that convert many kernel
subsystems, including mac80211, to use them.

It will take a while to land everything, including bringing all the
existing architecture-specific optimizations to the library (which that
series doesn't do).  But I'd like to first land the new APIs as a
starting point.

- Eric

