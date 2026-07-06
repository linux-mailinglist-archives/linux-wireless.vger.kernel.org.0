Return-Path: <linux-wireless+bounces-38662-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ISKKIix1S2onRwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38662-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 11:28:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283870E9A3
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 11:28:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=Q9Pnm0mP;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38662-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38662-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B493351BD6
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4405842467C;
	Mon,  6 Jul 2026 08:53:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF254218A0;
	Mon,  6 Jul 2026 08:53:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328032; cv=none; b=qaIJrST3MuhTi5+9+/sP6NmxwHxYeJ/7kW7rRSEUnbhJdXsyzBTkjCWbN3wJNMrmmFi6WAo0THMabzlbxbRLDVbQUQf0Pq0kiGM8v3C3MXGgc9y9ijfCTHXvBjtxOPlrUI3BrHlC0/f5JAjVrx0EDRFvC36pP/7Ws7hls0+pkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328032; c=relaxed/simple;
	bh=/TvKec/XC0JTbdAOQu/yIL/e78/xfDt000sU/A6eGUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QV6RTO9vWW4r+CPQB13jY/kKo3Ba/fQ4dmkPVwejLK92yHR4Sbvc1DvIlio4EKfalHhhSJw3bKuM3t3F2AG0AueM1egYYyuoB1RXLT4xqhyRWYokmcR9eaKHaHcHT6PhUWX3EnGvM79M+GinIPyuZIBRH0rYmRD2p/lpB6v6Qas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Q9Pnm0mP; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HOYq0y24CEIaSGuKk/5JaHh7YaHxGnPSgB515RKcgqg=;
	t=1783328021; x=1784537621; b=Q9Pnm0mPqrCkbHXOVNM/VoewIEYXqdYKG7M48uIPmWeQPdl
	MGE15PdsF6k3MP/BzJIlBqTqPikPWU15UuK2BROrCwddRnqwG0abOnuBO/DRLUAed5W9UeUwop2LK
	+88ZXtXHKUT2t6QAXgDo8J0V5RdCvSrCeB7TFkSc+8A5jeXMUd9a9mFXLPTUZq0BWyWVIW9ewuWTM
	SZu6IOHM0vpRx0YPHKlLkKJDZ+Ty0r/VdlyUJKE0fRv5XjS6bwyYKT/HingLCnhJodPuAUql4XNGh
	hGvO0bXHXM2eZa2dSM7qE49dMYgSK3toFDNenaaRyQSZ5M+AtpH8jxlMZzo7Mf2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wgf53-0000000CgRq-438V;
	Mon, 06 Jul 2026 10:53:34 +0200
Message-ID: <b7dab24792025a5a95b719ef7d508fb109859ec1.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: only accept IBSS channel switch from
 our own BSSID
From: Johannes Berg <johannes@sipsolutions.net>
To: Nathan Howard <kernel@nhoward.dev>
Cc: Yingjie Cao <yingjcao@sigvoid.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 06 Jul 2026 10:53:33 +0200
In-Reply-To: <ajrfKAmdZnPPkGKE@gpu1>
References: <20260623090437.13198-1-yingjcao@sigvoid.com>
	 <c3fd8617849368e579a56c4397b7ee8624ef27ad.camel@sipsolutions.net>
	 <9201d828365fa2b11fb6a83d1ff66365435a9072.camel@sipsolutions.net>
	 <ajrfKAmdZnPPkGKE@gpu1>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kernel@nhoward.dev,m:yingjcao@sigvoid.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38662-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1283870E9A3

On Tue, 2026-06-23 at 15:31 -0400, Nathan Howard wrote:
>=20
> So, what's the litmus test?

I don't know, tbh.

> I've been watching this list for some time
> now.  I've seen (what appears) to be an ushering of distrust brought
> on by llm's.  This also seems to have come into prominence within the las=
t 6 or
> so months.  I understand the cautious approach, but what if one's been
> working diligently (and quietly), and has spent many hours studying and
> preparing a driver series (for oneself and submission to the kernel)?
> I've always done well by doing my homework the hard way.  But now,
> submissions are met with skepticism... that the work must have been
> assisted-by if the person doesn't have a track record.  How should one de=
fend
> his work (I'd rather not share credit with a machine when my work is my o=
wn)?
> To be clear, my question is sourcing from what I've seen to be trending
> more recently whereby several submissions have been ?softly? tagged as as=
sisted-by.
> Maybe they were, but my point still stands.  Kindly provide guidance.

I'm convinced that if you've actually done the legwork you could defend
the work you've done. If you're willing to go on the record saying you
_didn't_ use an LLM I'm even going to believe it.

But if someone's sending "critical security fix that needs security@
involvement" across a wide spectrum of places then yes, I'm going to be
highly sceptical they actually know what they're doing on any individual
one of the issues.

Like here. OK, this one didn't go to security@, and it's not even a
wrong fix, but doing "Cc stable", Cc'ing half the world and not
following up *at all* are all bad signs.

johannes

