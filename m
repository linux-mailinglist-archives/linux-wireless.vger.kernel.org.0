Return-Path: <linux-wireless+bounces-35992-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAaGDIXo+mlIUAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35992-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 09:06:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F874D7018
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 09:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4760A30045B9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 07:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B252EA749;
	Wed,  6 May 2026 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="k9AVNd3u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DF36C9E5;
	Wed,  6 May 2026 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051187; cv=none; b=BLDDcBMfZxgmWctVHHTqnRn1u3iQPNk67wkrW/8+6s7IWo4c6P42FKUaYwYW+NASEPp5HBspNa0uZg9yRNxv0StSekuFigE8+0BALPgRskdfMS5dK8McAHQctYMtmogSq/wWJ4ydEKLwFd54HG1nQ/6UGQ7sHu4LvbP6mIfMgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051187; c=relaxed/simple;
	bh=DKWxyzYTP5CiNmlx8n440jAqVP4JjNPdXVHT3e2TEf0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=muXGpz7bRJ32KxXQV3UWYtpMOv/9IKzEbqcOUVXcbtQ6r9GyHtEZGlZAB0FvSmz4H1QQgHQu4FAtvDm18qdNWcX+L3WyqdFrAE4EsXztNKqoijfprCJUkCvlxnfBUek1iPHDI/GwEfTdGyMJAFbOqwpSSZi2GmQjqO28qQ6YTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=k9AVNd3u; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tWzfKxcGmS0L7Um2tEVwBNCmlwSb2zFq35SMvCO6N54=;
	t=1778051185; x=1779260785; b=k9AVNd3uffCGdvPWRjo4HmhxMsVcb3MTgSQmQSwps02auvj
	eKWv47Ed24hgxauMyCIA8UhHMO6fgzl0od1vuL7gsElTcpsLoIE3frYsoHrgFtBFtKhwk/boCgqoG
	U/DlpC7ISmcJQnUA16X/nhNQ8UYAqu9+f4f5g7bSdknoqPOthaUvYbWMA94M1npAzsvR6BbZmHYCX
	TIyL+J5nlHQe5Dg5yJRPLjy5ebx0Zp74QQCVOxaLabPpABiHWGVuk2YrSPz+Q0idTBr+hgCFP85E1
	aTIrqAvotNXC7iHperc6/3oHQFcDgjthTA7JmtUosYG9YpJJg5N1+HX0CVmDFFGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKWKs-00000000Vdq-1vNV;
	Wed, 06 May 2026 09:06:22 +0200
Message-ID: <3114cff87fee71ffca7b48f271e2503876518257.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: use aesgcm library
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org
Date: Wed, 06 May 2026 09:06:21 +0200
In-Reply-To: <20260505221653.GA10301@quark>
References: <20260505211841.669767-3-johannes@sipsolutions.net>
	 <20260505221653.GA10301@quark>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: 44F874D7018
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35992-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

Hi Eric,

> I really appreciate the enthusiasm for the crypto library!

:)

> And it isn't
> surprising, since it's clearly the way to go.

I was kinda just playing with it, having been reminded that some code
was already ported.

> But I do think these two
> patches are jumping the gun a bit, since we haven't yet migrated all the
> optimized AES-GCM code into the library, or added an improved AES-GCM
> API that provides enough functionality to fulfill all the in-kernel use
> cases (for example, incremental computation of AES-GMAC).

> So as-is these two patches could regress performance in some cases
> (despite the library having less overhead).

Fair. I don't think the performance matters all that much (though I
shouldn't lie about it in the commit log) since this is mostly used for
testing - I don't think there are many users of software crypto beyond
that. Some, for sure, but I believe those are all old drivers that will
get you a maximum of ~25 Mbps throughput (both directions combined) if
you're lucky :)

Anyway, I don't really disagree either, none of this is urgent or
important at this point.

Also, there's a separate conversation to be had here - I was looking and
we also instantiate ccm(aes) and ctr(aes) in mac80211, and I didn't find
equivalent library calls for those.

> And also the AES-GCM API is
> likely to change a bit.  In particular I don't think code outside the
> crypto subsystem should be constructing its own AES-GMAC by combining
> the GHASH functions with the AES functions, as your second patch does.
> Instead they should invoke an AES-GMAC API (or AES-GCM, of which
> AES-GMAC is a special case) provided by lib/crypto/.

I _was_ thinking that could be better ... and forgot that GMAC is just a
GCM special case, despite obviously constructing it by hand. Oops.

I actually thought about exporting aesgcm_mac(), but of course that'd
basically be equivalent to just using aesgcm_encrypt() without data.

However, both of them can only use a single buffer for the associated
data, so they can't be used here. The crypto API used sg tables which
aren't great either, but definitely more flexible than the current
function. Note that in this case I actually need to use three or four
AAD buffers:

 - the pseudo-header constructed outside the frame buffer specifically
   for WiFi, representing the frame header but not exactly the same
 - for beacons an 8-byte zero buffer representing the Timestamp
 - the frame payload without the MIC
   (and without the Timestamp for beacons)
 - a 16-byte zero buffer representing the MIC

This would require a more specific GMAC API like the CMAC API, or,
equivalently but more flexible, an init/aad_update/data_update/final GCM
API. Could even have

  aes_gcm_init()
  aes_gcm_update_aad()
  aes_gcm_update_data()
  aes_gcm_final()

and
  #define aes_gmac_init aes_gcm_init
  #define aes_gmac_update aes_gmac_update_aad
  #define aes_gmac_final aes_gcm_final

or something like that, I guess.

> So I'd ask that we wait just a bit until I can finish getting the
> AES-GCM library APIs into a good state.  I got a lot of the prerequisite
> work in for 7.0 and 7.1, and I'll see if I can finish it in 7.2.  I've
> just been a bit busy with other things in the past few weeks.

Sure, no hurry, was mostly playing with how that'd look like. Maybe it
even helps figure out the right APIs ;-)

Thanks,
johannes

