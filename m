Return-Path: <linux-wireless+bounces-25955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF8CB0FBCE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 22:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB967BB04E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 20:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16907234984;
	Wed, 23 Jul 2025 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="iS2la5vt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46041EE7B7;
	Wed, 23 Jul 2025 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303082; cv=none; b=uo4s5rTdQ5Y2tm5wSqBlRuuDDhDgKfXDCrWR1fYeBdgHvMqjEt6ZHHgsOCuKbcgekpXRuGBb75fsUG08oXEsejY/vo+uBFmO/FYmce5zRjqVH5I6P9MtYEvfPBPHZ3KhtraS4Wx4kdFFtlgF6R8x0iVAxu0h6sYziQlUEX/kEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303082; c=relaxed/simple;
	bh=KmXhhZPMrFNTrUJxnSSwxa9Ok7Q43AJ6e49hKjoO40E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcjBmmJOuv+T6iHkgcBBgHl5kPlHERrGtFhWM0SMeyT1TpmIHKT+tlmp8gm8FBtgTw9NIAMaaNlh/XV5qbdJA99WutoAu6hWumQreyrVkF69yyHuOYczrGII6xxajgOE74ncuObDjc/WojG0NhwMutmltgeFBpTXvEjAHBvGVA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=iS2la5vt; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A91E31C00C8; Wed, 23 Jul 2025 22:37:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1753303077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+bGbqZHdTTkebUn6GZq81jDrxOm8AEABKtzljHIkHk=;
	b=iS2la5vt0qIAS7liBI/Ao+fNqWwMmFngpqonlPPoQMLiNU3X2bZPi7V4y4XZ4RdZPvxrZJ
	4p1no3uo/S+E04QScuFGSue1hqQQE3ZL2ko5JXGbC8jSyx5jrP4i0dHYEK5HBT9LUOF/Ed
	W273THKhvB/HdFV1KgzXazms1whGze0=
Date: Wed, 23 Jul 2025 22:37:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
	will@kernel.org, longman@redhat.com,
	miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org,
	pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
Message-ID: <aIFH9I6b/tebYcEL@duo.ucw.cz>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz>
 <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz>
 <c5c06a93845f72b40c6df82fcbc89d3163a01d8b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYGBo1xBGZHT2Wmk"
Content-Disposition: inline
In-Reply-To: <c5c06a93845f72b40c6df82fcbc89d3163a01d8b.camel@sipsolutions.net>


--zYGBo1xBGZHT2Wmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Wed, 2025-07-23 at 17:42 +0200, Pavel Machek wrote:
> > [  402.125635] ------------[ cut here ]------------
> > [  402.125638] raw_local_irq_restore() called with IRQs enabled
> > [  402.125645] WARNING: CPU: 3 PID: 387 at kernel/locking/irqflag-debug=
=2Ec:10 warn_bogus_irq_restore+0x25/0x30
> > [  402.125654] Modules linked in:
> > [  402.125661] CPU: 3 UID: 0 PID: 387 Comm: kworker/u16:5 Tainted: G S =
                 6.16.0-rc7+ #303 PREEMPT(voluntary)=20
> > [  402.125667] Tainted: [S]=3DCPU_OUT_OF_SPEC
> > [  402.125668] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.=
43 ) 10/12/2016
> > [  402.125671] Workqueue: events_unbound cfg80211_wiphy_work
> > [  402.125678] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
> > [  402.125683] Code: 90 90 90 90 90 80 3d 51 3d dc 00 00 74 05 c3 cc cc=
 cc cc 55 48 c7 c7 c0 4f c9 85 48 89 e5 c6 05 38 3d dc 00 01 e8 9b d8 e6 fe=
 <0f> 0b 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
> > [  402.125686] RSP: 0018:ffffc9000173fb30 EFLAGS: 00010282
> > [  402.125691] RAX: 0000000000000000 RBX: ffffffff8616b460 RCX: 0000000=
000000000
> > [  402.125694] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 0000000=
0ffffffff
> > [  402.125696] RBP: ffffc9000173fb30 R08: 0000000028935f32 R09: 0000000=
000000001
> > [  402.125699] R10: 0000000000000044 R11: ffff888100ba52c8 R12: 0000000=
000000001
> > [  402.125702] R13: ffffc9000173fbcb R14: ffffffff84301224 R15: 0000000=
000000000
> > [  402.125704] FS:  0000000000000000(0000) GS:ffff88829007f000(0000) kn=
lGS:0000000000000000
> > [  402.125707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  402.125710] CR2: 000055967d471ee0 CR3: 0000000006046001 CR4: 0000000=
0000606b0
> > [  402.125713] Call Trace:
> > [  402.125716]  <TASK>
> > [  402.125719]  console_flush_all+0x41e/0x460
> > [  402.125725]  ? console_flush_all+0x43/0x460
> > [  402.125735]  console_unlock+0x55/0x100
> > [  402.125741]  vprintk_emit+0x157/0x320
> > [  402.125748]  vprintk_default+0x18/0x20
> > [  402.125752]  vprintk+0x9/0x10
> > [  402.125756]  _printk+0x52/0x70
> > [  402.125766]  ieee80211_sta_rx_queued_mgmt+0x4c8/0xd30
> > [  402.125775]  ? __this_cpu_preempt_check+0x13/0x20
> > [  402.125784]  ieee80211_iface_work+0x3ad/0x500
>=20
> That's not great, but I don't see how the driver or wifi subsystem is
> involved ... ieee80211_sta_rx_queued_mgmt() doesn't even use spinlocks
> let alone disable IRQs or use raw_ APIs, and it's in the middle of
> printk anyway.
>=20
> No idea what might be going on here, sorry.

So lets ask printk() people if they have some idea... / seen something
similar / ....?

									Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--zYGBo1xBGZHT2Wmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIFICwAKCRAw5/Bqldv6
8uZyAJ4nGqs1ozKcxQXQgIWP86q/al/0HQCfcMFSjZ5IzptYm/CAza4IzKmaHgs=
=VaB9
-----END PGP SIGNATURE-----

--zYGBo1xBGZHT2Wmk--

