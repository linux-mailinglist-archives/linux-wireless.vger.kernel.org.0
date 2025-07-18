Return-Path: <linux-wireless+bounces-25648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AFCB09DDF
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 10:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621123B989C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750D51CA84;
	Fri, 18 Jul 2025 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gat9Nxr4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C442475F2
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827225; cv=none; b=rghgdiCOC/ZnW30POtlDVAZh0CAfMFKd27WGv9F1gCQxeM8ixvSqRRx1Gjx4wVSlI05PUr3BFp2bt4ftz+lcQKa9UBmhVk4qDMXpylrharOtkzE6O5wSLmHiVJd5X34dYYhebprd8LFqPQEyucfgSNpDyb8encskgHD3rv0/+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827225; c=relaxed/simple;
	bh=BBOwJ5X/BVe4WsXyocTgApgwQeS8sw3QrTYsxjJHIGg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pk+As6g0x4zeR/I6E/WiP95AjiiMICexaPiW5CkXtu3L6Pjl4+H0Bal/0prwCl23e3a8b+zJqkdX4x85oyJI07jy4ZhgYQ6bmSSLhppw9WYkC2m4b+6M78jtVQ5IiQ112vXPWj1emyETr149cDPoyMfwrOsKsmeIcQWHLIIuVjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gat9Nxr4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BBOwJ5X/BVe4WsXyocTgApgwQeS8sw3QrTYsxjJHIGg=;
	t=1752827223; x=1754036823; b=gat9Nxr4k8/p74MrkgmfgJnQp2gh0dcQM+nOPvSHeWU2n/h
	dHwzINgkYaYoGmV9OAn+OCN403p5PT3ONPKOjde9KwxBZDPBy9rgkdLpAQ2gq95By8NRuIzzR4fYJ
	FNZf0B2vGW1vtCMGt44yMKHQHN3/arsfUcrDaykhMwbYszN6Fz1bsyaY+7XqBfYmu8kXvDb5tNREF
	C7hxuSbr6VO/PjzhJjBxRV6xG3MGmuNoMkE1yVLm9wAdPRGXQM1hgekAfJUw661vlXYXVZ6Ofr2Jv
	Ge0uWZS8nCjimWKKu9nnpwsGEpL/9Hs7UkSztceqKMeVlrZSHdRUcTXnkAn1ANEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ucgQT-0000000CN45-40Tj;
	Fri, 18 Jul 2025 10:26:44 +0200
Message-ID: <7b840730a87a30d19989aa027ae0e752879746ed.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: cfg80211: remove scan request n_channels
 counted_by
From: Johannes Berg <johannes@sipsolutions.net>
To: Kees Cook <kees@kernel.org>
Cc: linux-wireless@vger.kernel.org, Haoyu Li <lihaoyu499@gmail.com>
Date: Fri, 18 Jul 2025 10:26:37 +0200
In-Reply-To: <202507171651.8E89C32F4@keescook>
References: 
	<20250714142130.9b0bbb7e1f07.I09112ccde72d445e11348fc2bef68942cb2ffc94@changeid>
	 <202507142200.D315742C@keescook>
	 <adb4d011c640aacb2273f81a4ad6e658ea2f52f1.camel@sipsolutions.net>
	 <202507171651.8E89C32F4@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-07-17 at 17:05 -0700, Kees Cook wrote:
> > But I'm also not completely sure I've convinced myself that all the
> > above discussion about allocated vs. used is really the _entire_
> > explanation for it being such a spectacular failure here.
>=20
> I think it's a big part of it -- having the counted member change after
> initial assignment is even frowned upon by the compiler folks, but is
> technically supported.

Right. So since I wrote the above, I've come to think that while it'd
almost certainly fix this issue, the num_channels had another side
effect of validating the *read* side in cases like this. While we may
allocate 25 channels, if we're only using 2 then reading the 10th would
be a bug since it's not been initialized (OK, it's probably NULL, but
still not filled to a valid value.)

So in some way, you almost want to be able to separate the two and write
__counted_by(write=3Dn_alloc, read=3Dn_used), but I guess I don't see
compilers supporting that any time.

I guess the only other way around it would be to re-allocate it all the
time, but that's also annoying in other ways (possibly context, copying
other large things in it, etc.)

> Anyway, sorry again for the wasting of time of yours (and others) that I
> caused with this -- I really wasn't expecting it to go that way, and it
> hasn't been anywhere near as troublesome in other areas of the kernel,
> so it took me by surprise. I have tried to chase down and fix the glitche=
s
> when I became aware of them, FWIW.

Sure, I know, and thanks for that.

> I'll see if I can write up some patches for comments like you suggest
> above with good "proof" attached to them. :)

Thanks, help re-reviewing these is much appreciated.

johannes

