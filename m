Return-Path: <linux-wireless+bounces-38722-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /8KlI49wTGozkgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38722-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 05:20:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD940716FD1
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 05:20:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nhoward.dev header.s=purelymail3 header.b=v3EGpege;
	dkim=pass header.d=purelymail.com header.s=purelymail3 header.b=hz6HQmJl;
	dmarc=pass (policy=reject) header.from=nhoward.dev;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38722-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38722-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D6930075E5
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 03:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133B62EEE95;
	Tue,  7 Jul 2026 03:20:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B031B3925
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 03:20:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394445; cv=none; b=m2eVUSOBChoomHXHCuzD6aePp9o98nnqua3X2Z/wvTTtsyoN8leg69KORK0PFHj8HbZRydj18KGSGv0i6e8y4w8qeRiVE8d1HQvhOTHS524uUUb6k6OpLfvW59ipg4Sdje6QfZVQJYnPn857Jeo7En8JmfZwunHsMNlb5AgDqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394445; c=relaxed/simple;
	bh=dQV/CiU/iqAz99nUMSlO2Rjk3UDc96lFE+tP58d/mbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZeFZD6iK43eOpYSS4LPPMhlHaV6x+i9xwdWahA/FcfxA0A0D79dz6C/2bEys12lcl2e0IQc6g3W1/tzHgsnjMXekYbQ2EErxNHymLOtvft1sJu1gGrmXcgEftE7KIltKwNwAuirXTtgXfm+XP1auKm97AwsmP8rBDL1sn45j/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nhoward.dev; spf=pass smtp.mailfrom=nhoward.dev; dkim=pass (2048-bit key) header.d=nhoward.dev header.i=@nhoward.dev header.b=v3EGpege; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=hz6HQmJl; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=v3EGpegeBYyTx2MZ2j+4meSc14Q1y2Vr5xF5bnNhC9ruC7NzLVy6lxdeofAK+9qXX2nRQ7vYtvuqPWccRMx5AXD5KLA15N9b3AnkDLRQET5yLG+E0129c2J5iMPM08XU5uVorAVjvgczhx4pWV0NTba8rtucQfw8f1HUOKM79kTR0TFcLeTRQ74A2RLQqpTyvTaBdeWQo1B+kUyKWTqTjxp1L7QJzvPVEOsTVaM1Qufp8+806DKMvnCJFyxAzSvKxxUHjgGnC/6xL3rtXytegoSQ3bBtWmGODgrRx8aFjP3Bohp4W2YnD+9d1LMfAPZb8po3BtOLnnD8javjNNGV+Q==; s=purelymail3; d=nhoward.dev; v=1; bh=dQV/CiU/iqAz99nUMSlO2Rjk3UDc96lFE+tP58d/mbM=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=hz6HQmJlQz7UQNgnl5W4nUpl24+nQIPXmZG5G1/pQlb7y1R+iDfh+E2t5tZ81Gb3hxcNcOjejpKxvkZAehLxMmOsK3EsfONsmkRK/22otUgxpTWdUz7MOyxeiaCCBGoPHdjzj5kqY8OB+82y1ivb+G79y9nNdYD4irZODYH+/o6ttNS+QGXPWJi1bcPWJZ2W6VGZ13WVCDGAHSJRQwJP0lgGEMs9k7kDcUHTJhUTTdUC2mFlo1Z00bV7RyDQfvycWnswKOkp18q9yq3Wy+ctyRlMmBYdM6DPQsgsIEiow0nFmqTDhDWvX8YrF7Ah0w44etGG07ep2xvKhsej2HPLMw==; s=purelymail3; d=purelymail.com; v=1; bh=dQV/CiU/iqAz99nUMSlO2Rjk3UDc96lFE+tP58d/mbM=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 823466:39853:null:purelymail
X-Pm-Original-To: linux-wireless@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1306190242;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 07 Jul 2026 03:20:28 +0000 (UTC)
Date: Mon, 6 Jul 2026 23:20:26 -0400
From: Nathan Howard <kernel@nhoward.dev>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Yingjie Cao <yingjcao@sigvoid.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: only accept IBSS channel switch from our
 own BSSID
Message-ID: <akxwel29T0_gvu8Z@gpu1>
References: <20260623090437.13198-1-yingjcao@sigvoid.com>
 <c3fd8617849368e579a56c4397b7ee8624ef27ad.camel@sipsolutions.net>
 <9201d828365fa2b11fb6a83d1ff66365435a9072.camel@sipsolutions.net>
 <ajrfKAmdZnPPkGKE@gpu1>
 <b7dab24792025a5a95b719ef7d508fb109859ec1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7dab24792025a5a95b719ef7d508fb109859ec1.camel@sipsolutions.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nhoward.dev,reject];
	R_DKIM_ALLOW(-0.20)[nhoward.dev:s=purelymail3,purelymail.com:s=purelymail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:yingjcao@sigvoid.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kernel@nhoward.dev,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38722-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@nhoward.dev,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nhoward.dev:+,purelymail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gpu1:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD940716FD1

On Mon, Jul 06, 2026 at 10:53:33AM +0200, Johannes Berg wrote:
> On Tue, 2026-06-23 at 15:31 -0400, Nathan Howard wrote:
> > 
> > So, what's the litmus test?
> 
> I don't know, tbh.
> 
> > I've been watching this list for some time
> > now.  I've seen (what appears) to be an ushering of distrust brought
> > on by llm's.  This also seems to have come into prominence within the last 6 or
> > so months.  I understand the cautious approach, but what if one's been
> > working diligently (and quietly), and has spent many hours studying and
> > preparing a driver series (for oneself and submission to the kernel)?
> > I've always done well by doing my homework the hard way.  But now,
> > submissions are met with skepticism... that the work must have been
> > assisted-by if the person doesn't have a track record.  How should one defend
> > his work (I'd rather not share credit with a machine when my work is my own)?
> > To be clear, my question is sourcing from what I've seen to be trending
> > more recently whereby several submissions have been ?softly? tagged as assisted-by.
> > Maybe they were, but my point still stands.  Kindly provide guidance.
> 
> I'm convinced that if you've actually done the legwork you could defend
> the work you've done. If you're willing to go on the record saying you
> _didn't_ use an LLM I'm even going to believe it.

This sounds reasonable.

> 
> But if someone's sending "critical security fix that needs security@
> involvement" across a wide spectrum of places then yes, I'm going to be
> highly sceptical they actually know what they're doing on any individual
> one of the issues.
> 
> Like here. OK, this one didn't go to security@, and it's not even a
> wrong fix, but doing "Cc stable", Cc'ing half the world and not
> following up *at all* are all bad signs.

As does this.  Thank you for the guidance.


