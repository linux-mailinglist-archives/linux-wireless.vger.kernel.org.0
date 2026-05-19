Return-Path: <linux-wireless+bounces-36673-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCCYLwjRDGrImQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36673-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 23:07:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140E584FEB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 23:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7261302FA98
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14D3E2ACD;
	Tue, 19 May 2026 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="m7NDfQmG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh19-2.aruba.it (smtpdh19-2.aruba.it [62.149.155.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC853E2ADD
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224759; cv=none; b=vAA3MnbntFEMHEKDbyBY8rGF6NMlFPdLHFLgsc90SduFXq7enKGXWtNMqbLJ+Q5cdeVHOUM8mL9PtE7nJlcjl6XsLG0BQ5NbCcyWH7tdrX77vDfZ8HqVf1Na/AA8BqWnyjfE5yXCSpe95hjSXCP0f1PcHtSnIlvO1gC7PebYW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224759; c=relaxed/simple;
	bh=ujZgbuLmLq7XJpjZV4Ih/yi4oCXNZPTLTJydWGuDM5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKSE5udSviYp/TqVXFrnjiYx4gQQnkklN9UGvWjFbyxhWvAWnC5qFEOaERloSyA/OaQDqwouts/p1q6Ls5+UeCu1cslpvpnozXtgB4Qxk1FiaFiJ81LVV9dcIXAywztQxFWjUiWeNf7r25ZtGkhZcr9YA40Vj+q0nHPlqNDb2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=m7NDfQmG; arc=none smtp.client-ip=62.149.155.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from DELL-MOBILE03.ad.smart.it ([79.1.230.118])
	by Aruba SMTP with ESMTPSA
	id PRaMwASX8clBZPRaQwVBEu; Tue, 19 May 2026 23:02:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779224566; bh=ujZgbuLmLq7XJpjZV4Ih/yi4oCXNZPTLTJydWGuDM5w=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=m7NDfQmGvRbxNVrVY8UTUKLKUptB85R0iOmDyIjuYhVz2Lq9MzRpx7cr8YE8gTZd6
	 D7/F3/egDImxH8/Kix+/s3I/LsDqaMRTrczsS33HsKCfKfBniYFFu3xPa9ACIHb/fk
	 4+OWfCDw0Wmg2FL1qHeiIxm5M2qfgmFHkbOeNs9eziX4MvHlA3+10xKIX8Xj0ZLDZ4
	 18eATkSAeU4LI8G2ecyd9tp8Gm8LW0mKObz7m5wwI8MpYneb6hpsA5PkvYjeqmSQCI
	 yAb9rDl63uUieUeBxJDI+Wt7q1zlGHkiyRGBPGLqISWl1cSDAFPx+NWCOTToVZxqJR
	 ff5Wnf56DWqKg==
Date: Tue, 19 May 2026 23:02:41 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 kvalo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
Message-ID: <20260519230241.49489a8f@DELL-MOBILE03.ad.smart.it>
In-Reply-To: <20260519175812.7ce97ba1@barney>
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
	<20260519175812.7ce97ba1@barney>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CMAE-Envelope: MS4xfFgs5MMznpo/fxx8eqZIOPS7R3UkKsdWw4iyVw0Me6g6caCbCepXEDQTB8AIw/3XQvnN3kUUif//2Dejf9/I6AHJ14zINjx70Rou0Tf6piHZXJvE8/aa
 +IRCRemlvHAPe4XnRnCSUIhe4YN9iDiRrIr4sKR7qTPuVfi8Wy6k2i7tC2vecekZgVfRY7iXG0n3X1ocCIx3qm/mYG6VM8eLhS72qwUtSqzjnCduMmOa2nXe
 4YfLJlAZd+4NPlaIj3Qt0XPF+p6Uln/X4IlPwIVBx7q3Xt1/gP6HAgZoXs6N6vTmDQdXGEO8mRBFU9rtC+ScdgBYC8V2j3VhUUT0zAhqirosAUe8ECZtlYhx
 D7HBRY69
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36673-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[mythread.it:+]
X-Rspamd-Queue-Id: 1140E584FEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 17:58:12 +0200
Michael B=C3=BCsch <m@bues.ch> wrote:

> On Mon, 18 May 2026 03:49:33 +0200
> Alessio Ferri <alessio.ferri@mythread.it> wrote:
>=20
> > This series completes b43 support for the Broadcom N-PHY revision 8
> > paired with radio 2057 revision 8. b43 already supports the
> > surrounding PHY family - N-PHY rev 8 with radio 2057 rev 5 and rev
> > 7 are handled, and rev 16 with radio 2057 rev 9 is handled - but
> > the rev 8 + rev 8 combination falls through four dispatcher gaps: =20
>=20
> > Alessio Ferri (6):
> >   b43: add d11 core revision 0x16 to id table
> >   b43: route d11 corerev 22 to 24-bit indirect radio access
> >   b43: support radio 2057 rev 8
> >   b43: add IPA TX gain table for N-PHY r8 + radio 2057 r8
> >   b43: add channel info table for N-PHY r8 + radio 2057 r8
> >   b43: add RF power offset for N-PHY r8 + radio 2057 r8 =20
>=20
>=20
> In general this looks Ok.
> From the style I assume that this is AI generated, right?
> If so, can you tell us a bit more about the inputs used for the AI?
> What information is this implementation based on?
>=20

The patchset is tested on my own DLink DSL 3580L router and generated by
claude from our shared notes, i then reviewed it for sanity and
verified it by navigating from the router with modified b43 driver with
my phone.
The shared notes were: logs and dumps taken from the proprietary binary
driver while running the stock firmware in the router, files from
brcmsmac that had some details for rev 22, GPL released broadcom code
in the GPL dump of the vendor, .rodata pieces from the binary driver and
finally logs and dumps from the live b43 running in the router flashed
with openwrt. Gathering all of this was a week long task, and writing
code was only a small part of it, like in the 5% range.

