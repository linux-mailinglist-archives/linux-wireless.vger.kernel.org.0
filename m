Return-Path: <linux-wireless+bounces-27037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45406B450F3
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 10:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005CC3BC5E5
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E6F2FCC13;
	Fri,  5 Sep 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Jms7BAhN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC842045B7
	for <linux-wireless@vger.kernel.org>; Fri,  5 Sep 2025 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059907; cv=none; b=qpTWoIhL9nLQFdguWAO8pPG6ZS73P6rdLvG9lEws4/QQoco15yNTQqPuDw98lTsoKObOeIifpJXM6zr3yN9kBTEe+N/EY1qg3NI1/ysMpioEWl64wu1Ba4mPoQWIB+Kdg3zXE9DKJGI2z9ZGVdrLx4AVRVYPknZ5NMGxMh9jrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059907; c=relaxed/simple;
	bh=4df6tmqvUy2l5KKNSXB3MQ1JiHxa1dRJM6mu5uTinHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ix7FFoCisFWcLF6Sf1j34He5ZPRMF2/Po1PoPYBwIAeaHckIXtvR23tGtZN7si/qV1YoJykP+fAZOeMXNdJa1ER/reILABmZPxYbT3m8qvGud+wn+GtO12wwQu6t5unnWsq643755behDqA0uOBo42nMhVqkeXZ3W6XNoQQLTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Jms7BAhN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4df6tmqvUy2l5KKNSXB3MQ1JiHxa1dRJM6mu5uTinHI=;
	t=1757059906; x=1758269506; b=Jms7BAhNmvwiwgHv4N+NQcIDom5QyA3Sobb5Gej5n+bMZWw
	Z7O4lJWqyI6rIjb0uU8AYGMdVB/th23XdZ818O3+FpXZLyynpGN6Z3zx4p3qHzAvR/oRVydG9WdVQ
	V487F48esfQkf7DUeVLbVhvLskf/4+c3BKtrLi/KckBUf8P+DcC87Xcfey2hrltqcwd+Pr36+rYJC
	6ln1T8pHxEKPfC67+9CsAbaMdvwBBTrilGo0TkI3nNbhKxqpvTaR+g5smT1y8LVXBzlTdvGkOJeb+
	uPXJDwO7p8Lp1b6si//TImiqwhiCTlNaBQvczUqboMnrnN9yDR/UTflYNwr45NWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uuRXn-0000000GHd0-3GD9;
	Fri, 05 Sep 2025 10:11:40 +0200
Message-ID: <148507332947544aee0557f9d3bb9f4f77608c5d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: fix bss rbn double erase issue
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiazi Li <jqqlijiazi@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jiazi Li	 <jiazi.li@transsion.com>,
 linux-wireless@vger.kernel.org
Date: Fri, 05 Sep 2025 10:11:39 +0200
In-Reply-To: <20231215102144.GA2946@Jiazi.Li>
References: <20231025103304.22082-1-jiazi.li@transsion.com>
	 <b1358d256500d5bb6b3bbc312673c24b54b3674e.camel@sipsolutions.net>
	 <20231026013528.GA24122@Jiazi.Li>
	 <9d2e0cc7ec292a7a1ea26c43ada305f40bc22829.camel@sipsolutions.net>
	 <20231215102144.GA2946@Jiazi.Li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2023-12-15 at 18:21 +0800, Jiazi Li wrote:
> On Thu, Dec 14, 2023 at 02:13:38PM +0100, Johannes Berg wrote:
> > > >=20
> > > > Ok that's bad - so you hit the WARN_ON there? How that? We should f=
ix
> > > > that too?
> > > >=20
> > > Yes, hit this WARN_ON in the test of direct connection between mobile
> > > phones and PC. Here is the log:
> > > [ 2741.982362] -----------[ cut here ]-----------
> > > [ 2741.982446] WARNING: CPU: 6 PID: 2175 at net/wireless/scan.c:1496 =
cfg80211_update_assoc_bss_entry+0x350/0x378 [cfg80211]
> >=20
> > Right, so you can reproduce that - can you find a fix for it?
> >=20
>=20
> I am responsible for kernel stability and I am not very familiar with wir=
eless code.
> The colleague in charge of the WiFi module also couldn't find the root ca=
use, so we
> used the workaround solution I mentioned earlier to address this issue.

So you're going to have to fix it after all ;-)

Syzbot ran into the same problem [1], but I'm pretty convinced that with
a well-behaved driver, this should be practically impossible unless the
AP is also doing something weird. Your (non-upstream!) driver is likely
messing around with the BSS / scan reporting in weird ways while the AP
is doing CSA.

[1] https://syzkaller.appspot.com/bug?extid=3Ddc6f4dce0d707900cdea


Ultimately it comes down to the cfg80211 code tracking BSSes by the
(BSSID, channel) tuple rather than just BSSID, so if

 - you see a BSS (BSSID-x, 1)
 - you see a BSS (BSSID-x, 11)
 - you connect to e.g. the channel 11 one
 - then it channel switches to channel 1

you run into this issue.

I guess we must handle it _somehow_ if only to prevent attackers
triggering this, but right now I don't have a good idea. However, in
practice, it shouldn't happen since actual APs using the same BSSID on
different channels are extremely rare (if not never happening) these
days, chances are the driver is just reporting the duplicate BSSes in a
weird way.

johannes

