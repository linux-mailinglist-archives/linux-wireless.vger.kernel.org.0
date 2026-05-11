Return-Path: <linux-wireless+bounces-36216-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE2SILyhAWpKgwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36216-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 11:30:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D4750AE97
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 11:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80ECC303FFDD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E23BE147;
	Mon, 11 May 2026 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XTy+D2Ki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415673BC687
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490104; cv=none; b=J8LLqI9SZaDz4M/2XTwEGiMt7e1H+DJjqituxbVFJnRlaQbchOPrBz5AKlOXcPcDQRGIgpLwmBBQzZkB7NqnCmUovJXYdp7gl96Z86AP22LnRF3hUcTdEB4mIK27tUgt22VEI4PYb2pBg9zDuveShgssQYpqs5iVxZFexgm4DL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490104; c=relaxed/simple;
	bh=ZG/2HMyNr0wdY51tJ2KpqXvxiEpNqFC3Lfbcj18O9PU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R4023sbABdB+nd8r17BnaNARE6D4xfZOzK8SHh22qio60D28yOGf2xSY9dF0QgHYnDn/odYly3YoxpZAGYjp40JV6NxPv8Ab+2QCIo4cRl6XqOUUD2NhxonhvO+qYtZqhqq/UAuKAa5YoQE0OZ0VoblKI/x/x17tfyubd1u5NNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XTy+D2Ki; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZG/2HMyNr0wdY51tJ2KpqXvxiEpNqFC3Lfbcj18O9PU=;
	t=1778490102; x=1779699702; b=XTy+D2KibET5dGjNTo2m9Y1K95JxuGMY56cYJ2yU1rxP0W0
	FrKscJepc/ZQ/p+jug95ebdGSlhNxIbNsGbVJu+eDpDyrbeNIUxxNi0PohRDqWA0DsY5vLaVdOArV
	al9yXhLCAtbrLu/oGV2W1X2z7ZdEqp9JZt18Vu2DcaXmKVM/L2D3rtz584s+46YDn8Wau2z9GbP7+
	zWw2clzYlpyEodfw+M2hHQQoxA1JaUpsVPRVEiwnT960OPVpiuWdzuViOI5qvXeGZjuZremKZH4Uy
	V9c8GavXpNpb+ErIEqOS3nXJa63kyFWUNyQCsZVkYvGq7WSiAd2a7wsxJcrs7qig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wMMWB-0000000EdNp-39uL;
	Mon, 11 May 2026 11:01:39 +0200
Message-ID: <725b56f42b5fec58196e4055bccb74236145986b.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] Fix overread in PREQ frame processing
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 11 May 2026 11:01:39 +0200
In-Reply-To: <CAFk-A4mD=tKHMp8qqAvrsFZjmJHsA1sBe9Wmmn=qEacNMxTH_A@mail.gmail.com> (sfid-20260511_105817_539632_BF024A41)
References: 
	<db11380dfbe7fff538a1a052fdfc5905202981a4.camel@sipsolutions.net>
	 <20260509234143.101237-1-masashi.honma@gmail.com>
	 <ecb7aef2f18cc7c04817be155017a54a45fa579e.camel@sipsolutions.net>
	 <CAFk-A4mD=tKHMp8qqAvrsFZjmJHsA1sBe9Wmmn=qEacNMxTH_A@mail.gmail.com>
	 (sfid-20260511_105817_539632_BF024A41)
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
X-Rspamd-Queue-Id: E4D4750AE97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36216-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 2026-05-11 at 17:58 +0900, Masashi Honma wrote:
> > This isn't really right since u32_field_get() exists only within
> > mesh_hwmp.c ... it's probably better to modernise all this while at it:
>=20
> Ah, yes. Both the build and tests passed, so I overlooked it.

Yes, it would, but it's basically not self-contained. More of a code
hygiene issue I guess than a real problem right now.

> > and restructure the code accordingly?
> > Anyway, I dunno. Maybe we should just go with your original patch for
> > now. Maybe I'm also asking more of you than others because you have an
> > LLM to help ;-)
>=20
> If it is not urgent, I would like to proceed with the requested restructu=
ring.

Oh sure, as far as I'm concerned there's no urgency, I just didn't want
to keep asking you to make changes too much.

> Actually, I only used the LLM to find potential vulnerabilities, and I wr=
ote
> the code myself :)

Oh OK :) Maybe we need that as a kind of Reported-by? Hmm.

Or you could send a separate bug report email, say there Claude found
it, and then do a Closes: link :-p

johannes

