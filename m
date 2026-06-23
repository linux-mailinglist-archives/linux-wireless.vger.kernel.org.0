Return-Path: <linux-wireless+bounces-38021-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DNNALGDHOmrRGggAu9opvQ
	(envelope-from <linux-wireless+bounces-38021-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 19:50:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B26B93F8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 19:50:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=FLrvvp6S;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38021-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38021-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F8CE300C83E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A2390613;
	Tue, 23 Jun 2026 17:50:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670003905E3;
	Tue, 23 Jun 2026 17:50:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237014; cv=none; b=PQM9XWNSgHRrEWm+O8CHJXrcH+Wx+QrcFq2Nev/nvufkB0zupU3/g3OPait86YgNFLIIkOFuSfUB+mqvGgXfvEZ+3yJhDYSvp7GW8tCaxyxrAl4jQsXpTn/eI+nyJ/gt53W4wKW+3fHQX1tiV6OzLNHE9vLMCWUQzGxtnMz4fR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237014; c=relaxed/simple;
	bh=+JdrjsYKUQPP+AJ1Ipz4wdn3hc3rh4DAOl755B86FG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPBAYxwa7E0Q1AvLmsT2ESteit/swzLq7+qKO+wIbJuQX7B6CvqVDyZyK9124bve8rY++GbwFrkur9dUrLmyVZX3wgD4mkgnM/nKv7o5CiOE1rydvOm1rELlP0lxMaOHzwCwsKjFzObWIP0BcbDY5jnMsh8N1PEABAWzooX9Tww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FLrvvp6S; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+JdrjsYKUQPP+AJ1Ipz4wdn3hc3rh4DAOl755B86FG0=;
	t=1782237012; x=1783446612; b=FLrvvp6SGxzv9oZgUN5pNguzw7NlXUIMbA807ijlz9aOwkT
	JRjRfCmV6tg+1oT2KQYKe6CxUxhkqK9rSJYVMi4eRunD0pfyDQdAe9ppJlpQEefuSVv7icAWDexK0
	fUK3EKLh5++kqZ+AWNJ2n5YMIz3fAqJduUMS2KgP2rk86lKOOrtfDfOBTU3RNdyyXqVyZgc5V7Xws
	3djroDjk02KsmAllBffkV67FNmdUsRJpOxg5ceAEY9Az6E/w4DuWi/wHoOl9aKlXCvn8wxI7B4BN7
	MNVOXDgygP/i5elV0GkHbve/5CXqkgLKstIzrfmVc1ttojzUhaz+Db2GWHqH2aiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wc5G6-0000000Eiey-2W2y;
	Tue, 23 Jun 2026 19:50:02 +0200
Message-ID: <3511ab1ebd943677ba6a62c4e807db7dd762717b.camel@sipsolutions.net>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
From: Johannes Berg <johannes@sipsolutions.net>
To: David Laight <david.laight.linux@gmail.com>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Date: Tue, 23 Jun 2026 19:50:01 +0200
In-Reply-To: <20260623163203.195416b4@pumpkin> (sfid-20260623_173213_713027_EF574A6E)
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
		<20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
		<202606182046.AE5F6A241@keescook>	<ajTlfuOFHXlA7xdu@ashevche-desk.local>
		<202606192025.CF68F2E@keescook>	<ajY5hg0f34C-iV3R@ashevche-desk.local>
		<54974e4298efd26a52c9c0e9ada88d57e8695a09.camel@sipsolutions.net>
		<ajqTpJAMFFV3H5Im@ashevche-desk.local> <20260623163203.195416b4@pumpkin>
	 (sfid-20260623_173213_713027_EF574A6E)
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:andriy.shevchenko@linux.intel.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:gustavoars@kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-38021-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 284B26B93F8

On Tue, 2026-06-23 at 16:32 +0100, David Laight wrote:
>=20
> Both those seem to contain multiple expansions of is_constexpr().
> I'd be surprised if __builtin_constant_p() wasn't good enough.
>=20
> I also wonder what kind of mess the object code looks like.

You should definitely wonder less out loud and only comment when you
have actual hard facts...

> I'd also worry whether the saturating maths in any way performs the corre=
ct check.
> I suspect the (non-saturated) value gets used for a kmalloc(),
> but that has much smaller valid (and sane) limits than can come out of th=
e above.

That's, frankly, ridiculous.

johannes

