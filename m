Return-Path: <linux-wireless+bounces-38808-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cKXAMcxET2rQdAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38808-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 08:50:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6261472D597
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 08:50:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=SUqbHg27;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38808-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38808-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 843B330518F6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 06:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341063BBA0D;
	Thu,  9 Jul 2026 06:45:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00323C945B;
	Thu,  9 Jul 2026 06:45:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579548; cv=none; b=YW0y3/sEqZ56uuyW8J2xVUyJyUH4aCF508cquwbwAnYdbG1MMwBosSJDNLUaugQI2bXh1+KcfrLql49G1qTBfNuJhnyhysFfADMCrzFRw8x5pCnhr4rtRWuVM2iWBerTZzT2GcuXd53V125sbU3AdG1DYnY6TaM+EkFpdHF0lcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579548; c=relaxed/simple;
	bh=ePf3TLUk8IumGoGVKjttBlVSijbu8aI5m/BkEk7IM+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aRNvYWo7kWEwx/WFWQycHWIBs9vDDQ2T8ZuZrzyL7RyQRRmRrTlPb6HiNNTzkD1+px/xwk5J2nDimDKEpk04+AZqAPIJFu7Fix+thV8eG533Udjbc2wAuoGMjCPt4hcjiQLE8rr+3LQpEIOdBCfKbl6IloleW9G7A6OyYC8+9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SUqbHg27; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ePf3TLUk8IumGoGVKjttBlVSijbu8aI5m/BkEk7IM+I=;
	t=1783579545; x=1784789145; b=SUqbHg272XU4+SOI0UZu9ywr3j2iCbrqNDM+5YLtz+R7vV4
	gIpgYgtnFT7vW6MvdFR8QQctljDcR7ZnhIM0tBAMUqihdhdVxlz5l9EEbzeykvXJt4XhxAElQYkEU
	ONHWLRjY+ASc8gHtYCjit+ZwDQvaQ2AYicmbRo45NgqQFLaKAfHTee2vr3+voHtyIVCOtlvjWsqpj
	M8KBEAn46TDQHMPeE0XES1K/uDN9qENvfAUU0lHcI3yrdji9WUFmwSkGhmuzDeni6+Eia6uliPW3R
	kJXsfISMloMQrRXjzbv61pJAXXT/higachtw61O8WGulU3gQnxCVCfkrLE5GVLkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1whiVr-00000007P9J-36CL;
	Thu, 09 Jul 2026 08:45:35 +0200
Message-ID: <3e8e6ff58a0809b0346d133c01eda720367eb511.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Fix cryptographic MAC comparison to be
 constant-time
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, linux-wireless@vger.kernel.org, 
 Jouni Malinen <jouni.malinen@oss.qualcomm.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 09 Jul 2026 08:45:35 +0200
In-Reply-To: <20260709024443.58132-1-ebiggers@kernel.org>
References: <20260709024443.58132-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-wireless@vger.kernel.org,m:jouni.malinen@oss.qualcomm.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38808-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6261472D597

On Wed, 2026-07-08 at 22:44 -0400, Eric Biggers wrote:
> To prevent timing attacks, the comparison of cryptographic message
> authentication codes (MACs) needs to have data-independent timing.
> Replace the memcmp() with the correct function, crypto_memneq().
>=20
> Fixes: 39404feee691 ("mac80211: FILS AEAD protection for station mode ass=
ociation frames")
> Cc: stable@vger.kernel.org

I guess I'll apply (a variant of) this patch for -next, but that commit
log really makes it sound like something is actually broken and needs
fixing, and I don't think that's true in this specific context.

What happens is that the frame is validated and then we associate
successfully (upon success) or drop the frame (upon failure). Only the
failure case is relevant for the timing issue, but in that case we
simply drop the frame and there isn't really an observable signal -
nothing else happens, at least not immediately, we may retry the request
later after a timer.

So sure, it looks better to have a crypto_memneq() in AES-SIV related
code, but in practice I don't see how it would make a difference now,
and it's even unlikely this code will ever matter for anything else in
the future, given that things are moving more and more towards full
frame encryption, including association request/response now.

I saw you originally had this in the "use libraries" patch [1], I'm also
good with you just keeping the change there. This might even be better
if you're planning to have this in -next soon, where it would otherwise
conflict if I keep this to -next.

[1] https://lore.kernel.org/linux-crypto/20260707053503.209874-24-ebiggers@=
kernel.org/

(The whole feature is also fairly much unused anyway in practice as far
as I can tell.)

johannes

