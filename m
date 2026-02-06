Return-Path: <linux-wireless+bounces-31614-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IBtDEughWlKEAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31614-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 09:03:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A059FFB398
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 09:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B840D301FA46
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41F34678E;
	Fri,  6 Feb 2026 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="P/Y8jLam"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680834676F
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364650; cv=none; b=VXwqVVlO30DKvyqUGME11foU8HfpMOtBUuowHfMd3E34zDDdLCkyGfuuujEe6PgIVuKNACJLhS6QXdvTudUdtPuSzHmfmlZX/JlCkfKW0rzzlgOB0uNy3nAFEwvUqzVUDumNwQilc2P7DNGSMii2Ndao5YTRLuGUcXb8zUViRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364650; c=relaxed/simple;
	bh=HYuu7XdUvqfZKqTL+jhWFo6XAN1aRuEldQJNYRYYeD8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sj9UsfBPgZLL8ZsM82I2DdG1y1R0/CTxUEJVkRzyWBftgORuTDWA4iSLpYLYWt+TaD+K9yLSfxVGivbT45/ZKgLTWvikkUe0kv7M53PTe0FFMQphl0SpsWDLgDZM92e0+CWy7wuPo4k59N+bUFRjPyTWKc+kATCJHMI6QZ7FnIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=P/Y8jLam; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HYuu7XdUvqfZKqTL+jhWFo6XAN1aRuEldQJNYRYYeD8=;
	t=1770364650; x=1771574250; b=P/Y8jLamw0sGGOeInpKzeTXfz4MgNLh1nK4g7C2ZTDRic8x
	qF+Tyfqi0wc//z9sCieV+ZY4Mpf5vKnDhBagUvD1KINn8MxEnl2hUgaa5j8cdR33ahveeMH6esA7L
	F30s//4e10bx9rcjNWpSAU1BmgQodVhpXgVPvqujO9grjcRGRpJ+kWUgVaa8F8HpFWJwSQsthUA5F
	8F1oykKLz2MrvMBS5Eyz/708tqoiS5w8sv9pUH83khUCF/jLi2FcmIPPdKF7ZdKkYWaHUox52AvCz
	vwKw07DH29khcR/jnlU0DztS3L6LpKseBXAKtg6c619x2LXcXqzcCEd10jgOxePA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1voGiV-0000000GdwP-3EyE;
	Fri, 06 Feb 2026 08:57:27 +0100
Message-ID: <ec999f04a965006dea6bd8e7380996b6fca980b4.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 1/3] wifi: cfg80211: Add support for
 S1G Response Indication Configuration
From: Johannes Berg <johannes@sipsolutions.net>
To: Ria Thomas <ria.thomas@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com, 
	arien.judge@morsemicro.com, pradeep.reddy@morsemicro.com,
 simon@morsemicro.com
Date: Fri, 06 Feb 2026 08:57:27 +0100
In-Reply-To: <20260206061139.6fdwaazvk4swpreo@1207> (sfid-20260206_071147_312784_7F1F5678)
References: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
	 <20251209062424.3926297-2-ria.thomas@morsemicro.com>
	 <9eb13765529bac88337ab2fd1a13769fa4519f52.camel@sipsolutions.net>
	 <20260109040041.tnk7e6uewo24u3tr@1207>
	 <048c2715d08822d7f79b082cbe332f982d8ced61.camel@sipsolutions.net>
	 <20260206061139.6fdwaazvk4swpreo@1207>
	 (sfid-20260206_071147_312784_7F1F5678)
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31614-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A059FFB398
X-Rspamd-Action: no action

Hi Ria,

> Just wanted to follow up on the earlier reply and check if you've
> had a chance to review it.

Sorry, I had seen it, but it took a backseat to shuffling patches and
other things I had to do, on top of having been somewhat sick until
early this week.

> To explain the implementation a bit more clearly: The issue is that
> response indication from a MAC perspective doesn't really make sense
> elsewhere. It's simply embedded into the PPDU for the VIF that has
> response indication configured, and the receiver uses it to determine
> which type (if any) of ACK to respond with. So it's entirely handled
> by the lower MAC besides of course setting the value from the upper MAC.

Let me summarise that how I understand what you said, and the spec:

The transmitter MAC sets the RESPONSE_INDICATION in the TXVECTOR for the
PHY-TXSTART.request primitive. The (S1G) PHY then embeds this in the
preamble, so that the receiver can react accordingly. There are certain
rules for both transmitter and receiver, but the transmitter MAC has a
certain set of choices for how to set this.

And for the certification test, presumably the choice for testbed STA
(for certain frames at least, I guess not intended to break the rules
for cases where there's no/less choice) is not meant to be left to the
implementation, but rather meant to be set, presumably to check that the
receiver reacts correctly.

(If I got this wrong so far, probably better to stop reading here and
tell me.)


> While it may seem more ideal to sit in a per station or something similar
> where the lifetimes are more natural, there isn't a capability exchange
> that occurs - configuration is more for local transmitter config. On the
> receiver side, it isn't communicated to the upper MAC at all - so conside=
ring
> it as a STA entry dosen't really make much sense.

Yes, I can understand that argument in some way. OTOH, while I'd tend to
agree that it somewhat argues against it being a per-STA configuration,
I'm not really sure it really argues _for_ it being an interface config.

Based on the understanding I outlined above, I'd argue the spec doesn't
really say anything to this effect at all. It leaves a choice to the MAC
implementation on how to set it for every individual PPDU it sends.

Now, clearly we can't very well have an implementation where something
in userspace decides for every PPDU, so we have to make an
implementation choice of how the MAC decides. You've made a choice here
that it should be decided per interface, and due to lifetime issue I've
outlined a choice where it decides per (destination) STA. I don't think
from a spec perspective this choice really matters at all, since the
setting of the TXVECTOR is independent for each PHY-TXSTART.request.

Now that I've described it this way, I think the biggest question I have
is actually how, if at all, we need this in a non-testing scenario?
Which choices of implementation makes sense there? What are the use
cases for this other than testing? I think this could inform the
implementation choice here.

(And as an aside, if it ends up being only for testing, then I think we
can also simply stick it in mac80211 debugfs rather than building out
the elaborate cfg80211/nl80211 infrastructure. But we still need to
decide where it should live, although in that case I'd be more willing
to accept an interface setting despite the lifetime issues.)

johannes

