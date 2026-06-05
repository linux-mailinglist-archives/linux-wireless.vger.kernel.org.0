Return-Path: <linux-wireless+bounces-37406-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ip2JC7h+ImrzYgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37406-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 09:46:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B516461A7
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 09:45:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=HX7TcGac;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37406-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37406-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F07CE31595EA
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB902EEE83;
	Fri,  5 Jun 2026 07:28:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A12343D64;
	Fri,  5 Jun 2026 07:28:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644499; cv=none; b=jy+C7c6I1EyhChYYusIBSZW8Jpw8CibYmIExkOAboFpH8UFmuhjFULPA+w2GQ0JLPCRGpn1N7Ahry6baibT7NDOI9J4Q2dIch6EZG3fNalKVLON4seUVCJRWK5bYhSgKb7l9jn0ARk/nwnfab5S0vF28PJB1F6big7NAIRrb7DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644499; c=relaxed/simple;
	bh=0HROfVI/XiLF1xWKlzwUMuR0jmWMYLR3uT5U1EcQFAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KgtffAj9z0x43KcWVQswuF7zxb9LjfzwMfNP9A1WUNb5PzOlxIe5uk0pjFbsCZrTp4nx2b2f7NAUbJetbrwedP2ORHKqC6bY5QD+TgncnMJ2gcNLLH5o6F0+12K9Y74e9mTS/3IHVFK632SkkTq16vbGfjLomeE/aKnhnC5gySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HX7TcGac; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kg7vhdOMXN34+VP2Kqesep7JkjcC00cEgmM2EsqRbs8=;
	t=1780644496; x=1781854096; b=HX7TcGacX+QPJhYFctqFIcOa451L3yKQc1JJu8FEs3SCoCw
	x+yVUxz9A7PLAOPmoPU6A10UEXSVGQXDvQPaUYSA4evoNRybC9EzhDZcUw9di3SsGpM323ZcZYPEx
	L/qG2UxSikQaaYf3Out3Uo5fo92ZOGbg3gUj2FY51YFb+IWif93ZuQ9vqNc9GYyX9Pt0v0a9p07xA
	ptMX10CFzk2HkqNt5TXX5umneJuPdFMKfbLo6GZhspRhYGVXmpPJ/yzkUxQswWib1yquI8PUbUNR6
	1RYClCoxVgmhysHIwqwH3hK5x+mLJpIpMD7OC1ujeQZSmTmVNMrJdG6HmM9K8zPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wVOyQ-0000000248T-3Esx;
	Fri, 05 Jun 2026 09:28:11 +0200
Message-ID: <93fee0ae9311d6c1e0d72c2c6b15be2de70f3d20.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 12/31] wifi: mm81x: add mac.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, Arien Judge	
 <arien.judge@morsemicro.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 ayman.grais@morsemicro.com, 	linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	llvm@lists.linux.dev
Date: Fri, 05 Jun 2026 09:28:09 +0200
In-Reply-To: <aqbfc2k7xdlggjchxuuklzliuu7cutoqwemjc72zrghhrvwf5f@gqnz7wyqirxx> (sfid-20260605_082632_698815_0923094C)
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
	 <20260430045615.334669-13-lachlan.hodges@morsemicro.com>
	 <e964f5728bde677dc837f55617a83b63c364cbf3.camel@sipsolutions.net>
	 <aqbfc2k7xdlggjchxuuklzliuu7cutoqwemjc72zrghhrvwf5f@gqnz7wyqirxx>
	 (sfid-20260605_082632_698815_0923094C)
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37406-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[morsemicro.com,kernel.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71B516461A7

On Fri, 2026-06-05 at 16:26 +1000, Lachlan Hodges wrote:
> Hi Johannes, just having a think about how to do this:
>=20
> On Thu, Jun 04, 2026 at 01:46:32PM +0200, Johannes Berg wrote:
> >=20
> > > +static void mm81x_mac_ops_flush(struct ieee80211_hw *hw,
> > > +				struct ieee80211_vif *vif, u32 queues,
> > > +				bool drop)
> > > +{
> > > +	struct mm81x *mors =3D hw->priv;
> > > +
> > > +	/* We don't support IEEE80211_HW_QUEUE_CONTROL so flush all queues =
*/
> > > +	if (drop) {
> > > +		/*
> > > +		 * No need to call mm81x_skbq_stop_tx_queues as mac80211
> > > +		 * has already cancelled each queue prior to calling .flush()
> > > +		 */
> > > +		mm81x_skbq_data_traffic_pause(mors);
> > > +
> > > +		flush_work(&mors->hif_work);
> > > +		flush_work(&mors->tx_stale_work);
> > > +
> > > +		mm81x_hif_clear_events(mors);
> > > +		mm81x_hif_flush_tx_data(mors);
> > > +		mm81x_hif_flush_cmds(mors);
> > > +
> > > +		/* Reenable data, not that there will be any */
> > > +		mm81x_skbq_data_traffic_resume(mors);
> > > +	}
> > > +}
> >=20
> > Doing nothing in the !drop case seems questionable - mac80211 uses this
> > sometimes to e.g. make sure a deauth frame really went out before
> > shutting down the hardware.
>=20
> What is the consensus=C2=A0

No idea ;-)

> (or I guess your opinion) on using
> read_poll_timeout() with a function that isn't really doing any real
> I/O but rather just reading software queue state?

[snip]

> It is fairly easy to opencode something similar, but this looks nice :)
> though I can't see many examples of using it like this so I am
> a bit cautious.

I think the more common way to do this would be to have an explicit
waitq so you don't have to poll, and trigger that whenever the queues
become empty.

With hardware you often don't have a signal so you have to poll, though
in some cases if you have an interrupt you'd prefer that too.

johannes

