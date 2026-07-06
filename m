Return-Path: <linux-wireless+bounces-38683-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 33tcJ2CzS2oMYwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38683-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:53:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9884711881
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:53:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=PzFXmXBo;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38683-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38683-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E08D30A86E6
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85363A641D;
	Mon,  6 Jul 2026 12:14:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340A424641;
	Mon,  6 Jul 2026 12:14:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340053; cv=none; b=DnnjPTlFEnVZtUB8GtsCiijs80in+DgysK6vvIp1/TQmzZkv1vxYU4UhnUO7gzWwR/igqceFcxKKhXPYTOlgkNa1gMxdpsHDKGiRBMJzBmsJZWpb6Xx69le6rMzHKzneaLRrUs+oEnhsDrPc+uWJ0M2EUS3LJ8nPgOzqN3IeEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340053; c=relaxed/simple;
	bh=WTtT+PoMZJ7gTWJcpPE66WFxlwYlhRV3UI7d+ONvi2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qG0p87CHnmZTkktnN89bdKtImV1LhOcrIP/WgFfvCQ3g8TP3gM4wiqy0WMeSzuggvvBnpM9SUKGVmoxSqTud/4l6Fhw68s3cl5XLB5/S/GwTZ5YD9rEX1ztrsciQye2N/Kts5XWTCkHQLMt9yBUxwz2x4ZoOsP84c128eQ4bmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PzFXmXBo; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WTtT+PoMZJ7gTWJcpPE66WFxlwYlhRV3UI7d+ONvi2Y=;
	t=1783340051; x=1784549651; b=PzFXmXBouuFr2GgKtRCwa6ZAF6aXvfSb/Kq6vtjH+dO3Jdc
	dw1fZepYEmlkhfkbtES0Yj0LCTIyzQKJ0QT0VhLGlKrDB5p8nvtyfBCsW/JD2AVMdLZ2kHdULTD4a
	bNl5nVXvvfhhyBaEqaXhbz6ajhFJ6yRxBS07IiaXG2EMH7hZm0q98cYqXoEEVlDsFuSiXaRF5lfyw
	X+LeiZwYjqPDCN4XH59LifFs88j7a0dnuSdPGFTVYo2+dRITsy+GJGs214TBxa9MDLJFfkGh0ALHP
	M8cqHkoQcTHJeOYj67kV09dryIZX2971FiYdU8xeKXG7fN/a0ruHLivhS8OmP+4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wgiDA-0000000DOiG-3RDB;
	Mon, 06 Jul 2026 14:14:08 +0200
Message-ID: <2ef7b2562e58be6d5b833b500eb8074c5a535151.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211_hwsim: remove radios from rhashtable
 before freeing
From: Johannes Berg <johannes@sipsolutions.net>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Date: Mon, 06 Jul 2026 14:14:08 +0200
In-Reply-To: <CAFRLqsXZYTC-AZr76+Dgj8THPqpz50-g3rH+zCg+HvD9G4QUdw@mail.gmail.com> (sfid-20260706_141054_781359_88E02C24)
References: <20260619162419.3874564-1-zzzccc427@gmail.com>
	 <ab97c01b73b96bf36527007e19743d3bb5a07634.camel@sipsolutions.net>
	 <CAFRLqsXZYTC-AZr76+Dgj8THPqpz50-g3rH+zCg+HvD9G4QUdw@mail.gmail.com>
	 (sfid-20260706_141054_781359_88E02C24)
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zzzccc427@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38683-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9884711881

On Mon, 2026-07-06 at 20:10 +0800, Cen Zhang wrote:
> Hi Johannes,
>=20
> > How does the init even fail? I think this is fairly contrived,
> > especially in a test tool. The whole thing is maybe worth a cleanup, bu=
t
> > the whole scary commit message is nonsense.
> >=20
> > johannes
>=20
> Thanks for your review.
>=20
> The init failure I had in mind is a late one after radios have already
> been created and inserted into hwsim_radios_rht, for example in the
> monitor netdev setup after the radio loop. My local validation used
> fault injection at dev_alloc_name() plus a bounded debug delay to make
> that unwind window observable.

Yeah, I guess it _could_ technically happen, though I think the memory
allocation failures should be virtually impossible here. And it's hwsim
after all.

> That means the test shows the cleanup ordering issue, but it is indeed
> contrived, especially for mac80211_hwsim. The changelog I sent made this
> sound much scarier than it should have, and including the long KASAN
> report was not helpful.

Fair.

> The actual change I wanted is just the small consistency cleanup:
> mac80211_hwsim_free() should remove data->rht before freeing the radio,
> like the other radio removal paths already do.

I'd apply this, or maybe a reverse of ordering (making things visible
only after the radios exist), but please resend.

Also, if it's going to be this version, we don't really need
hwsim_radios_generation I think, anyway it's all going away so
consistency to userspace is effectively already dead at that point.

johannes

