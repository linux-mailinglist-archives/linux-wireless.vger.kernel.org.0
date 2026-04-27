Return-Path: <linux-wireless+bounces-35342-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNdHGxMg72ml6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-35342-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 10:36:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5F46F2C0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 10:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA3493012CC0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CAA399015;
	Mon, 27 Apr 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CI1A/ePC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7895399375;
	Mon, 27 Apr 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278606; cv=none; b=aggM+CloF2aTy+JsN1OzWKv2C8VfQij9EZzZPZRhpqzQa5Zj8MknGJetKW1CEaLQJLYldkYoKPNlk8MJ0LsEa5YsZraCdu9T/ZZ9JigvH/8DKHH9/VFS4gW7iGUN+uHT1QUaqJW837AC7U7+dSU/j4r1ULLmAblCH1G+p3yoL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278606; c=relaxed/simple;
	bh=J+KZuJ+vJRzUEoUQtQeS5fdJnRKi3NFoXrjT3B1VtVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pQTZgNlGRkcBR5WJabDHAqZkenTgUcWtQLu3S5jryOZBvGcsrrjZRKZpYMOCsvMRA2345HNBU29HizuIDA9RTKUrRRFJG2fQF2Zl/4YA7B15F93bqmAEjIEiqGzB7rxArLqsH+weDM0uezwvj9fR4Ao3LKmYEaAf4gLvg8DfrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CI1A/ePC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nXIok8hG8UF6yHkdapezYbfZnnwbb/+IZZVyVDYQA+4=;
	t=1777278604; x=1778488204; b=CI1A/ePCJS6RKmGXLfskpbGvrv9kGSR5CiLZ4Ch0iGL0qb5
	HZr5D++4WhgshA4BKO/yxPvC4lKwOWyqEUyYEgaf0EkPFBU9chFdyRuPyRSycIdxoxi6AZ6B1XxTA
	p2EanXpPzBbF87NxN7GIsfa23Q6EMB6RRVcmVRryiSjVPh4VjlvuM2otpLxl55j8QgrOEvRV3vXId
	jDzPghbgfhdLBD81Qhmu8rIv1t13wQmvCRXhzQWBbjlMYdUNKFMQFJPKMkKhV13uTEI3V36SxWiaf
	/naPWQ+VH4IwZHOMPJtiTDnj3CVsQ5Mz6yOB5ozXknypCAL0yRXEYjHQO7C5hnoQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHHLG-0000000EXjF-34ki;
	Mon, 27 Apr 2026 10:29:23 +0200
Message-ID: <dc1b12e74b3f487eb531bf7def806f10d9a18b5e.camel@sipsolutions.net>
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
From: Johannes Berg <johannes@sipsolutions.net>
To: Yury Norov <ynorov@nvidia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov	 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin"	 <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra	 <peterz@infradead.org>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Andy Shevchenko	
 <andy@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, Richard Cochran	
 <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Yury Norov	
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Hans
 de Goede <hansg@kernel.org>, Linus Walleij <linusw@kernel.org>, Sakari
 Ailus	 <sakari.ailus@linux.intel.com>, Salah Triki <salah.triki@gmail.com>,
 Achim Gratz <Achim.Gratz@stromeko.de>, Ben Collins <bcollins@watter.com>, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Date: Mon, 27 Apr 2026 10:29:21 +0200
In-Reply-To: <aeub59FBHbCy-KKP@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	 <20260417173621.368914-2-ynorov@nvidia.com>
	 <6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
	 <aeub59FBHbCy-KKP@yury>
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
X-Rspamd-Queue-Id: E9D5F46F2C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35342-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,realtek.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,stromeko.de,watter.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, 2026-04-24 at 12:35 -0400, Yury Norov wrote:
> > I (personally) tend to prefer the "__MAKE_OP" versions (*_get_bits()
> > etc.), in particular because WiFi and firmware interfaces deal a lot
> > with fixed endian fields.
>=20
> I don't like that __MAKE_OP magic because whatever it generates is not
> greppable. And because we disable strict type checks for kernel, but
> this API claims to typecheck the parameters for the user. So, the
> following compiles well:
>=20
>         u64 val =3D 0;
>         ret =3D le16_get_bits(val, GENMASK(15, 10));
>=20
> I don't like autogeneration in general. We generate, for example,
> be32_get_bits(), but never use it.

That's a lot of "I don't like", but whatever.


> We don't even know the level of the bloat.

These are static inlines so there's no binary cost, and given that
you're complaining about them being generated you can't really *also*
complain about too much code...
=20
> > Any chance it'd be simple to generate u32_get_bits_signed() etc.? Could
> > be especially useful for le32_get_bits_signed() for example, to have th=
e
> > endian conversion built-in unlike FIELD_GET_SIGNED().
>=20
> Maybe this:
>=20
>         FIELD_GET_SIGNED(mask, le32_to_cpu(reg))

Awful. "I don't like". But we rarely deal with bit-packed signed values
anyway.

johannes

