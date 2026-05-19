Return-Path: <linux-wireless+bounces-36653-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHjoJHslDGoIXQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36653-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 10:55:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B25F57A986
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 10:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE1AA30227B0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AA53EFD09;
	Tue, 19 May 2026 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nLbj7Kkd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555AA3E16A6
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180913; cv=none; b=jGdcpOlWQzk3XReCPS579r9sjd+OCsMXocdlEsBcdcMXY92BYeljqfguuWlvSlKYrDT4XszK/Q4Lt7S/ts9e+4XMJYf5MuNiMiAiPUKOcTCrX78d2ZPfq+/g+MmjGnBP3s2A0fXcBfPfqp2oO6C8GvS7ceMJosmy8W6yHEetU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180913; c=relaxed/simple;
	bh=9NpsapQApNvNsQ0TsCGdqDy/wJ+DMGXhOIm6+Uw7Kfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXjDDw+yK2AIGyhq2aEiNFXDhyIVSh8lEBrSTqfnzGQVHOEVOh+zdUSbsaC5hWhgcTMF0uM6lFzf3qu13YLd5CQMVA15wmyrkhCsXumbw6eao79mXunf08wP/7kHDaIHoNF5SJwwJ2V/Z/TEyRCHJRyXLYWgqvAafogciQvHwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nLbj7Kkd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9NpsapQApNvNsQ0TsCGdqDy/wJ+DMGXhOIm6+Uw7Kfg=;
	t=1779180912; x=1780390512; b=nLbj7Kkd6nAWWETn2A70GE6QezAvY1ExAojt/PaL944SY/N
	sNMKOwJi3LQp2XLCXG0sCDjJ842v2D35vHCdQwIuVQSg4O5ItkaxXCciAWcN52Y3wLL9ma3/EYa/F
	l+Bd1dBShmbeTtEjd5P6RWdLX6cWoRMD2ZUxiRaPVCu6yhX0q1mwKx5umHkAdAol34heVZd3mhweK
	yPpD17Lrm08fdc5qbGru9ercmwTJwLICa8EISWP+LhFUCUr4W+A0AnOvKSdlzjcoOHHr5aT8IHc4C
	I6AN4mz3kM6dKPLHc16JQbM2hyBtI2CHbhL4hPrdb4gRe04txOkBOW8JgRrqnDUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPGEG-000000062FR-2gXG;
	Tue, 19 May 2026 10:55:08 +0200
Message-ID: <21a4cc48403b338311ea0ff76d757893b1f765cd.camel@sipsolutions.net>
Subject: Re: [PATCH] wireless-regdb: add regulatory rules for Iraq (IQ)
From: Johannes Berg <johannes@sipsolutions.net>
To: wens@kernel.org, Mohammed.Al-Obaidi@badraproject.com
Cc: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org, 
	mnewiraq2000@gmail.com, mnew_iraq@yahoo.com
Date: Tue, 19 May 2026 10:55:07 +0200
In-Reply-To: <CAGb2v66mCBP8KiMF3nRTix_zYDhsb_o4KNj-7-enB0+ULvh0_A@mail.gmail.com>
References: <1886262646.6291779.1777997531793.ref@mail.yahoo.com>
	 <1886262646.6291779.1777997531793@mail.yahoo.com>
	 <dc91809a60874f87a5e9d67f0c4696e5@badraproject.com>
	 <CAGb2v66mCBP8KiMF3nRTix_zYDhsb_o4KNj-7-enB0+ULvh0_A@mail.gmail.com>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36653-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,yahoo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3B25F57A986
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

> As for 10 MHz, I don't think it is supported, so we don't really consider
> that case. I could be wrong though.
>=20
> Johannes, could you shed some light on 10 MHz channel width support?

It's ... complicated?

We support a _very_ limited set of 5/10 MHz operation, but I think most
of it is fairly much unreachable from userspace. I asked about removing
it entirely a few years ago, and some people were opposed, but said
people also haven't actually helped take care of it or anything ... I
was just tempted again a little while back to remove it due to the rates
issues.

Ever since my commit 5add321c329b ("wifi: cfg80211: remove scan_width
support") I believe it has been unreachable on the *client* side, but
given that we still have some support in _nl80211_parse_chandef() and
chandef functions, I expect that it would be possible to still configure
an AP or monitor interface with 5/10 MHz, though only with drivers that
have WIPHY_FLAG_SUPPORTS_5_10_MHZ, i.e. ath5k, ath9k and hwsim. I
wouldn't mind removing it all though.


Is this a concern from a regulatory POV right now, due to say power
density by channel width? This feels somewhat familiar even with higher
channel widths - maybe it's time to add such an attribute to the regdb?

johannes

