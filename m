Return-Path: <linux-wireless+bounces-38727-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jw4MIH+2TGpBogEAu9opvQ
	(envelope-from <linux-wireless+bounces-38727-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 10:19:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38820719001
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 10:19:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=vwx7+Pw7;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38727-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38727-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8ECA30067B7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A4B30E0E4;
	Tue,  7 Jul 2026 08:19:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E32EDD7D;
	Tue,  7 Jul 2026 08:19:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412349; cv=none; b=qrcE5MnJj856NBB2v0PCRNWgCn+H5XQ/hJ4utoanEFS7QtbXvMr1wooT67iuBEHXns/NzbPJNBw7r86gtdbYJ72iYRKIdEB7LPuCeFaNwfi8kC1GNx1Z6NaENHvT7R19Oe/Id6v8sMumqM6xY1Qqc+wxiblRu+IsNw/s7w9g1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412349; c=relaxed/simple;
	bh=5QLkLIV6dWz+yM8AXGu8lDkyyoQEzGcB9XsMrlJbli4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArGHk9YyEaDqMtCHuk0aTbLIQOhU8IlA3241XHp38hcBER2IouNjv219o6bXRBgiGBqV5QVWOQbiqGBQRfz4vPQnB0E8y/NshtnJD6fol9MrzF7CU6xwhDN13OeeLryhk2fsgBTOeI+Trbon23mp03h6QDk5OqwNRkbI4TPdrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vwx7+Pw7; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j9g61QJ16IaAdUYswmT5n+XykLyw2Vj431tO+JQ6hDY=;
	t=1783412347; x=1784621947; b=vwx7+Pw7842ZAm0GYZOHB0iGTxDD974PSM3jIz4CNVa1QlY
	0pUtm7sa0hhsX4mHIhL4KY3vblQUwvkAxW7WBXiDwqJEl2dZO2q/alASrDM7ltalILWou8eWwOfn6
	DJ4ZEfN1MIr+cIkYVA4rJYwAdagb1FcgIfsMBQUq3snKhZ33fY1g3JcVIWdGTcv5ikXSsFcpUhCFY
	dFo6pH1FFBvOjORd5VyGjSdayAp0U3uESj/H+PS3M590OJr5n9bKoR+5jHCdDXjVsqRs9OJu+/pTP
	b7Cw4LkdCeUe9BnV8lbUZEx4S4eSSrNWZnCod+6Ods4TZf7zzxR3Y1zBMrg0mEUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wh11D-0000000HRe4-0mFW;
	Tue, 07 Jul 2026 10:19:03 +0200
Message-ID: <2d0a7285a8e90ee2de658b564b739ed735fb3fd1.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] MIPS: BCM47XX: convert buttons to software nodes
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=	 <zajec5@gmail.com>, Michael Buesch
 <m@bues.ch>, Hauke Mehrtens <hauke@hauke-m.de>,  Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org
Date: Tue, 07 Jul 2026 10:19:02 +0200
In-Reply-To: <20260704-b4-bcm47xx-swnode-v1-0-730d59340237@gmail.com>
References: <20260704-b4-bcm47xx-swnode-v1-0-730d59340237@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmitry.torokhov@gmail.com,m:zajec5@gmail.com,m:m@bues.ch,m:hauke@hauke-m.de,m:tsbogend@alpha.franken.de,m:brgl@kernel.org,m:arnd@arndb.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,bues.ch,hauke-m.de,alpha.franken.de];
	TAGGED_FROM(0.00)[bounces-38727-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38820719001

On Sat, 2026-07-04 at 22:25 -0700, Dmitry Torokhov wrote:
> This series converts the legacy gpio-keys platform device on BCM47XX
> boards to use software nodes and static properties.
>=20
> To do this properly without relying on legacy name-based matching
> (which is being removed from gpiolib), we introduce and register
> software nodes for the underlying GPIO controllers (BCMA and SSB)
> and reference them in the button properties.
>=20
> The first two patches add the software nodes to bcma-gpio and
> ssb-gpio respectively. The third patch performs the conversion
> for the BCM47XX buttons.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> Dmitry Torokhov (3):
>       bcma: gpio: Add and register software node for GPIO controller
>       ssb: gpio: Add and register software node for GPIO controller
>       MIPS: BCM47XX: Convert buttons to software nodes

Seems like most of the change in in MIPS and it should all go through
that tree. For the record, that's OK with wireless regarding bcma/ssb.

johannes

